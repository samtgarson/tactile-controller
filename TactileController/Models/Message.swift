//
//  Message.swift
//  TactileController
//
//  Created by Sam Garson on 10/10/2020.
//

import Foundation
import CoreMotion

class Message: Codable {
    var rotation: Coordinate?
    var acceleration: Coordinate?
    var touches: [Touch]
    
    init(motionData: CMDeviceMotion?, touches: [Touch] = [], referenceAttitude: CMAttitude?) {
        self.touches = touches
        
        if let motionData = motionData, let referenceAttitude = referenceAttitude {
            add(motionData.attitude, in: referenceAttitude)
            add(motionData.userAcceleration, motionData.gravity)
        }
    }
    
    func encode() -> String {
        guard let data = try? JSONEncoder().encode(self),
              let string = String(data: data, encoding: .utf8) else {
            return ""
        }
        
        return string
    }
    
    private func add(_ attitude: CMAttitude, in reference: CMAttitude) {
        attitude.multiply(byInverseOf: reference)
        self.rotation = Coordinate(from: attitude)
    }
    
    private func add(_ acceleration: CMAcceleration, _ gravity: CMAcceleration) {
        self.acceleration = Coordinate(
            x: acceleration.x + gravity.x,
            y: acceleration.y + gravity.y,
            z: acceleration.z + gravity.z
        )
    }
}
