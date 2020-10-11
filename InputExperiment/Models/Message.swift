//
//  Message.swift
//  InputExperiment
//
//  Created by Sam Garson on 10/10/2020.
//

import Foundation
import CoreMotion

class Message: Codable {
    var rotation: Coordinate?
    var acceleration: Coordinate?
    
    init(motionData: CMDeviceMotion?) {
        if let motionData = motionData {
            addAttitude(motionData.attitude)
            addAcceleration(motionData.userAcceleration, motionData.gravity)
        }
    }
    
    func encode() -> String {
        guard let data = try? JSONEncoder().encode(self),
              let string = String(data: data, encoding: .utf8) else {
            return ""
        }
        
        return string
    }
    
    private func addAttitude(_ attitude: CMAttitude) {
        self.rotation = Coordinate(x: attitude.pitch, y: attitude.roll, z: attitude.yaw)
    }
    
    private func addAcceleration(_ acceleration: CMAcceleration, _ gravity: CMAcceleration) {
        self.acceleration = Coordinate(
            x: acceleration.x + gravity.x,
            y: acceleration.y + gravity.y,
            z: acceleration.z + gravity.z
        )
    }
}
