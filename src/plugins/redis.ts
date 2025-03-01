import { FastifyInstance } from 'fastify'
import fp from 'fastify-plugin'
import Redis from 'ioredis'

declare module 'fastify' {
  interface FastifyInstance {
    redis: Redis
  }
}

async function connetToCache() {
  const redis = new Redis({
    host: process.env.CACHE_HOST,
    port: +process.env.CACHE_PORT,
    password: process.env.CACHE_PASSWORD
  })

  return redis
}

async function keydbPlugin(server: FastifyInstance) {
  const redis = await connetToCache()

  server.decorate('redis', redis)
  server.addHook('onClose', async function keydbOnCloseHook() {
    await server.redis.disconnect()
  })
}

export default fp(keydbPlugin, { name: 'keydb' })
