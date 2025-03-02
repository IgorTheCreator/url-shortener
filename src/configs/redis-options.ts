import { RedisOptions } from 'ioredis'

export const REDIS_OPTIONS: RedisOptions = {
  host: process.env.CACHE_HOST,
  port: +process.env.CACHE_PORT,
  password: process.env.CACHE_PASSWORD
}
