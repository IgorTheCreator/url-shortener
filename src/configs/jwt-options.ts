import { FastifyJWTOptions } from '@fastify/jwt'

export const JWT_OPTIONS: FastifyJWTOptions = {
  secret: process.env.JWT_TOKEN_SECRET,
  sign: {
    expiresIn: '1h'
  }
}
