//
//  InputState.swift
//  InputExperiment
//
//  Created by Sam Garson on 11/10/2020.
//

import Foundation
import SwiftUI

class InputState: ObservableObject {
    @Published var points = [UITouch: Touch]()
    @Published var sending = true
}
