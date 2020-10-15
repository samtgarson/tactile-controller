import { MeshDistortMaterial, Torus } from "drei"
import React, { FC, MutableRefObject, useLayoutEffect, useRef } from "react"
import { useUpdate } from "react-three-fiber"
import { Color, MeshStandardMaterial, Object3D } from "three"

type DoughnutProps = {
  theme: string
}

export const Doughnut: FC<DoughnutProps> = ({ theme }) => {
  const mesh = useRef<Object3D>()
  const color = useRef<string>('white')

  const material = useUpdate((c: MeshStandardMaterial) => {
    const color = theme === 'dark' ? 'black' : 'white'
    c.color.setColorName(color)
  }, [theme])

  return <Torus position={[0, 0, 0]} ref={mesh} args={[1.5, 0.8, 32, 50]}>
    <MeshDistortMaterial
      attach="material"
      color={color.current}
      speed={3}
      distort={0.2}
      radius={1.5}
      metalness={0.3}
      roughness={0.3}
      ref={material}
    />
  </Torus>
}


