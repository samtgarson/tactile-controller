//
//  Grid.swift
//  InputExperiment
//
//  Created by Sam Garson on 11/10/2020.
//

import SwiftUI

struct Grid: View {
    @ObservedObject var state: InputState
    @State var touches = TouchViewModel.wholeHand()
    
    var body: some View {
        ZStack {
            TouchableView(state: state)
            ForEach(0..<touches.count) { i in
                TouchView(vm: touches[i])
            }
            GeometryReader { geo in
                vertical(geo)
                horizontal(geo)
            }
            Rectangle().stroke(Color.primary, lineWidth: 1.5)
        }
        .onReceive(state.touchesPublisher) { touches in updateTouches(touches) }
    }
    
    private let padding: CGFloat = 30
    
    private func updateTouches(_ newTouches: [Touch]) {
        for i in 0...4 {
            let vm = touches[i]
            guard i < newTouches.count else {
                vm.hide()
                continue
            }
            
            vm.show()
            vm.update(from: newTouches[i])
        }
    }
    
    private func vertical(_ geo: GeometryProxy) -> some View {
        ForEach((1...5), id: \.self) { x in
            Path { path in
                let width = geo.frame(in: .local).width
                let height = geo.frame(in: .local).height
                let hor = CGFloat(width / 5) * CGFloat(x)
                
                path.move(to: CGPoint(x: hor, y: 0))
                path.addLine(to: CGPoint(x: hor, y: height))
            }.stroke(Color.primary)
        }
    }
    
    private func horizontal(_ geo: GeometryProxy) -> some View {
        ForEach((1...10), id: \.self) { y in
            Path { path in
                let width = geo.frame(in: .local).width
                let height = geo.frame(in: .local).height
                let vert = CGFloat(height / 10) * CGFloat(y)
                
                path.move(to: CGPoint(x: 0, y: vert))
                path.addLine(to: CGPoint(x: width, y: vert))
            }.stroke(Color.primary)
        }
    }
    
}

struct Grid_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
    }
    
    struct Preview: View {
        @ObservedObject var state = InputState()

        var body: some View {
            ZStack {
                TouchableView(state: state)
                VStack {
                    Grid(state: state)
                    Text("\(state.touches.count)")
                }
            }
        }
    }
}
