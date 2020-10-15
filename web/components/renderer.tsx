import { useEvent } from "@harelpls/use-pusher"
import { PresenceChannel } from "pusher-js"
import React, { FunctionComponent, useRef } from "react"
import dynamic from 'next/dynamic'

const Scene = dynamic(() => import('@/components/interface/scene'), { ssr: false })

type RendererProps = {
  channel?: PresenceChannel
}

export const Renderer: FunctionComponent<RendererProps> = ({ channel }) => {
  const value = useRef<Message>()

  useEvent<Message>(channel, 'client-update', val => {
    value.current = val
  })

  return <Scene />
}
