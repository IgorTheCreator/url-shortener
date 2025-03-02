import { z } from 'zod'

export const CREDENTIALS_SCHEMA = z.object({
  login: z.string().default('username').describe('Логин пользователя'),
  password: z.string().min(8).describe('Пароль пользователя')
})

export const REGISTER_RESPONSE_SCHEMA = z
  .object({
    id: z.string().uuid()
  })
  .required({ id: true })

export const LOGIN_RESPONSE_SCHEMA = z
  .object({
    accessToken: z.string(),
    refreshToken: z.string().optional()
  })
  .required({ accessToken: true, refreshToken: true })

export const REFRESH_RESPONSE_SCHEMA = LOGIN_RESPONSE_SCHEMA.omit({ refreshToken: true })

export const LOGOUT_RESPONSE_SCHEMA = z
  .object({
    success: z.boolean()
  })
  .required({ success: true })
