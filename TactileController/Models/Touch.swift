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
        let absoluteLocation = uiTouch.location(in: view)
        let transform = CGAffineTransform(scaleX: 1 / view.frame.width, y: 1 / view.frame.height)
        self.coordinates = absoluteLocation.applying(transform)
        self.force = uiTouch.force
    }
}
