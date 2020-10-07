import Head from 'next/head'
import { Container, Section, Title } from 'rbx'

export default function Home() {
  return (
    <Section>
      <Container>
        <Head>
          <title>Input Experiment</title>
          <link rel="icon" href="/favicon.ico" />
        </Head>
        <Title>Input Experiment</Title>
      </Container>
    </Section>
  )
}
