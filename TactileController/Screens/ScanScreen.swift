//
//  ScanScreen.swift
//  TactileController
//
//  Created by Sam Garson on 08/10/2020.
//

import SwiftUI
import CodeScanner

struct ScanScreen: View {
    var setChannel: (_ id: String) -> Void
    
    @State private var showInfo = false
    
    var body: some View {
        VStack(spacing: 8) {
            Text("Welcome to")
                .kerning(1)
                .textCase(.uppercase)
                .font(.system(size: 12, weight: .semibold))

            Text("A New Medium")
                .font(.system(size: 28, weight: .semibold))
            
            Text("Tactile Controller is an experiment trying to create an interface which is as delicate and responsive as our own hands, using a device that almost everyone has in their pockets.\n\nI hope this might allow creators to interact with digital tools in a new way.")
                .padding()

            Scanner(done: setChannel)
                .padding(16)
            
            SmallButton("What is this?", icon: "info.circle", action: { withAnimation { showInfo.toggle() } })
        }
        .onTapGesture { withAnimation { showInfo = false } }
        .bottomSheet($showInfo, title: "Tactile Controller", icon: "hand.draw") { InfoOverlay }
        .font(.system(size: 16))
        .multilineTextAlignment(.center)
        .lineSpacing(6)
    }
    
    private var InfoOverlay: some View {
        VStack(spacing: 24) {
            Text("This app is a controller for a partner web experience. Share the link below with another device (best viewed on desktop).")
            
            RoundedButton(action: shareUrl, inverted: true) {
                Image(systemName: "square.and.arrow.up")
                Text("Share link with another device").bold()
            }
        }
    }
    
    private func shareUrl() {
        let items = [URL(string: "https://tactile-controller.samgarson.com")!]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(ac, animated: true)
    }
}

struct ScanScreen_Previews: PreviewProvider {
    static var previews: some View {
        ScanScreen { id in print(id) }
            
    }
}
