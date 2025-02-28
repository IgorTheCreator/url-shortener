import { FastifyInstance } from 'fastify'
import fp from 'fastify-plugin'
import { fastifySchedule } from '@fastify/schedule'

async function cronPlugin(server: FastifyInstance) {
  server.register(fastifySchedule)
}

export default fp(cronPlugin, { name: 'cron' })
