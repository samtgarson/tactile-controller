import { useEvent, usePresenceChannel } from '@harelpls/use-pusher'
import React, { FunctionComponent, useEffect, useState } from 'react'

type ChannelViewProps = {
  id: string
}

export const ChannelView: FunctionComponent<ChannelViewProps> = ({ id }) => {
  const { channel, members } = usePresenceChannel(`presence-${id}`)
  const [joined, setJoined] = useState(false)
  const [err, setError] = useState()

  useEvent(channel, 'pusher:subscription_error', setError)

  useEffect(() => {
    if (members && members.length > 1) setJoined(true)
  }, [members])

  if (err) return <p>Error!</p>
  if (!joined) return <p>Joining...</p>
  return <p>Joined!</p>
}
