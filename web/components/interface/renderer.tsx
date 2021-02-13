import { useEvent } from "@harelpls/use-pusher"
import { useTheme } from 'next-themes'
import { PresenceChannel } from "pusher-js"
import React, { FunctionComponent, Suspense, useRef } from "react"
import { Bloom, EffectComposer, SSAO } from "react-postprocessing"
import { Canvas } from "react-three-fiber"
import { Doughnut } from "./doughnut"
import styles from './renderer.module.scss'

type RendererProps = {
  channel?: PresenceChannel
}

export const Renderer: FunctionComponent<RendererProps> = ({ channel }) => {
  const message = useRef<Message>()
  const { resolvedTheme: theme } = useTheme()

  useEvent<Message>(channel, 'client-update', val => {
    if (!val) return
    message.current = val
  })


  return <div className={styles.scene}>
    <Canvas shadowMap>
      <ambientLight intensity={0.4} />
      <directionalLight
        castShadow
        position={[2.5, 8, 5]}
        intensity={1.5}
      />
      <pointLight position={[0, -10, 0]} intensity={1} />
      <pointLight position={[0, 10, 10]} intensity={1} />
      <Doughnut theme={theme || 'light'} getRotation={() => message.current?.rotation} />
      <Suspense fallback={null}>
        <EffectComposer>
          <Bloom luminanceThreshold={0} luminanceSmoothing={0.9} height={300} />
          <SSAO />
        </EffectComposer>
      </Suspense>
    </Canvas>
  </div>
}
