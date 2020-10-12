//
//  TouchableView.swift
//  InputExperiment
//
//  Created by Sam Garson on 11/10/2020.
//

import Foundation
import UIKit
import SwiftUI

protocol TouchableViewDelegate {
    func setTouch(_ touch: UITouch)
    func removeTouch(_ touch: UITouch)
}

class UITouchableView: UIView {
    var delegate: TouchableViewDelegate?
    
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
            delegate?.setTouch(touch)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            delegate?.setTouch(touch)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            delegate?.removeTouch(touch)
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            delegate?.removeTouch(touch)
        }
    }
}

final class TouchableView: UIViewRepresentable {
    internal init(state: InputState) {
        self.state = state
    }
    
    typealias UIViewType = UITouchableView
    
    var state: InputState
    var view: UIView?
    
    func makeUIView(context: Context) -> UITouchableView {
        let view = UITouchableView()
        view.delegate = self
        
        self.view = view
        return view
    }
    
    func updateUIView(_ uiView: UITouchableView, context: Context) {
    }
}

extension TouchableView: TouchableViewDelegate {
    func setTouch(_ touch: UITouch) {
        guard let view = self.view else { return }
        
        state.points[touch] = Touch(from: touch, with: view)
    }
    
    func removeTouch(_ touch: UITouch) {
        state.points.removeValue(forKey: touch)
    }
}
