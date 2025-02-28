import { FastifyInstance, FastifyReply, FastifyRequest } from 'fastify'
import { FastifyPluginAsyncZod } from 'fastify-type-provider-zod'
import {
  CREDENTIALS_SCHEMA,
  LOGIN_RESPONSE_SCHEMA,
  LOGOUT_RESPONSE_SCHEMA,
  REFRESH_RESPONSE_SCHEMA,
  REGISTER_RESPONSE_SCHEMA
} from './schemas'
import fp from 'fastify-plugin'
import { ICredentials } from './interfaces'
import { Role } from '@prisma/client'

const authRoutes: FastifyPluginAsyncZod = async function authRoutes(server: FastifyInstance) {
  server.post(
    '/register',
    {
      schema: {
        body: CREDENTIALS_SCHEMA,
        response: {
          201: REGISTER_RESPONSE_SCHEMA
        },
        tags: ['auth']
      }
    },
    async function register(reqeust: FastifyRequest<{ Body: ICredentials }>, reply: FastifyReply) {
      reply.code(201)
      return server.authService.register(reqeust.body)
    }
  )

  server.post(
    '/login',
    {
      schema: {
        body: CREDENTIALS_SCHEMA,
        response: {
          200: LOGIN_RESPONSE_SCHEMA
        },
        tags: ['auth']
      }
    },
    async function login(reqeust: FastifyRequest<{ Body: ICredentials }>, reply: FastifyReply) {
      const { accessToken, refreshToken } = await server.authService.login(reqeust.body)

      reply.code(200)
      reply.setCookie('refreshToken', refreshToken, {
        httpOnly: true,
        path: '/',
        sameSite: true
      })
      return { accessToken }
    }
  )

  server.post(
    '/logout',
    {
      onRequest: [server.authenticate()],
      schema: {
        response: {
          200: LOGOUT_RESPONSE_SCHEMA
        }
      }
    },
    async function logout(request: FastifyRequest, reply: FastifyReply) {
      const refreshToken = request.cookies['refreshToken']

      reply.code(200)
      return server.authService.logout(refreshToken)
    }
  )

  server.post(
    '/refresh',
    {
      onRequest: [server.refresh],
      schema: {
        response: {
          200: REFRESH_RESPONSE_SCHEMA
        }
      }
    },
    async function refresh(request: FastifyRequest, reply: FastifyReply) {
      const cookieRefreshToken = request.cookies['refreshToken']
      const { accessToken, refreshToken } = await server.authService.refresh(cookieRefreshToken)

      reply.code(200)
      reply.setCookie('refreshToken', refreshToken, {
        httpOnly: true,
        path: '/',
        sameSite: true
      })
      return { accessToken }
    }
  )

  server.get(
    '/test',
    { onRequest: [server.authenticate(Role.ADMIN, Role.USER)] },
    async function test(request: FastifyRequest) {
      return request.user
    }
  )
}

export default fp(authRoutes, { name: 'auth-routes', encapsulate: true })
