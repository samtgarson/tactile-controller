import Link from 'next/link'
import { Title, Button } from 'rbx'
import React, { FunctionComponent, useEffect, useState } from 'react'
import { v4 as uuidv4 } from 'uuid'

import dynamic from 'next/dynamic'
const Scene = dynamic(() => import('@/components/interface/scene'), { ssr: false })

const Home: FunctionComponent = () => {
  const [uuid, setUuid] = useState<string>()

  useEffect(() => {
    setUuid(uuidv4())
  }, [])

  return (
    <>
      <Title>Input Experiment</Title>
      <Link href={`/${uuid}`} passHref>
        <Button as="a">Begin</Button>
      </Link>
      <Scene />
    </>
  )
}

export default Home
