//
//  InputPublisher.swift
//  TactileController
//
//  Created by Sam Garson on 12/10/2020.
//

import Foundation
import PusherSwift
import CoreMotion

class InputPublisher {
    init(id: String, token: String) {
        self.client = PusherClient(token: token).client
        self.channel = client.subscribeToPresenceChannel(channelName: "presence-\(id)")
    }

    func publish(with state: InputState) {
        guard state.sending, channel.subscribed else { return }
        
        let reference = self.referenceAttitude ?? setReferenceAttitude()
        
        let msg = Message(
            motionData: motion.motionData,
            touches: Array(state.points.values),
            referenceAttitude: reference
        ).encode()
        
        channel.trigger(eventName: "client-update", data: msg)
    }

    private var referenceAttitude: CMAttitude?
    private var channel: PusherChannel
    private var client: Pusher
    private let motion = MotionService()
    
    private func setReferenceAttitude() -> CMAttitude? {
        guard let attitude = motion.motionData?.attitude else { return nil }
        
        self.referenceAttitude = attitude
        return attitude
    }
    
}
