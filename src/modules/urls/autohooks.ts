import { join } from 'node:path'
import { FastifyInstance } from 'fastify'
import fp from 'fastify-plugin'
import AutoLoad from '@fastify/autoload'
import {
  Redirect,
  RedirectResponse,
  ShortUrl,
  ShortUrlResponse,
  StatusBody,
  StatusParams
} from './types'

declare module 'fastify' {
  interface FastifyInstance {
    urlsService: {
      shortUrl: (url: ShortUrl, userId: string) => Promise<ShortUrlResponse>
      redirect: (data: Redirect) => Promise<RedirectResponse>
      changeStatus: (data: StatusBody & StatusParams, userId: string) => Promise<void>
      saveUrlInCache: (short: string, long: string) => Promise<void>
    }
    findUrlInCache: (
      request: FastifyRequest<{ Params: Redirect }>,
      reply: FastifyReply
    ) => Promise<RedirectResponse | void>
  }
}

async function urlsAutoHooks(server: FastifyInstance) {
  const { url: urls } = server.prisma

  server.register(AutoLoad, {
    dir: join(__dirname, 'plugins')
  })

  server.decorate('urlsService', {
    async shortUrl({ alias, expiresAt, long }, userId) {
      try {
        let short = alias
        if (alias) {
          const existedUrlWithAlias = await urls.findUnique({
            where: {
              short: alias
            }
          })
          if (existedUrlWithAlias) {
            throw server.httpErrors.unprocessableEntity('Alias is not avaliable')
          }
        } else {
          const counter = await server.redis.get('counter')
          short = server.sqids.encode([+counter])
          await server.redis.incr('counter')
        }
        const url = await urls.create({
          data: {
            short,
            long,
            userId,
            expiresAt: expiresAt ? new Date(expiresAt) : undefined
          },
          select: {
            short: true,
            long: true,
            isActive: true,
            expiresAt: true
          }
        })
        return {
          long: url.long,
          short: url.short,
          expiresAt: new Intl.DateTimeFormat('en-CA').format(url.expiresAt),
          isActive: url.isActive
        }
      } catch (e) {
        server.log.error(e)
        if (e.statusCode < 500) throw e
        throw server.httpErrors.internalServerError('Something went wrong')
      }
    },
    async redirect({ short }) {
      try {
        const url = await urls.findUnique({
          where: {
            short,
            isActive: true,
            OR: [
              { expiresAt: null },
              {
                expiresAt: {
                  gte: new Date(new Date().setHours(0, 0, 0, 0))
                }
              }
            ]
          },
          select: {
            long: true
          }
        })
        if (!url) {
          throw server.httpErrors.notFound('Url not found')
        }
        await urls.update({
          where: {
            short
          },
          data: {
            clickCounts: {
              increment: 1
            }
          }
        })
        await this.saveUrlInCache(short, url.long)
        return { long: url.long }
      } catch (e) {
        server.log.error(e)
        if (e.statusCode < 500) throw e
        throw server.httpErrors.internalServerError('Something went wrong')
      }
    },
    async changeStatus({ short, isActive }, userId) {
      try {
        const url = await urls.findUnique({
          where: {
            short,
            userId
          }
        })
        if (!url) {
          throw server.httpErrors.notFound()
        }
        await urls.update({
          where: {
            short,
            userId
          },
          data: {
            isActive
          }
        })
      } catch (e) {
        server.log.error(e)
        if (e.statusCode < 500) throw e
        throw server.httpErrors.internalServerError('Something went wrong')
      }
    },
    async saveUrlInCache(short, long) {
      try {
        await server.redis.set(short, long, 'EX', 86400)
      } catch (e) {
        server.log.error(e)
      }
    }
  })

  server.decorate('findUrlInCache', async function findUrlInCache(request, reply) {
    try {
      const { short } = request.params
      const long = await server.redis.get(short)
      if (long) {
        await urls.update({
          where: {
            short
          },
          data: {
            clickCounts: {
              increment: 1
            }
          }
        })
        reply.code(302)
        console.log(long)
        reply.redirect(long)
      }
    } catch (e) {
      server.log.error(e)
    }
  })
}

export default fp(urlsAutoHooks, {
  encapsulate: true,
  dependencies: ['redis', 'prisma', 'sensible']
})
