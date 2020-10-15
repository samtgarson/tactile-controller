import { Btn } from '@/components/btn'
import Link from 'next/link'
import { useTheme } from 'next-themes'
import { Title } from 'rbx'
import React, { FunctionComponent, useEffect, useMemo, useState } from 'react'
import { v4 as uuidv4 } from 'uuid'
import styles from './index.module.scss'
import { Zap } from 'react-feather'
import mixins from '@/styles/mixins.module.scss'

const Home: FunctionComponent = () => {
  const { theme } = useTheme()
  const [uuid, setUuid] = useState<string>()
  const [loading, setLoading] = useState(false)
  const btnState = useMemo(() => loading ? 'loading' : undefined, [loading])

  useEffect(() => {
    setUuid(uuidv4())
  }, [])

  return (
    <div className={styles.wrapper}>
      <p className={styles.caption}>Welcome to</p>
      <Title>A new medium</Title>
      <p>Our phones are incredibly powerful and sensitive input devices, which allow us to interact with imaginary, digital objects with tactility and precision—yet most of our mobile apps behave like real world objects, where we point and tap.</p>
      <p><strong>Tactile Controller</strong> is an experiment trying to create an interface which is as delicate and responsive as our own hands, using a device that almost everyone has in their pockets. I hope this might allow creators to interact with digital tools in a new way.</p>
      <Link href={`/${uuid}`} passHref>
        <Btn className={styles.start} onClick={() => setLoading(true)} state={btnState} as="a"><Zap size={16} className={mixins.btnIcon}/>Try the demo</Btn>
      </Link>
    </div>
  )
}

export default Home
