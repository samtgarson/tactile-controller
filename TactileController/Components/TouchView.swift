//
//  TouchCircle.swift
//  TactileController
//
//  Created by Sam Garson on 15/10/2020.
//

import SwiftUI

struct TouchView: View {
    @ObservedObject var vm: TouchViewModel
    @State var rotated = false
    
    let size: CGFloat = 70
    
    var body: some View {
        if vm.display {
            Circle()
                .fill(Color(UIColor.systemBackground))
                .overlay(fill)
                .overlay(dottedBorder)
                .overlay(dot)
                .frame(width: size, height: size)
                .position(x: vm.x, y: vm.y)
                .transition(.opacity)
        }
    }
    
    private var fill: some View {
        Circle()
            .fill(Color.primary)
            .scaleEffect(circleScale)
            .opacity(0.1)
    }
    
    private var dottedBorder: some View {
        Circle()
            .strokeBorder(style: StrokeStyle(dash: [8]))
            .scaleEffect(strokeScale)
            .rotationEffect(rotated ? .degrees(360) : .zero)
            .onAppear {
                withAnimation(rotateAnimation) { rotated = true }
            }
            .onDisappear { rotated = false }
    }
    
    private var dot: some View {
        Circle()
            .fill(Color.primary)
            .scaleEffect(0.15)
    }
    
    private var rotateAnimation: Animation {
        return Animation.linear(duration: 10).repeatForever(autoreverses: false)
    }
    
    private var circleScale: CGFloat {
        vm.force.map(from: 0...10, to: 1...1.8)
    }
    
    private var strokeScale: CGFloat {
        vm.force.map(from: 0...10, to: 1.5...3)
    }
}

struct TouchCircle_Previews: PreviewProvider {
    static var previews: some View {
        let state = TouchViewModel()
        return TouchView(vm: state)
    }
}
