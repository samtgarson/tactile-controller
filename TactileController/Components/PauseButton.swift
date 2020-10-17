//
//  PauseButton.swift
//  InputExperiment
//
//  Created by Sam Garson on 11/10/2020.
//

import SwiftUI

struct PauseButton: View {
    var playing: Bool
    var toggle: () -> Void
    @State private var flash = false
    
    var body: some View {
        return Button(action: { toggle() }) {
            HStack(alignment: .center) {
                label
                if playing { icon }
                else { pauseIcon }
            }
        }
        .onReceive(timer) { _ in
            withAnimation(animation) {
                flash.toggle()
            }
        }
        .onDisappear { self.timer.upstream.connect().cancel() }
    }
    
    private let timer = Timer.publish(every: 0.8, tolerance: 0.1, on: .main, in: .common).autoconnect()
    
    private var icon: some View {
        ZStack {
            Circle()
                .stroke(Color.primary, lineWidth: 2)
                .frame(width: 22, height: 22)
            Circle()
                .fill(Color.primary)
                .frame(width: 10, height: 10)
                .animation(nil)
                .opacity(opacity)
            
        }
    }
    
    private var pauseIcon: some View {
        Image(systemName: "pause.circle.fill")
            .font(.system(size: 25))
            .foregroundColor(.primary)
            .frame(maxHeight: 22)
    }
        
    private var label: some View {
        Text(playing ? "Sending" : "Paused")
            .font(.system(size: 12))
            .fontWeight(.semibold)
            .foregroundColor(.primary)
            .textCase(.uppercase)
    }
    
    private var animation: Animation? {
        return Animation.easeInOut(duration: 0.8)
    }
    
    private var opacity: Double {
        return flash ? 0 : 1
    }
}

struct PauseButton_Previews: PreviewProvider {
    static var previews: some View {
        let state = InputState()
        return PauseButton(playing: state.sending) { state.sending.toggle() }
    }
}
