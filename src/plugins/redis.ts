import { FastifyInstance } from 'fastify'
import fp from 'fastify-plugin'
import Redis from 'ioredis'
import { REDIS_OPTIONS } from '../configs'

declare module 'fastify' {
  interface FastifyInstance {
    redis: Redis
  }
}

async function connetToCache() {
  const redis = new Redis(REDIS_OPTIONS)

  return redis
}

async function keydbPlugin(server: FastifyInstance) {
  const redis = await connetToCache()

  server.decorate('redis', redis)
  server.addHook('onClose', async function keydbOnCloseHook() {
    await server.redis.disconnect()
  })
}

export default fp(keydbPlugin, { name: 'redis' })
