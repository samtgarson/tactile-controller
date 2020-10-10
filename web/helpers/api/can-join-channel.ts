import { User } from "@/models/user"
import { pusher } from "./pusher-client"

export const canJoinChannel = async (channel: string, { role }: User) => {
  try {
    const res = await pusher.get({ path: `/channels/${channel}/users` })
    const { users } = JSON.parse(res.body) as PusherResponseBody
    if (!users) return false

    const existing = users
      .map(({ id }) => User.fromToken(id))
      .find(u => u && u.role === role)

    return !existing
  } catch (e) {
    console.error(e)
    return false
  }
}
