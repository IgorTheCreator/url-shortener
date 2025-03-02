import { FastifyListenOptions, FastifyServerOptions } from 'fastify'

export const SERVER_OPTIONS: FastifyServerOptions = {
  logger:
    process.env.NODE_ENV === 'dev'
      ? {
          transport: {
            target: 'pino-pretty'
          }
        }
      : true
  // logger: false
}

export const LISTEN_OPTIONS: FastifyListenOptions = {
  host: process.env.APP_HOST,
  port: +process.env.APP_PORT!
}
