//
//  TouchViewModel.swift
//  TactileController
//
//  Created by Sam Garson on 17/10/2020.
//

import Foundation
import SwiftUI

class TouchViewModel: ObservableObject {
    static func wholeHand() -> [TouchViewModel] {
        return [
            TouchViewModel(),
            TouchViewModel(),
            TouchViewModel(),
            TouchViewModel(),
            TouchViewModel()
        ]
    }

    @Published var x: CGFloat = 0
    @Published var y: CGFloat = 0
    @Published var force: CGFloat = 1
    @Published var display: Bool = false
    
    func update(from touch: Touch) {
        x = touch.originalCoordinates.x
        y = touch.originalCoordinates.y
        withAnimation { force = touch.force }
    }
    
    func hide() {
        guard display else { return }
        
        withAnimation {
            display = false
        }
    }
    
    func show() {
        guard !display else { return }
        
        withAnimation {
            display = true
        }
    }
}
