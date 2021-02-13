//
//  PusherClient.swift
//  TactileController
//
//  Created by Sam Garson on 08/10/2020.
//

import Foundation
import PusherSwift

enum PusherEvent {
    case changedConnectionState
    case subscribedToChannel
    case debugLog
    case failedToSubscribeToChannel
    case receivedError
}

typealias PusherEventHandler = (String) -> Void

class PusherClient {
    private var client: Pusher
    private var delegate: PusherDelegate?
    private var handlers = [(PusherEvent, PusherEventHandler)]()
    
    init(token: String, delegate: PusherDelegate? = nil) {
        let options = PusherClientOptions(
            authMethod: .authRequestBuilder(authRequestBuilder: PusherAuthorizer(token)),
            host: .cluster(Config.pusherCluster)
        )
        
        client = Pusher(key: Config.pusherKey, options: options)
        client.connect()
        
        client.delegate = self
    }
    
    func subscribeToPresenceChannel(channelName: String) -> PusherChannel {
        client.subscribeToPresenceChannel(channelName: channelName)
    }
    
    func on(_ event: PusherEvent, _ handler: @escaping PusherEventHandler) {
        handlers.append((event, handler))
    }
    
    fileprivate func call(_ event: PusherEvent, _ payload: String) {
        handlers.forEach { key, handler in
            guard key == event else { return }
            
            handler(payload)
        }
    }
}

extension PusherClient: PusherDelegate {
    func changedConnectionState(from old: ConnectionState, to new: ConnectionState) {
        debugPrint("old: \(old.stringValue()) -> new: \(new.stringValue())")
        call(.changedConnectionState, new.stringValue())
    }
    
    func subscribedToChannel(name: String) {
        debugPrint("Subscribed to \(name)")
        call(.subscribedToChannel, name)
    }
    
    func debugLog(message: String) {
        debugPrint(message)
        call(.debugLog, message)
    }
    
    func failedToSubscribeToChannel(name: String, response: URLResponse?, data: String?, error: NSError?) {
        debugPrint("Failed to subscribe to channel \(name)")
        call(.failedToSubscribeToChannel, name)
    }
    
    func receivedError(error: PusherError) {
        debugPrint("Received error: \(error.message) (\(error.code ?? 0)")
        call(.receivedError, error.message)
    }
    
    private func debugPrint(_ msg: String) {
        if Config.debug { print(msg) }
    }
}
