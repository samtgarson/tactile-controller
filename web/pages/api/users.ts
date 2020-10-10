import { logger } from '@/helpers/api/logger'
import { User } from '@/models/user'
import { NextApiHandler } from 'next'

const handler: NextApiHandler = async (req, res) => {
  await logger(req, res)
  const role = req.body.role === 'interface' ? 'interface' : 'input'

  const user = new User(role)
  res.statusCode = 201
  res.end(JSON.stringify(user.toJSON))
}

export default handler
