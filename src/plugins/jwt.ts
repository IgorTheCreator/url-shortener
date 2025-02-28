import { FastifyInstance, FastifyReply, FastifyRequest } from 'fastify'
import fp from 'fastify-plugin'
import fastifyJwt from '@fastify/jwt'
import { Role } from '@prisma/client'
import { AsyncTask, CronJob } from 'toad-scheduler'

declare module 'fastify' {
  interface FastifyInstance {
    authenticate: (
      ...roles: Role[]
    ) => (request: FastifyRequest, reply: FastifyReply) => Promise<void>
    refresh: (request: FastifyRequest, reply: FastifyReply) => Promise<void>
  }
}

async function jwtPlugin(server: FastifyInstance) {
  const refreshTokens = server.prisma.refreshToken

  server.register(fastifyJwt, {
    secret: process.env.JWT_TOKEN_SECRET,
    sign: {
      expiresIn: '1h'
    }
  })

  server.decorate('authenticate', function authenticate(...roles) {
    return async function auth(request: FastifyRequest, reply: FastifyReply) {
      try {
        const payload = await request.jwtVerify<{ id: string; role: Role }>()
        if (roles.length > 0 && !roles.includes(payload.role)) {
          throw server.httpErrors.unauthorized()
        }
      } catch (e) {
        reply.send(e)
      }
    }
  })

  server.decorate('refresh', async function refresh(request, reply) {
    try {
      const refreshToken = await refreshTokens.findUnique({
        where: {
          token: request.cookies['refreshToken'],
          expiresAt: {
            gte: new Date().toISOString()
          }
        }
      })
      if (!refreshToken) throw server.httpErrors.unauthorized()
    } catch (e) {
      reply.send(e)
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

export default fp(jwtPlugin, { name: 'jwt', dependencies: ['cookie', 'prisma'] })
