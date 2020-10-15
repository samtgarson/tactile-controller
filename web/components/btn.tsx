import { Button, forwardRefAs } from "rbx"
import { ButtonProps } from "rbx/elements/button/button"
import { useTheme } from 'next-themes'
import React from "react"

export const Btn = forwardRefAs<ButtonProps>(({ children, ...props }, ref) => {
  const { theme } = useTheme()

  return <Button inverted outlined color={theme} {...props} ref={ref}>{ children }</Button>
}, { as: "button" })
