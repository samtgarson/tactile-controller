//
//  Grid.swift
//  InputExperiment
//
//  Created by Sam Garson on 11/10/2020.
//

import SwiftUI

struct Grid: View {
    var body: some View {
        ZStack {
            GeometryReader { geo in
                vertical(geo)
                horizontal(geo)
            }
            Rectangle().stroke(Color.primary, lineWidth: 1.5)
        }
    }
    
    private let padding: CGFloat = 30
    
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
        Grid()
    }
}
