//
//  Touch.swift
//  InputExperiment
//
//  Created by Sam Garson on 11/10/2020.
//

import Foundation
import UIKit

struct Touch: Codable {
    var coordinates: CGPoint
    var force: CGFloat
    
    init(from uiTouch: UITouch, with view: UIView) {
        self.coordinates = uiTouch.location(in: view)
        self.force = uiTouch.force
    }
}
