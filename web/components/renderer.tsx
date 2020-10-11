import { useEvent } from "@harelpls/use-pusher"
import { PresenceChannel } from "pusher-js"
import React, { FunctionComponent, useState } from "react"

type RendererProps = {
  channel?: PresenceChannel
}

export const Renderer: FunctionComponent<RendererProps> = ({ channel }) => {
  const [value, setValue] = useState<Message>()
  useEvent(channel, 'client-update', setValue)

  return <pre>{ JSON.stringify(value, null, 2) }</pre>
}
