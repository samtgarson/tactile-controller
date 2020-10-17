import { MeshDistortMaterial, Torus } from "drei"
import React, { FC, useRef } from "react"
import { useFrame, useUpdate } from "react-three-fiber"
import { MeshStandardMaterial, Object3D, Vector3 } from "three"

type DoughnutProps = {
  theme: string
  getRotation: () => Rotation | undefined
}

export const Doughnut: FC<DoughnutProps> = ({ theme, getRotation }) => {
  const mesh = useRef<Object3D>()
  const color = useRef<string>('white')

  const material = useUpdate((c: MeshStandardMaterial) => {
    const color = theme === 'dark' ? 'black' : 'white'
    c.color.setColorName(color)
  }, [theme])

  useFrame(() => {
    const rawRotation = getRotation()
    if (!mesh.current || !rawRotation) return

    const newRotation = new Vector3(rawRotation.x, rawRotation.y, rawRotation.z)
    const currentRotation = mesh.current.rotation.toVector3()
    const targetRotation = currentRotation.add(newRotation.sub(currentRotation).divideScalar(10))

    mesh.current.rotation.setFromVector3(targetRotation)
  })

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


