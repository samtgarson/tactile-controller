import { FunctionComponent } from "react"

declare module 'next-themes' {
  export interface ThemeProviderProps {
    forcedTheme?: string
    disableTransitionOnChange: boolean = false
    enableSystem: boolean = true
    storageKey: string = 'theme'
    themes: string[] = ['light', 'dark']
    defaultTheme: string = 'light'
    attribute: string = 'data-theme'
    value?: { [theme: string]: string }
  }

  export interface ThemeHook {
    theme: string
    setTheme: (theme: string) => void
    forcedTheme: string | undefined
    resolvedTheme: string
    systemTheme: string
    themes: string[]
  }

  export const ThemeProvider: FunctionComponent<ThemeProviderProps>
  export function useTheme(): ThemeHook
}
