import { NextApiHandler, NextApiResponse } from 'next/types'
import { User } from '@/models/user'
import { logger } from '@/helpers/api/logger'
import { pusher } from '@/helpers/api/pusher-client'
import { canJoinChannel } from '@/helpers/api/can-join-channel'

const unauthorized = (res: NextApiResponse, detail?: string) => {
  res.statusCode = 401
  return res.end(JSON.stringify({ error: 'Not Authorized', detail }))
}

const handler: NextApiHandler = async (req, res) => {
  await logger(req, res)
  const { socket_id: socketId, channel_name: channel } = req.body
  const { authorization: token } = req.headers as { authorization?: string }

  if (!token) return unauthorized(res, 'Missing auth token')

  const user = User.fromToken(token)
  if (!user) return unauthorized(res, 'Invalid auth token')

  const canJoin = await canJoinChannel(channel, user)
  if (!canJoin) return unauthorized(res, 'Channel full')

  const channelData = { user_id: token }

  const auth = pusher.authenticate(socketId, channel, channelData)
  res.statusCode = 200
  return res.end(JSON.stringify(auth))
}

export default handler

