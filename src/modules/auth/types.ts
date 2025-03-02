import { z } from 'zod'
import { CREDENTIALS_SCHEMA, LOGOUT_RESPONSE_SCHEMA, REGISTER_RESPONSE_SCHEMA } from './schemas'

export type Credentials = z.infer<typeof CREDENTIALS_SCHEMA>
export type RegisterResponse = z.infer<typeof REGISTER_RESPONSE_SCHEMA>
export type AuthResponse = {
  accessToken: string
  refreshToken: string
}
export type LogoutResponse = z.infer<typeof LOGOUT_RESPONSE_SCHEMA>
