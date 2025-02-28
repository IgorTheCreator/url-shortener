import * as crypto from 'node:crypto'
import fp from 'fastify-plugin'
import { FastifyInstance } from "fastify";
import { ICredentials } from './interfaces';

declare module 'fastify' {
  interface FastifyInstance {
    utils: {
      generateSalt: () => string,
      hashData: (data: string, salt: string) => string
      compare: (data: string, salt: string, hash: string) => boolean
    }
    authService: {
      register: (credentials: ICredentials) => Promise<{ id: string }>
      login: (credentials: ICredentials) => Promise<{ accessToken: string }>
    }
  }
}

async function authAutoHooks(server: FastifyInstance) {
  const users = server.prisma.user

  server.decorate('utils', {
    generateSalt() {
      return crypto.randomBytes(16).toString('base64')
    },
    hashData(data, salt) {
      return crypto.pbkdf2Sync(data, salt, 100000, 64, 'sha512').toString('base64')
    },
    compare(data, salt, hash) {
      return hash === this.hashData(data, salt)
    },
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
            password: hash,
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
            id: true
          }
        })
        if (!user) throw server.httpErrors.badRequest('Invalid login or password')

        const isValidPassword = server.utils.compare(password, user.salt, user.password)
        if (!isValidPassword) throw server.httpErrors.badRequest('Invalid login or password')

        const payload = { id: user.id }
        const accessToken = server.jwt.sign(payload)
        return { accessToken }
      } catch (e) {
        server.log.error(e)
        if (e.statusCode < 500) throw e
        throw server.httpErrors.internalServerError('Something went wrong')
      }
    }
  })

}

export default fp(authAutoHooks, { encapsulate: true, dependencies: ['prisma'] })