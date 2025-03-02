import { FastifyInstance } from 'fastify'
import fp from 'fastify-plugin'
import Sqids from 'sqids'

declare module 'fastify' {
  interface FastifyInstance {
    sqids: Sqids
  }
}

function createSqids() {
  const sqids = new Sqids({
    minLength: 6
  })

  return sqids
}

async function sqidsPlugin(server: FastifyInstance) {
  const sqids = createSqids()
  server.decorate('sqids', sqids)
}

export default fp(sqidsPlugin, { name: 'sqids' })
