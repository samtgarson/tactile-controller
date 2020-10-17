//
//  Extensions.swift
//  TactileController
//
//  Created by Sam Garson on 17/10/2020.
//

import Foundation
import CoreGraphics

extension CGFloat {
    func map(from: ClosedRange<CGFloat>, to: ClosedRange<CGFloat>) -> CGFloat {
        let result = ((self - from.lowerBound) / (from.upperBound - from.lowerBound)) * (to.upperBound - to.lowerBound) + to.lowerBound
        return result
    }
}
