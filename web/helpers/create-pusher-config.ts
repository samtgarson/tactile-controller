import { PusherProviderProps } from "@harelpls/use-pusher"

export const createPusherConfig = (token: string): PusherProviderProps => ({
  clientKey: process.env.NEXT_PUBLIC_PUSHER_KEY,
  cluster: "eu",
  authEndpoint: '/api/auth',
  auth: {
    headers: { Authorization: token }
  }
})

