//
//  InputScreen.swift
//  InputExperiment
//
//  Created by Sam Garson on 08/10/2020.
//

import SwiftUI
import PusherSwift

struct InputScreen: View {
    internal init(id: String, token: String, back: @escaping () -> Void) {
        self.id = id
        self.back = back
        self.publisher = InputPublisher(id: id, token: token)
        
        state.registerPublisher(publisher)
    }
    
    var id: String
    var back: () -> Void
    
    var body: some View {
        InputSurface(state: state, back: back)
            .onReceive(timer) { _ in publisher.publish(with: state) }
            .onDisappear { self.timer.upstream.connect().cancel() }
            .bottomSheet($state.showError, title: "Something went wrong", icon: "exclamationmark.triangle", dismissable: false) {
                VStack(spacing: 12) {
                    if let error = state.error { Text(error) }
                    SmallButton("Try Again", icon: "arrow.left") {
                        state.setError(nil)
                        back()
                    }
                }
            }
    }
    
    @ObservedObject var state = InputState()
    private var publisher: InputPublisher
    
    private let timer = Timer
        .publish(every: 0.125, tolerance: 0.025, on: .main, in: .common)
        .autoconnect()
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        let screen = InputScreen(id: "d94679b9-0784-44e5-9f05-2ad06b101acc", token: "token") {
            print("Back!")
        }
        
        return VStack {
            Button("error") { screen.state.setError("Could not join channel!") }
            screen
        }
    }
}
