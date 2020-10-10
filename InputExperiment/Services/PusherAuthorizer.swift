//
//  PusherAuthorizer.swift
//  InputExperiment
//
//  Created by Sam Garson on 10/10/2020.
//

import Foundation
import PusherSwift

class PusherAuthorizer: AuthRequestBuilderProtocol {
    private var token: String
    
    init(_ token: String) {
        self.token = token
    }
    
    func requestFor(socketID: String, channelName: String) -> URLRequest? {
        var request = URLRequest(url: URL(string: Config.pusherAuthEndpoint)!)
        request.httpMethod = "POST"
        
        let body = try! JSONSerialization.data(withJSONObject: [ "socket_id": socketID, "channel_name": channelName ])
        request.httpBody = body
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(token, forHTTPHeaderField: "Authorization")
        return request
    }
}
