//
//  SmallButton.swift
//  TactileController
//
//  Created by Sam Garson on 01/01/2021.
//

import SwiftUI

struct SmallButton: View {
    internal init(_ label: String, icon: String? = nil, action: @escaping () -> Void) {
        self.action = action
        self.label = label
        self.icon = icon
    }
    
    let action: () -> Void
    let label: String
    let icon: String?
    
    
    var body: some View {
        Button(action: action) {
            if let icon = icon {
                Image(systemName: icon)
            }
            Text(label)
        }
        .foregroundColor(.primary)
        .padding(.top, 12)
    }
}

struct SmallButton_Previews: PreviewProvider {
    static var previews: some View {
        SmallButton("Small Button", icon: "clock.arrow.circlepath") {}
    }
}
