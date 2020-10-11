//
//  InputSurface.swift
//  InputExperiment
//
//  Created by Sam Garson on 11/10/2020.
//

import SwiftUI

struct InputSurface: View {
    @ObservedObject var inputState: InputState
    var back: () -> Void
    
    var body: some View {
        VStack {
            Grid()
            HStack {
                backButton
                Spacer()
                PauseButton(state: inputState)
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
        InputSurface(inputState: state, back: { print("back!") })
            .preferredColorScheme(.dark)
    }
}
