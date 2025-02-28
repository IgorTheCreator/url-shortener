import { FastifyInstance } from 'fastify'
import fp from 'fastify-plugin'
import fastifyCookie from '@fastify/cookie'

async function cookiePlugin(server: FastifyInstance) {
  server.register(fastifyCookie)
}

export default fp(cookiePlugin, { name: 'cookie' })
