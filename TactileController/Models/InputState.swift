//
//  InputState.swift
//  TactileController
//
//  Created by Sam Garson on 11/10/2020.
//

import Foundation
import SwiftUI
import Combine

class InputState: ObservableObject {
    @Published var sending = true
    @Published var touches = [UITouch: Touch]() {
        didSet {
            touchesPublisher.send(touchArray)
        }
    }
    @Published var error: String?
    @Published var showError: Bool = false
    
    func registerPublisher(_ publisher: InputPublisher) {
        publisher.client.on(.receivedError) { [weak self] in self?.setError($0) }
        publisher.client.on(.failedToSubscribeToChannel) { [weak self] _ in self?.setError("Could not join channel! Are you connected to the internet?") }
    }
    
    func setError(_ error: String?) {
        DispatchQueue.main.async {
            if let error = error {
                self.error = error
                self.showError = true
                self.sending = false
            } else {
                self.error = nil
                self.showError = false
            }
        }
    }
        
    let touchesPublisher = CurrentValueSubject<[Touch], Never>([Touch]())
    
    var touchArray: [Touch] {
        Array(touches.values)
    }
}
