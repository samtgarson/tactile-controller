//
//  InputScreen.swift
//  InputExperiment
//
//  Created by Sam Garson on 08/10/2020.
//

import SwiftUI
import PusherSwift

struct InputScreen: View {
    internal init(id: String, token: String) {
        self.id = id
        
        self.client = PusherClient(token: token)
        self.channel = client.subscribe(to: "presence-\(id)")
    }
    
    var id: String
    
    var body: some View {
        Text(channel.name)
    }
    
    private var channel: PusherChannel
    private var client: PusherClient
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputScreen(id: "d94679b9-0784-44e5-9f05-2ad06b101acc", token: "token")
    }
}
