/* eslint-disable promise/prefer-await-to-then */
import React, { useEffect, useMemo, useState } from 'react'
import '../styles/globals.scss'
import { PusherProvider } from "@harelpls/use-pusher"
import Pusher from 'pusher-js'
import { Section, Container } from 'rbx'
import Head from 'next/head'
import { fetchUser } from '@/helpers/fetch-user'
import { AppProps } from 'next/dist/next-server/lib/router/router'
import { ThemeProvider } from 'next-themes'
import { createPusherConfig } from '@/helpers/create-pusher-config'
import { NavBar } from '@/components/nav-bar'
import { FooterBar } from '@/components/footer-bar'

Pusher.logToConsole = process.env.NODE_ENV !== 'production'

const CustomApp = ({ Component, pageProps }: AppProps) => {
  const [token, setToken] = useState<string>()

  useEffect(() => {
    fetchUser().then(setToken)
  }, [])

  const config = useMemo(() => token && createPusherConfig(token), [token])

  if (!config) return null

  return <PusherProvider {...config}>
    <Head>
      <link rel="icon" type="image/png" href="favicon.png" />
      <title>Tactile Controller</title>
    </Head>
    <ThemeProvider defaultTheme="system">
      <Section style={{ display: 'flex', alignItems: 'stretch', minHeight: '100vh' }}>
        <Container>
          <NavBar />
          <Component {...pageProps} />
          <FooterBar />
        </Container>
      </Section>
    </ThemeProvider>
  </PusherProvider>
}

export default CustomApp
