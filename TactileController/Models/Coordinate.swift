//
//  Coordinate.swift
//  InputExperiment
//
//  Created by Sam Garson on 11/10/2020.
//

import Foundation
import CoreMotion

struct Coordinate: Codable {
    var x: Double
    var y: Double
    var z: Double
    
    init(x: Double, y: Double, z: Double) {
        self.x = x
        self.y = y
        self.z = z
    }
    
    init(from attitude: CMAttitude) {
        x = attitude.pitch
        y = attitude.roll
        z = attitude.yaw
    }
}
