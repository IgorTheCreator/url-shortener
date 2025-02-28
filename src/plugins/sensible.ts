import fastifySensible from '@fastify/sensible'
import { FastifyInstance } from 'fastify'
import fp from 'fastify-plugin'

async function sensiblePlugin(server: FastifyInstance) {
  server.register(fastifySensible)
}

export default fp(sensiblePlugin, { name: 'sensible' })