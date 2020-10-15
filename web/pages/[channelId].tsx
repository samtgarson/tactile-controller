import { useRouter } from 'next/router'
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
      { pageContent }
    </>
  )
}

export default Home
