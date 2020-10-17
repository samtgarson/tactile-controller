//
//  TouchViewModel.swift
//  TactileController
//
//  Created by Sam Garson on 17/10/2020.
//

import Foundation
import SwiftUI

class TouchViewModel: ObservableObject {
    @Published var x: CGFloat = 0
    @Published var y: CGFloat = 0
    @Published var force: CGFloat = 1
    @Published var display: Bool = false
    
    static func wholeHand() -> [TouchViewModel] {
        return [
            TouchViewModel(),
            TouchViewModel(),
            TouchViewModel(),
            TouchViewModel(),
            TouchViewModel()
        ]
    }
}
