import mixins from '@/styles/mixins.module.scss'
import homeStyles from '@/pages/index.module.scss'
import { useTheme } from 'next-themes'
import React, { FunctionComponent, useMemo } from 'react'
import { useQrEncode } from 'react-qr-hooks'
import { Btn } from './btn'
import { Apple } from './apple'
import styles from './intro.module.scss'
import { Button } from 'rbx'
import Link from 'next/link'

type IntroProps = {
  id: string
}

export const Intro: FunctionComponent<IntroProps> = ({ id }) => {
  const { resolvedTheme: theme } = useTheme()
  const qrOptions = useMemo(() => ({
    color: {
      dark: theme === 'dark' ? '#f5f5f5' : '#000',
      light: '#0000'
    }
  }), [theme])
  const src = useQrEncode(`input-experiment|${id}`, qrOptions)

  return <div>
    { src && <img src={src} /> }
    <p className={`${mixins.loader} ${homeStyles.caption}`}>Scan to connect</p>
    <p className={styles.waiting}>You&apos;ll need the mobile app to continue.</p>
    <Button.Group align="centered">
      <Link passHref href="/">
        <Btn>Back</Btn>
      </Link>
      <Btn outlined={false}><Apple inverted={true} className={mixins.btnIcon}/>Download on the App Store</Btn>
    </Button.Group>
  </div>
}
