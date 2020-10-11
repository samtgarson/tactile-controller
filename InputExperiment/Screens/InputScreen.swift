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
        
        self.client = PusherClient(token: token).client
        self.channel = client.subscribeToPresenceChannel(channelName: "presence-\(id)")
    }
    
    var id: String
    
    var body: some View {
        VStack {
            Text(channel.name)
            Button(sending ? "Stop sending" : "Start sending") { sending.toggle() }
        }
        .onReceive(timer) { _ in publishMessage() }
        .onDisappear { self.timer.upstream.connect().cancel() }
    }
    
    @State var sending = true
    private var channel: PusherChannel
    private var client: Pusher
    private let motion = MotionService()
    private let timer = Timer.publish(every: 0.125, tolerance: 0.025, on: .main, in: .common).autoconnect()
    
    private func publishMessage() {
        guard sending, channel.subscribed else { return }
        channel.trigger(eventName: "client-update", data: createMessage())
    }
    
    private func createMessage() -> String {
        return Message(motionData: motion.motionData).encode()
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputScreen(id: "d94679b9-0784-44e5-9f05-2ad06b101acc", token: "token")
    }
}
