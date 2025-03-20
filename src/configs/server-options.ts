import { FastifyListenOptions, FastifyServerOptions } from 'fastify'

function getLoggerOptions() {
  if (process.stdout.isTTY) {
    return {
      transport: {
        target: 'pino-pretty'
      }
    }
  }
  return true
}

export const SERVER_OPTIONS: FastifyServerOptions = {
  logger: getLoggerOptions()
  // logger: false
}

export const LISTEN_OPTIONS: FastifyListenOptions = {
  host: process.env.APP_HOST,
  port: +process.env.APP_PORT!
}
