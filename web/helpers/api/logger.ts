import morgan from 'morgan'
import { NextApiHandler } from 'next'

const format = process.env.NODE_ENV !== 'production' ? 'dev' : 'short'
export const logger: NextApiHandler = (req, res) => new Promise((resolve, reject) => {
  morgan(format)(req, res, e => { e ? reject(e) : resolve() })
})
