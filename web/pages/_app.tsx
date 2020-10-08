import React, { FunctionComponent } from 'react'
import '../styles/globals.css'
import "rbx/index.css"
import { PusherProvider } from "@harelpls/use-pusher"
import Pusher from 'pusher-js'
import { Section, Container } from 'rbx'

Pusher.logToConsole = process.env.NODE_ENV !== 'production'

const config = {
  clientKey: process.env.NEXT_PUBLIC_PUSHER_KEY,
  cluster: "eu",
  authEndpoint: '/api/auth',
  auth: {
    headers: { 'X-Role': 'interface' }
  }
}

const CustomApp: FunctionComponent = ({ Component, pageProps }) => {
  return <PusherProvider {...config}>
    <Section>
      <Container>
        <Component {...pageProps} />
      </Container>
    </Section>
  </PusherProvider>
}

export default CustomApp
