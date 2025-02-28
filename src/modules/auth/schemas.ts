import { z } from 'zod'

export const CREDENTIALS_SCHEMA = z.object({
  email: z.string().email().describe('Почта пользователя'),
  password: z.string().min(8).describe('Пароль пользователя')
})

export const REGISTER_RESPONSE_SCHEMA = z
  .object({
    id: z.string().uuid()
  })
  .required({ id: true })

export const LOGIN_RESPONSE_SCHEMA = z
  .object({
    accessToken: z.string()
  })
  .required({ accessToken: true })

export const REFRESH_RESPONSE_SCHEMA = LOGIN_RESPONSE_SCHEMA.extend({})
export const LOGOUT_RESPONSE_SCHEMA = z
  .object({
    message: z.string()
  })
  .required({ message: true })
