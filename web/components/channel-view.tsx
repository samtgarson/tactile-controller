import { useEvent, usePresenceChannel } from '@harelpls/use-pusher'
import React, { FunctionComponent, useEffect, useState } from 'react'
import { useQrEncode } from 'react-qr-hooks'

type ChannelViewProps = {
  id: string
}

export const ChannelView: FunctionComponent<ChannelViewProps> = ({ id }) => {
  const { channel, members } = usePresenceChannel(`presence-${id}`)
  const [joined, setJoined] = useState(false)
  const [err, setError] = useState()
  const src = useQrEncode(`input-experiment|${id}`)

  useEvent(channel, 'pusher:subscription_error', setError)

  useEffect(() => {
    if (members && members.length > 1) setJoined(true)
  }, [members])

  if (err) return <p>Error!</p>
  if (!joined) return <img src={src} />
  return <p>Joined!</p>
}
