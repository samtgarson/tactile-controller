/* eslint-disable promise/prefer-await-to-then */
import { FooterBar } from '@/components/nav/footer-bar'
import { NavBar } from '@/components/nav/nav-bar'
import { createPusherConfig } from '@/helpers/create-pusher-config'
import { fetchUser } from '@/helpers/fetch-user'
import { PusherProvider } from "@harelpls/use-pusher"
import { ThemeProvider } from 'next-themes'
import { AppProps } from 'next/dist/next-server/lib/router/router'
import Head from 'next/head'
import { Container, Section } from 'rbx'
import React, { useEffect, useMemo, useState } from 'react'
import '../styles/globals.scss'
import styles from './app.module.scss'

/* Pusher.logToConsole = process.env.NODE_ENV !== 'production' */

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
      <Section className={styles.section}>
        <Container className={styles.container}>
          <NavBar />
          <Component {...pageProps} />
          <FooterBar />
        </Container>
      </Section>
    </ThemeProvider>
  </PusherProvider>
}

export default CustomApp
