import { FastifyInstance } from 'fastify'
import fp from 'fastify-plugin'
import fastifySwagger from '@fastify/swagger'
import fastifySwaggerUi from '@fastify/swagger-ui'
import { createJsonSchemaTransformObject, jsonSchemaTransform } from 'fastify-type-provider-zod'
import { CREDENTIALS_SCHEMA } from '../modules/auth/schemas'

async function swaggerPlugin(server: FastifyInstance) {
  server.register(fastifySwagger, {
    openapi: {
      info: {
        title: 'Test API',
        description: 'Test something',
        version: '0.0.1'
      },
      components: {
        securitySchemes: {
          bearerAuth: {
            type: 'http',
            scheme: 'bearer',
            bearerFormat: 'JWT'
          }
        }
      },
      security: [{ bearerAuth: [] }]
    },
    transform: jsonSchemaTransform,
    transformObject: createJsonSchemaTransformObject({
      schemas: {
        Credentials: CREDENTIALS_SCHEMA
      }
    })
  })

  server.register(fastifySwaggerUi, {
    routePrefix: '/docs'
  })
}

export default fp(swaggerPlugin, { name: 'swagger' })
