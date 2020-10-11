//
//  InputState.swift
//  InputExperiment
//
//  Created by Sam Garson on 11/10/2020.
//

import Foundation
import SwiftUI

struct Point: Codable {
    let coordinate: CGPoint
    let force: Double
}

class InputState: ObservableObject {
    @Published var points: [Point] = []
    @Published var sending = true
}
