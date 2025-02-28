import { FastifyServerOptions } from 'fastify'

export const serverOptions: FastifyServerOptions = {
  logger: process.env.NODE_ENV === 'dev' ? {
    transport: {
      target: 'pino-pretty'
    }
  } : true
  // logger: false
}