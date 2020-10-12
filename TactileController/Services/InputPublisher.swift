//
//  InputPublisher.swift
//  TactileController
//
//  Created by Sam Garson on 12/10/2020.
//

import Foundation
import PusherSwift

class InputPublisher {
    init(id: String, token: String) {
        self.client = PusherClient(token: token).client
        self.channel = client.subscribeToPresenceChannel(channelName: "presence-\(id)")
    }

    func publish(with state: InputState) {
        guard state.sending, channel.subscribed else { return }
        
        let msg = Message(
            motionData: motion.motionData,
            touches: Array(state.points.values)
        ).encode()
        
        channel.trigger(eventName: "client-update", data: msg)
    }

    private var channel: PusherChannel
    private var client: Pusher
    private let motion = MotionService()
    
}
