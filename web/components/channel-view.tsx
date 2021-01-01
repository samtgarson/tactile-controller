import mixins from '@/styles/mixins.module.scss'
import { useEvent, usePresenceChannel } from '@harelpls/use-pusher'
import React, { FunctionComponent, useCallback, useEffect, useState } from 'react'
import { Intro } from './intro'
import dynamic from 'next/dynamic'
import { AlertTriangle } from 'react-feather'
import styles from '../styles/mixins.module.scss'

const Renderer = dynamic(async () => (await import('@/components/interface/renderer')).Renderer, { ssr: false })

type ChannelViewProps = {
  id: string
}

export const ChannelView: FunctionComponent<ChannelViewProps> = ({ id }) => {
  const { channel, members } = usePresenceChannel(`presence-${id}`)
  const [joined, setJoined] = useState(false)
  const [err, setError] = useState()
  const [connected, setConnected] = useState(false)

  const connect = useCallback(() => setConnected(true), [setConnected])
  useEvent(channel, 'pusher:subscription_error', setError)
  useEvent(channel, 'pusher:subscription_succeeded', connect)

  useEffect(() => {
    if (members && Object.keys(members).length > 1) setJoined(true)
    else setJoined(false)
  }, [members])

  if (err) return <p><AlertTriangle className={styles.btnIcon} />Someone is already connected to this channel.</p>
  if (joined) return <Renderer channel={channel} />
  if (connected) return <Intro id={id} />
  return <p className={mixins.loader}>Connecting...</p>
}
