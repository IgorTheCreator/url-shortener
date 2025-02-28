import { FastifyInstance } from 'fastify'
import fp from 'fastify-plugin'
import cors from '@fastify/cors'

async function corsPlugin(server: FastifyInstance) {
  server.register(cors, {
    origin: false
  })
}

export default fp(corsPlugin, { name: 'cors' })