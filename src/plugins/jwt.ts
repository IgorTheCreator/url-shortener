import fp from 'fastify-plugin'
import { FastifyInstance, FastifyReply, FastifyRequest } from "fastify";
import fastifyJwt from '@fastify/jwt';

declare module 'fastify' {
  interface FastifyInstance {
    authenticate: (request: FastifyRequest, reply: FastifyReply) => Promise<void>
  }
}

async function jwtPlugin(server: FastifyInstance) {
  server.register(fastifyJwt, {
    secret: process.env.JWT_TOKEN_SECRET,
    sign: {
      expiresIn: '1h'
    }
  })

  server.decorate('authenticate', async function authenticate(reqeust: FastifyRequest, reply: FastifyReply) {
    try {
      await reqeust.jwtVerify()
    } catch (e) {
      reply.send(e)
    }
  })
}

export default fp(jwtPlugin, { name: 'jwt' })