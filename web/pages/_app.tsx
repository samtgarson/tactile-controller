/* eslint-disable promise/prefer-await-to-then */
import React, { useEffect, useMemo, useState } from 'react'
import '../styles/globals.css'
import "rbx/index.css"
import { PusherProvider } from "@harelpls/use-pusher"
import Pusher from 'pusher-js'
import { Section, Container } from 'rbx'
import { fetchUser } from '@/helpers/fetch-user'
import { AppProps } from 'next/dist/next-server/lib/router/router'
import { createPusherConfig } from '@/helpers/create-pusher-config'

Pusher.logToConsole = process.env.NODE_ENV !== 'production'

const CustomApp = ({ Component, pageProps }: AppProps) => {
  const [token, setToken] = useState<string>()

  useEffect(() => {
    fetchUser().then(setToken)
  }, [])

  const config = useMemo(() => token && createPusherConfig(token), [token])

  if (!config) return null

  return <PusherProvider {...config}>
    <Section>
      <Container>
        <Component {...pageProps} />
      </Container>
    </Section>
  </PusherProvider>
}

export default CustomApp
