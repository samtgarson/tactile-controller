//
//  PusherClient.swift
//  InputExperiment
//
//  Created by Sam Garson on 08/10/2020.
//

import Foundation
import PusherSwift

class PusherClient {
    private var client: Pusher
    private let clientOptions = PusherClientOptions(
        authMethod: .endpoint(authEndpoint: Config.pusherAuthEndpoint),
        host: .cluster(Config.pusherCluster)
    )
    
    init() {
        client = Pusher(key: Config.pusherKey, options: clientOptions)
        client.connect()
        
        #if DEBUG
        client.delegate = self
        #endif
    }
    
    func subscribe(to channelName: String) -> PusherChannel {
        return client.subscribe(channelName)
    }
}

extension PusherClient: PusherDelegate {
    func changedConnectionState(from old: ConnectionState, to new: ConnectionState) {
        print("old: \(old.stringValue()) -> new: \(new.stringValue())")
    }
    
    func subscribedToChannel(name: String) {
        print("Subscribed to \(name)")
    }
    
    func debugLog(message: String) {
        print(message)
    }
    
    func failedToSubscribeToChannel(name: String, response: URLResponse?, data: String?, error: NSError?) {
        print("Failed to subscribe to channel \(name)")
    }
}
