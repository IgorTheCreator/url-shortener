import 'dotenv/config'
import closeWithGrace from 'close-with-grace'
import { build } from './build'
import { LISTEN_OPTIONS, SERVER_OPTIONS } from './configs'

async function main() {
  const server = await build(SERVER_OPTIONS)

  server.listen(LISTEN_OPTIONS)

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
