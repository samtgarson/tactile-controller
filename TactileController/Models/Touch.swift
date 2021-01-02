//
//  Touch.swift
//  TactileController
//
//  Created by Sam Garson on 11/10/2020.
//

import Foundation
import UIKit

struct Touch: Codable {
    var coordinates: CGPoint
    var originalCoordinates: CGPoint
    var force: CGFloat
    
    init(x: CGFloat, y: CGFloat, force: CGFloat) {
        self.coordinates = CGPoint(x: x, y: y)
        self.originalCoordinates = CGPoint(x: x, y: y)
        self.force = force
    }
    
    init(from uiTouch: UITouch, with view: UIView) {
        originalCoordinates = uiTouch.location(in: view)
        let transform = CGAffineTransform(scaleX: 1 / view.frame.width, y: 1 / view.frame.height)
        self.coordinates = originalCoordinates.applying(transform)
        self.force = uiTouch.force
    }
}
