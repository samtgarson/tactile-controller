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
    }
    
    var id: String
    var back: () -> Void
    
    var body: some View {
        InputSurface(inputState: inputState, back: back)
            .onReceive(timer) { _ in publisher.publish(with: inputState) }
            .onDisappear { self.timer.upstream.connect().cancel() }
    }
    
    private var inputState = InputState()
    private var publisher: InputPublisher
    
    private let timer = Timer
        .publish(every: 0.125, tolerance: 0.025, on: .main, in: .common)
        .autoconnect()
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputScreen(id: "d94679b9-0784-44e5-9f05-2ad06b101acc", token: "token") {
            print("Back!")
        }
        .preferredColorScheme(.dark)
    }
}
