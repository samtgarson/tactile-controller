import { useEvent, usePresenceChannel } from '@harelpls/use-pusher'
import { useRouter } from 'next/router'
import { Title } from 'rbx'
import React, { FC, useEffect, useState } from 'react'
import { ChannelView } from '@/components/channel-view'

const Home: FC = () => {
  const router = useRouter()
  const { channelId } = router.query as { channelId: string }

  if (!channelId) return <p>Loading...</p>
  return (
    <>
      <Title>Input Experiment</Title>
      <ChannelView id={channelId} />
    </>
  )
}

export default Home
