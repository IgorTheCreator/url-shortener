import 'dotenv/config'
import * as closeWithGrace from 'close-with-grace'
import { build } from './build'
import { serverOptions } from './configs/server-options'

async function main() {
  const server = await build(serverOptions)

  server.listen({
    host: process.env.HOST,
    port: +process.env.APP_PORT!
  })

  closeWithGrace(async ({ err }) => {
    if (err) {
      server.log.error(err, 'Server closed due error')
    } else {
      server.log.info('Shutting down the server')
    }

    await server.close()
  })
}

main()