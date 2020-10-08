import Link from 'next/link'
import { Title, Button } from 'rbx'
import React, { FunctionComponent, useEffect, useState } from 'react'
import { v4 as uuidv4 } from 'uuid'

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
    </>
  )
}

export default Home
