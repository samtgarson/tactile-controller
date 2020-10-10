/* eslint-disable promise/prefer-await-to-callbacks */
import Pusher, { GetOptions, Callback } from 'pusher'

type PusherResponse = Parameters<Callback>[2]

const client = new Pusher({
  appId: process.env.PUSHER_APP_ID!,
  key: process.env.NEXT_PUBLIC_PUSHER_KEY!,
  secret: process.env.PUSHER_SECRET!,
  cluster: 'eu',
  useTLS: true
})

export const pusher = {
  get (opts: GetOptions): Promise<PusherResponse> {
    return new Promise((resolve, reject) => {
      client.get(opts, (err, _, res) => {
        if (err) {
          console.error(err)
          return reject(err)
        }
        resolve(res)
      })
    })
  },
  authenticate: client.authenticate.bind(client)
}
