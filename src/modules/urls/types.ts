import { z } from 'zod'
import {
  CHANGE_STATUS_BODY_SCHEMA,
  REDIRECT_SCHEMA,
  SHORT_URL_RESPONSE_SCHEMA,
  SHORT_URL_SCHEMA
} from './schemas'

export type ShortUrl = z.infer<typeof SHORT_URL_SCHEMA>
export type ShortUrlResponse = z.infer<typeof SHORT_URL_RESPONSE_SCHEMA>
export type Redirect = z.infer<typeof REDIRECT_SCHEMA>
export type RedirectResponse = {
  long: string
}
export type StatusParams = Redirect
export type StatusBody = z.infer<typeof CHANGE_STATUS_BODY_SCHEMA>
