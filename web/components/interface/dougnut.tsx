import { MeshDistortMaterial, Torus } from "drei"
import React, { useRef } from "react"
import { useFrame } from "react-three-fiber"
import { Object3D } from "three"

export const Doughnut = () => {
  const mesh = useRef<Object3D>()
  useFrame(() => {
    /* mesh.current.rotation.x = mesh.current.rotation.y += 0.001 */
  })

  return <Torus position={[0, 0, 0]} ref={mesh} args={[1.5, 0.8, 32, 50]}>
    <MeshDistortMaterial
      attach="material"
      color="white"
      speed={3}
      distort={0.2}
      radius={1.5}
      metalness={0.3}
      roughness={0.3}
    />
  </Torus>
}


