import { z } from 'zod'

export const SHORT_URL_SCHEMA = z
  .object({
    long: z.string().url().describe('Ссылка'),
    expiresAt: z.string().date().optional().describe('Дата истекания'),
    alias: z.string().min(6).optional().describe('Алиас пользователя')
  })
  .required({ long: true })
  .strict()

export const SHORT_URL_RESPONSE_SCHEMA = z.object({
  short: z.string().describe('Хэш'),
  long: z.string().url().describe('Длинная ссылка'),
  isActive: z.boolean().describe('Статус'),
  expiresAt: z.string().date().describe('Дата истекания')
})

export const REDIRECT_SCHEMA = z
  .object({
    short: z.string().min(6)
  })
  .required({ short: true })

export const CHANGE_STATUS_PARAMS_SCHEMA = REDIRECT_SCHEMA.extend({})

export const CHANGE_STATUS_BODY_SCHEMA = z
  .object({
    isActive: z.boolean()
  })
  .required({ isActive: true })

export const CHANGE_STATUS_RESPONSE_SCHEMA = z
  .object({
    success: z.boolean()
  })
  .required({ success: true })
