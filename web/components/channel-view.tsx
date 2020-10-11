import { useEvent, usePresenceChannel } from '@harelpls/use-pusher'
import { Button } from 'rbx'
import React, { FunctionComponent, useCallback, useEffect, useState } from 'react'
import { useQrEncode } from 'react-qr-hooks'
import { Renderer } from './renderer'

type ChannelViewProps = {
  id: string
}

export const ChannelView: FunctionComponent<ChannelViewProps> = ({ id }) => {
  const { channel, members } = usePresenceChannel(`presence-${id}`)
  const [joined, setJoined] = useState(false)
  const [err, setError] = useState()
  const [connected, setConnected] = useState(false)
  const src = useQrEncode(`input-experiment|${id}`)

  const connect = useCallback(() => setConnected(true), [connected])
  useEvent(channel, 'pusher:subscription_error', setError)
  useEvent(channel, 'pusher:subscription_succeeded', connect)

  useEffect(() => {
    if (members && Object.keys(members).length > 1) setJoined(true)
    else setJoined(false)
  }, [members])

  if (err) return <p>Someone is already connected to this channel.</p>
  if (joined) return <Renderer channel={channel} />
  if (connected && src) return <>
    <img src={src} />
    <Button state='loading' color="white"></Button>
  </>
  return <p>Connecting...</p>
}
