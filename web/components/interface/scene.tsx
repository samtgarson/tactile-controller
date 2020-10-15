import React, { Suspense, useEffect, useRef } from 'react'
import { Canvas } from "react-three-fiber"
import { Bloom, EffectComposer, SSAO } from 'react-postprocessing'
import styles from './scene.module.css'
import { Doughnut } from './doughnut'
import { useTheme } from 'next-themes'

const Scene = () => {
  const { theme } = useTheme()
  const themeRef = useRef<string>(theme)

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
      <Doughnut theme={theme} />
      <Suspense fallback={null}>
        <EffectComposer>
          <Bloom luminanceThreshold={0} luminanceSmoothing={0.9} height={300} />
          <SSAO />
        </EffectComposer>
      </Suspense>
    </Canvas>
  </div>
}
 export default Scene
