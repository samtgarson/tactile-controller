//
//  MotionService.swift
//  InputExperiment
//
//  Created by Sam Garson on 10/10/2020.
//

import Foundation
import CoreMotion

class MotionService {
    var motionManager: CMMotionManager!

    init() {
        motionManager = CMMotionManager()
        
        guard motionManager.isDeviceMotionAvailable else { return }
        
        motionManager.startDeviceMotionUpdates()
    }
    
    var motionData: CMDeviceMotion? {
        return motionManager.deviceMotion
    }
    
    deinit {
        motionManager.stopDeviceMotionUpdates()
    }
}
