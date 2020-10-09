//
//  InputScreen.swift
//  InputExperiment
//
//  Created by Sam Garson on 08/10/2020.
//

import SwiftUI
import PusherSwift

struct InputScreen: View {
    internal init(id: String) {
        self.id = id
        self.channel = pusherClient.subscribe(to: "presence-\(id)")
    }
    
    var id: String
    
    var body: some View {
        Text(id)
    }
    
    private let pusherClient = PusherClient()
    private var channel: PusherChannel
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputScreen(id: "d94679b9-0784-44e5-9f05-2ad06b101acc")
    }
}
