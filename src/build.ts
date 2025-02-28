import { join } from 'node:path'
import Fastify from 'fastify'
import AutoLoad from '@fastify/autoload'
import { serializerCompiler, validatorCompiler } from 'fastify-type-provider-zod'

export async function build(options = {}) {
  const app = Fastify(options)

  app.setValidatorCompiler(validatorCompiler)
  app.setSerializerCompiler(serializerCompiler)

  app.register(AutoLoad, {
    dir: join(__dirname, 'plugins')
  })

  app.register(AutoLoad, {
    dir: join(__dirname, 'modules'),
    indexPattern: /.*routes(\.js|\.cjs|\.ts)$/i,
    ignorePattern: /.*(\.js|\.cjs|\.ts)$/i,
    autoHooksPattern: /.*hooks(\.js|\.cjs|\.ts)$/i,
    autoHooks: true,
    cascadeHooks: true
  })

  return app
}
