//
//  InputState.swift
//  InputExperiment
//
//  Created by Sam Garson on 11/10/2020.
//

import Foundation
import SwiftUI
import Combine

class InputState: ObservableObject {
    @Published var sending = true
    @Published var touches = [UITouch: Touch]() {
        didSet {
            touchesPublisher.send(touchArray)
        }
    }
        
    let touchesPublisher = CurrentValueSubject<[Touch], Never>([Touch]())
    
    var touchArray: [Touch] {
        Array(touches.values)
    }
}
