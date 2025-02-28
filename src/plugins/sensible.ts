import { FastifyInstance } from 'fastify'
import fastifySensible from '@fastify/sensible'
import fp from 'fastify-plugin'

async function sensiblePlugin(server: FastifyInstance) {
  server.register(fastifySensible)
}

export default fp(sensiblePlugin, { name: 'sensible' })
