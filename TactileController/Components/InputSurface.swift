//
//  InputSurface.swift
//  InputExperiment
//
//  Created by Sam Garson on 11/10/2020.
//

import SwiftUI

struct InputSurface: View {
    @ObservedObject var state: InputState
    var back: () -> Void
    
    var body: some View {
        VStack {
            Grid(state: state)
            HStack {
                backButton
                Spacer()
                PauseButton(playing: state.sending) {
                    state.sending.toggle()
                }
            }.padding(.vertical)
        }
        .padding(.horizontal, 20)
        .padding(.top)
    }
    
    private var backButton: some View {
        let img = Image(systemName: "chevron.left.circle")
            .font(.system(size: 25))
            .foregroundColor(.primary)
        return Button(action: back) { img }
    }
}

struct InputGrid_Previews: PreviewProvider {
    static var previews: some View {
        let state = InputState()
        InputSurface(state: state, back: { print("back!") })
            .preferredColorScheme(.dark)
    }
}
