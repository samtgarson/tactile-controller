import Pusher from 'pusher'
import { NextApiHandler } from 'next/types'
import {User} from '@/models/user'

const pusher = new Pusher({
  appId: process.env.PUSHER_APP_ID!,
  key: process.env.NEXT_PUBLIC_PUSHER_KEY!,
  secret: process.env.PUSHER_SECRET!,
  cluster: 'eu',
  useTLS: true
})

enum Role {
  Input = 'input',
  Interface = 'interface'
}

type PusherResponseBody = {
  users?: [
    { id: string }
  ]
}

const authorize = async (channelId: string, role: string) => {
  return new Promise((resolve, reject) => {
    pusher.get({ path: `/channels/${channelId}/users` }, (err, _, res) => {
      if (err) return reject(err)

      const { users } = JSON.parse(res.body) as PusherResponseBody
      if (!users) return resolve(false)

      const existing = users
        .map(User.fromPusher)
        .find(u => u.role === role)

      resolve(!existing)
    })
  })
}

const handler: NextApiHandler = async (req, res) => {
  console.log(`${req.method} /auth ${JSON.stringify(req.body)}`)
  const socketId = req.body.socket_id
  const channel = req.body.channel_name
  const role = req.headers['x-role'] === 'interface' ? Role.Interface : Role.Input

  const canJoin = await authorize(channel, role)

  if (!canJoin) {
    console.log(`Failed to authenticate for channel ${channel}`)
    res.statusCode = 401
    return res.send({ error: 'Not Authorized' })
  }

  const user = new User(role)
  const channelData = { user_id: user.encodedId, user_info: { role } }

  const auth = pusher.authenticate(socketId, channel, channelData)
  console.log(`Authenticated for channel ${channel}`)
  res.statusCode = 200
  res.send(auth)
}

export default handler

