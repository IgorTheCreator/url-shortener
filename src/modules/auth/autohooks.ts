import * as crypto from 'node:crypto'
import { FastifyInstance } from 'fastify'
import fp from 'fastify-plugin'
import { IAuthResponse, ICredentials, ILogoutResponse } from './interfaces'
import { AsyncTask, CronJob } from 'toad-scheduler'
import { PrismaClientKnownRequestError } from '@prisma/client/runtime/library'
import { IPayload } from 'src/shared/interfaces'

declare module 'fastify' {
  interface FastifyInstance {
    utils: {
      generateSalt: () => string
      hashData: (data: string, salt: string) => string
      compare: (data: string, salt: string, hash: string) => boolean
    }
    authService: {
      register: (credentials: ICredentials) => Promise<{ id: string }>
      login: (credentials: ICredentials) => Promise<IAuthResponse>
      logout: (
        refreshToken: string,
        accessToken: string,
        sessionId: string
      ) => Promise<ILogoutResponse>
      refresh: (refreshToken: string) => Promise<IAuthResponse>
    }
  }
}

async function authAutoHooks(server: FastifyInstance) {
  const users = server.prisma.user
  const refreshTokens = server.prisma.refreshToken
  const REFRESH_TOKEN_VALID_DAYS = 7

  server.decorate('utils', {
    generateSalt() {
      return crypto.randomBytes(16).toString('base64')
    },
    hashData(data, salt) {
      return crypto.pbkdf2Sync(data, salt, 100000, 64, 'sha512').toString('base64')
    },
    compare(data, salt, hash) {
      return hash === this.hashData(data, salt)
    }
  })

  server.decorate('authService', {
    async register({ email, password }) {
      try {
        const existingUser = await users.findUnique({
          where: {
            email
          }
        })
        if (existingUser) {
          throw server.httpErrors.conflict('User already exists')
        }

        const salt = server.utils.generateSalt()
        const hash = server.utils.hashData(password, salt)
        const user = await users.create({
          data: {
            email,
            salt,
            password: hash
          },
          select: {
            id: true
          }
        })

        return { id: user.id }
      } catch (e) {
        server.log.error(e)
        if (e.statusCode < 500) throw e
        throw server.httpErrors.internalServerError('Something went wrong')
      }
    },
    async login({ email, password }) {
      try {
        const user = await users.findUnique({
          where: {
            email
          },
          select: {
            password: true,
            salt: true,
            id: true,
            role: true
          }
        })
        if (!user) throw server.httpErrors.badRequest('Invalid login or password')

        const isValidPassword = server.utils.compare(password, user.salt, user.password)
        if (!isValidPassword) throw server.httpErrors.badRequest('Invalid login or password')

        const payload: IPayload = {
          id: user.id,
          role: user.role,
          sessionId: `${user.id}-${Date.now()}`
        }
        const accessToken = server.jwt.sign(payload)
        const refreshToken = crypto.randomUUID()
        await refreshTokens.create({
          data: {
            token: refreshToken,
            userId: user.id,
            expiresAt: new Date(
              new Date().setDate(new Date().getDate() + REFRESH_TOKEN_VALID_DAYS)
            ).toISOString()
          }
        })
        return { accessToken, refreshToken }
      } catch (e) {
        server.log.error(e)
        if (e.statusCode < 500) throw e
        throw server.httpErrors.internalServerError('Something went wrong')
      }
    },
    async refresh(refreshToken) {
      try {
        const token = await refreshTokens.findUnique({
          where: {
            token: refreshToken
          },
          select: {
            userId: true,
            user: {
              select: {
                role: true
              }
            }
          }
        })
        await refreshTokens.delete({
          where: {
            token: refreshToken
          }
        })

        const newRefreshToken = crypto.randomUUID()
        await refreshTokens.create({
          data: {
            token: newRefreshToken,
            userId: token.userId,
            expiresAt: new Date(
              new Date().setDate(new Date().getDate() + REFRESH_TOKEN_VALID_DAYS)
            ).toISOString()
          }
        })

        const payload = { id: token.userId, role: token.user.role }
        const accessToken = server.jwt.sign(payload)
        return { accessToken, refreshToken: newRefreshToken }
      } catch (e) {
        server.log.error(e)
        if (e.statusCode < 500) throw e
        throw server.httpErrors.internalServerError('Something went wrong')
      }
    },
    async logout(refreshToken, accessToken, sessionId) {
      try {
        server.redis.set(sessionId, accessToken, 'EX', 7200)
        await refreshTokens.delete({
          where: {
            token: refreshToken
          }
        })

        return { message: 'User logged out' }
      } catch (e) {
        server.log.error(e)
        if (e instanceof PrismaClientKnownRequestError && e.code === 'P2025') {
          throw server.httpErrors.notFound()
        }
        if (e.statusCode < 500) throw e
        throw server.httpErrors.internalServerError('Something went wrong')
      }
    }
  })

  const clearRefreshTokensTask = new AsyncTask(
    'clear expired refresh token',
    async function clearRefreshTokens() {
      await refreshTokens.deleteMany({
        where: {
          expiresAt: {
            lt: new Date().toISOString()
          }
        }
      })
    },
    async function clearRefreshTokensErrorHandler(e) {
      server.log.error(e)
    }
  )
  const clearRefreshTokensJob = new CronJob({ cronExpression: '0 0 * * 0' }, clearRefreshTokensTask)

  server.ready().then(() => {
    server.scheduler.addCronJob(clearRefreshTokensJob)
  })
}

export default fp(authAutoHooks, {
  encapsulate: true,
  dependencies: ['prisma', 'sensible', 'keydb']
})
