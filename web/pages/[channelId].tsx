import { useRouter } from 'next/router'
import { Title } from 'rbx'
import React, { FunctionComponent, useMemo } from 'react'
import { ChannelView } from '@/components/channel-view'

const Home: FunctionComponent = () => {
  const router = useRouter()
  const { channelId } = router.query as { channelId: string }
  const pageContent = useMemo(() => channelId
    ? <ChannelView id={channelId} />
    : <p>Loading...</p>,
    [channelId]
  )

  return (
    <>
      <Title>Input Experiment</Title>
      { pageContent }
    </>
  )
}

export default Home
