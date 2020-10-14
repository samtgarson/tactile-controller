import React from 'react'
import { Monitor, Smartphone } from 'react-feather'
import styles from './footer-bar.module.scss'

export const FooterBar = () => {
  return <footer className={styles.footer}>
    <span>
      <Monitor size={18} />
      <Smartphone size={18} />
    </span>
  </footer>
}
