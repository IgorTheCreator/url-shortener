import { FastifyInstance, FastifyReply, FastifyRequest } from 'fastify'
import fp from 'fastify-plugin'
import fastifyJwt from '@fastify/jwt'
import { Role } from '@prisma/client'
import { IPayload } from '../shared/interfaces'
import { JWT_OPTIONS } from '../configs'

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

  server.register(fastifyJwt, JWT_OPTIONS)

  server.decorate('authenticate', function authenticate(...roles) {
    return async function auth(request: FastifyRequest, reply: FastifyReply) {
      try {
        const payload = await request.jwtVerify<IPayload>()

        const blacklistedToken = await server.redis.get(payload.sessionId)
        if (blacklistedToken) throw server.httpErrors.unauthorized()

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
}

export default fp(jwtPlugin, { name: 'jwt', dependencies: ['cookie', 'prisma'] })
