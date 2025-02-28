import { FastifyInstance } from 'fastify'
import fp from 'fastify-plugin'
import Redis from 'ioredis'

declare module 'fastify' {
  interface FastifyInstance {
    keydb: Redis
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
  const keydb = await connetToCache()

  server.decorate('keydb', keydb)
  server.addHook('onClose', async function keydbOnCloseHook() {
    await server.keydb.disconnect()
  })
}

export default fp(keydbPlugin, { name: 'keydb' })
