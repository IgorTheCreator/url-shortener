import { z } from 'zod'
export const CREDETNTIALS_SCHEMA = z.object({
  email: z.string().email().describe('Почта пользователя'),
  password: z.string().min(8).describe('Пароль пользователя')
})