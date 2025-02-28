import { FastifyInstance, FastifyReply, FastifyRequest } from "fastify";
import { FastifyPluginAsyncZod } from "fastify-type-provider-zod";
import { CREDETNTIALS_SCHEMA } from "./schemas";
import fp from 'fastify-plugin'
import { ICredentials } from "./interfaces";

const authRoutes: FastifyPluginAsyncZod = async function authRoutes(server: FastifyInstance) {
  server.post('/register', {
    schema: {
      body: CREDETNTIALS_SCHEMA,
      tags: ['auth'],
      response: {

      }
    }
  }, async function register(reqeust: FastifyRequest<{ Body: ICredentials }>, reply: FastifyReply) {
    reply.code(201)
    return server.authService.register(reqeust.body)
  })

  server.post('/login', {
    schema: {
      body: CREDETNTIALS_SCHEMA,
      tags: ['auth']
    }
  }, async function login(reqeust: FastifyRequest<{ Body: ICredentials }>, reply: FastifyReply) {
    return server.authService.login(reqeust.body)
  })

  server.get('/test', { onRequest: [server.authenticate] }, async function test(request: FastifyRequest, reply: FastifyReply) {
    return request.user
  })
}

export default fp(authRoutes, { name: 'auth-routes', encapsulate: true, dependencies: ['prisma'] })