import { FastifyInstance, FastifyReply, FastifyRequest } from 'fastify'
import fp from 'fastify-plugin'
import { FastifyPluginAsyncZod } from 'fastify-type-provider-zod'
import { Role } from '@prisma/client'
import {
  CHANGE_STATUS_BODY_SCHEMA,
  CHANGE_STATUS_PARAMS_SCHEMA,
  CHANGE_STATUS_RESPONSE_SCHEMA,
  REDIRECT_SCHEMA,
  SHORT_URL_RESPONSE_SCHEMA,
  SHORT_URL_SCHEMA
} from './schemas'
import { Redirect, ShortUrl, StatusBody, StatusParams } from './types'
import { IPayload } from 'src/shared/interfaces'

const urlsRoutes: FastifyPluginAsyncZod = async function urlsRoutes(server: FastifyInstance) {
  server.post(
    '/short',
    {
      onRequest: [server.authenticate(Role.USER, Role.ADMIN)],
      schema: {
        body: SHORT_URL_SCHEMA,
        response: {
          201: SHORT_URL_RESPONSE_SCHEMA
        },
        tags: ['urls']
      }
    },
    async function shortUrl(request: FastifyRequest<{ Body: ShortUrl }>, reply: FastifyReply) {
      const { id } = request.user as IPayload
      reply.code(201)
      return server.urlsService.shortUrl(request.body, id)
    }
  )

  server.get(
    '/:short',
    { schema: { params: REDIRECT_SCHEMA, tags: ['urls'] } },
    async function redirect(request: FastifyRequest<{ Params: Redirect }>, reply: FastifyReply) {
      const { long } = await server.urlsService.redirect(request.params)
      reply.redirect(long)
    }
  )

  server.patch(
    '/:short',
    {
      onRequest: [server.authenticate(Role.ADMIN)],
      schema: {
        params: CHANGE_STATUS_PARAMS_SCHEMA,
        body: CHANGE_STATUS_BODY_SCHEMA,
        response: {
          204: CHANGE_STATUS_RESPONSE_SCHEMA
        },
        tags: ['urls']
      }
    },
    async function changeStatus(
      request: FastifyRequest<{ Body: StatusBody; Params: StatusParams }>,
      reply: FastifyReply
    ) {
      const { isActive } = request.body
      const { short } = request.params
      const { id } = request.user as IPayload
      await server.urlsService.changeStatus({ short, isActive }, id)
      reply.code(204)
    }
  )
}

export default fp(urlsRoutes, { encapsulate: true, name: 'urls-routes' })
