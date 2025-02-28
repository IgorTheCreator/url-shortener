import fp from 'fastify-plugin'
import { FastifyInstance } from "fastify";

async function ping(server: FastifyInstance) {
  server.get('/', { schema: { tags: ['healthcheck'] } }, () => 'pong')
}

export default fp(ping, { encapsulate: true, name: 'ping' })