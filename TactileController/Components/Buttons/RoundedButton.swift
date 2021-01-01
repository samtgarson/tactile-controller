//
//  RoundedButton.swift
//  TactileController
//
//  Created by Sam Garson on 01/01/2021.
//

import SwiftUI

struct RoundedButton<Content: View>: View {
    let content: Content
    let action: () -> Void
    let inverted: Bool
    
    init(action: @escaping () -> Void, inverted: Bool = false, @ViewBuilder content: () -> Content) {
        self.action = action
        self.inverted = inverted
        self.content = content()
    }
    
    var body: some View {
        Button(action: action) {
            HStack {
                content
            }
            .foregroundColor(foreground)
            .padding(.vertical, 10)
            .padding(.horizontal, 24)
            .background(
                backgroundShape
                    .overlay(strokeShape)
            )
        }
    }
    
    private var foreground: Color {
        inverted ? .primary : Color(.systemBackground)
    }
    
    private var backgroundShape: some View {
        RoundedRectangle(cornerRadius: 5)
            .fill(inverted ? Color(.systemBackground) : Color.primary)
    }
    
    private var strokeShape: some View {
        RoundedRectangle(cornerRadius: 5)
            .strokeBorder(Color.primary)
    }
}

struct RoundedButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            RoundedButton(action: {}) {
                Text("Regular")
            }
            
            RoundedButton(action: {}, inverted: true) {
                Text("Inverted")
            }
        }
        
        
    }
}
