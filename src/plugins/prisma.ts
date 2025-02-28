import { FastifyInstance } from 'fastify'
import { PrismaClient } from '@prisma/client'
import fp from 'fastify-plugin'

declare module 'fastify' {
  interface FastifyInstance {
    prisma: PrismaClient
  }
}

async function connectToDatabase() {
  const prisma = new PrismaClient()
  await prisma.$connect()

  return prisma
}

async function prismaPlugin(server: FastifyInstance) {
  const prisma = await connectToDatabase()

  server.decorate('prisma', prisma)
  server.addHook('onClose', async function prismaOnCloseHook() {
    await server.prisma.$disconnect()
  })
}

export default fp(prismaPlugin, { name: 'prisma' })
