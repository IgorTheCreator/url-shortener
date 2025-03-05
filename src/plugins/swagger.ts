import { FastifyInstance } from 'fastify'
import fp from 'fastify-plugin'
import fastifySwagger from '@fastify/swagger'
import fastifySwaggerUi from '@fastify/swagger-ui'
import { createJsonSchemaTransformObject, jsonSchemaTransform } from 'fastify-type-provider-zod'
import {
  CREDENTIALS_SCHEMA,
  LOGIN_RESPONSE_SCHEMA,
  LOGOUT_RESPONSE_SCHEMA,
  REFRESH_RESPONSE_SCHEMA,
  REGISTER_RESPONSE_SCHEMA
} from '../modules/auth/schemas'
import {
  CHANGE_STATUS_BODY_SCHEMA,
  CHANGE_STATUS_PARAMS_SCHEMA,
  CHANGE_STATUS_RESPONSE_SCHEMA,
  REDIRECT_SCHEMA,
  SHORT_URL_RESPONSE_SCHEMA,
  SHORT_URL_SCHEMA
} from '../modules/urls/schemas'

async function swaggerPlugin(server: FastifyInstance) {
  server.register(fastifySwagger, {
    openapi: {
      info: {
        title: 'URL Shortener API',
        description: 'API routes for URL Shortener',
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
        Credentials: CREDENTIALS_SCHEMA,
        RegisterResponse: REGISTER_RESPONSE_SCHEMA,
        LoginResponse: LOGIN_RESPONSE_SCHEMA,
        RefreshResponse: REFRESH_RESPONSE_SCHEMA,
        LogoutResponse: LOGOUT_RESPONSE_SCHEMA,
        ShortUrl: SHORT_URL_SCHEMA,
        ShortUrlResponse: SHORT_URL_RESPONSE_SCHEMA,
        Redirect: REDIRECT_SCHEMA,
        ChangeStatusParams: CHANGE_STATUS_PARAMS_SCHEMA,
        ChangeStatusBody: CHANGE_STATUS_BODY_SCHEMA,
        ChangeStatusResponse: CHANGE_STATUS_RESPONSE_SCHEMA
      }
    })
  })

  server.register(fastifySwaggerUi, {
    routePrefix: '/docs'
  })
}

export default fp(swaggerPlugin, { name: 'swagger' })
