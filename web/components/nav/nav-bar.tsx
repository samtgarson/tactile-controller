import React, { useCallback, useMemo } from 'react'
import Link from 'next/link'
import { Navbar } from 'rbx'
import { Sun, Moon, GitHub } from 'react-feather'
import { useTheme } from 'next-themes'
import styles from './nav.module.scss'

export const NavBar = () => {
  const { theme, setTheme } = useTheme()
  const ThemeSwitcher = useMemo(() => theme === 'dark' ? Moon : Sun, [theme])
  const navColor = useMemo(() => theme === 'dark' ? 'dark' : 'white', [theme])
  const icon = useMemo(() => theme === 'dark' ? '/hand-light.png' : 'hand.png', [theme])
  const switchTheme = useCallback(() => {
    setTheme(theme === 'dark' ? 'light' : 'dark')
  }, [setTheme, theme])

  return <Navbar color={navColor} className={styles.navbar}>
    <Navbar.Brand>
      <Link passHref href="/">
        <Navbar.Item  className={styles.title}>
          <img src={icon}/>
          Tactile Controller
        </Navbar.Item>
      </Link>
      <Navbar.Burger />
    </Navbar.Brand>
    <Navbar.Menu className={styles.divider}>
      <Navbar.Segment align="end">
        <Navbar.Item>
          <ThemeSwitcher size={18} onClick={switchTheme} />
        </Navbar.Item>
        <Link passHref href="https://github.com/samtgarson/tactile-controller">
          <Navbar.Item><GitHub size={18} /></Navbar.Item>
        </Link>
      </Navbar.Segment>
    </Navbar.Menu>
  </Navbar>
}
