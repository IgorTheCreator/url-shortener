import { FastifyInstance } from 'fastify'
import fp from 'fastify-plugin'

async function ping(server: FastifyInstance) {
  server.get('/', { schema: { tags: ['healthcheck'] } }, () => 'pong')
}

export default fp(ping, { encapsulate: true, name: 'ping' })
