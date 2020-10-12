//
//  TouchableView.swift
//  InputExperiment
//
//  Created by Sam Garson on 11/10/2020.
//

import Foundation
import UIKit
import SwiftUI

class UITouchableView: UIView {
    var state: InputState?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isMultipleTouchEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        isMultipleTouchEnabled = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            state?.points[touch] = Touch(from: touch, with: self)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            state?.points[touch] = Touch(from: touch, with: self)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            state?.points.removeValue(forKey: touch)
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            state?.points.removeValue(forKey: touch)
        }
    }
}

struct TouchableView: UIViewRepresentable {
    typealias UIViewType = UITouchableView
    
    @ObservedObject var state: InputState
    
    func makeUIView(context: Context) -> UITouchableView {
        let view = UITouchableView()
        view.state = state
        return view
    }
    
    func updateUIView(_ uiView: UITouchableView, context: Context) {
        uiView.state = state
    }
}
