//
//  Config.swift
//  TactileController
//
//  Created by Sam Garson on 09/10/2020.
//

import Foundation

public struct Configuration {
    let pusherKey: String
    let pusherCluster: String
    let pusherAuthEndpoint: String
    let usersEndpoint: String
    let debug: Bool
    
    internal init() {
        #if DEBUG
        
        pusherKey = "b107da4fc65ebbd81a0c"
        pusherCluster = "eu"
        pusherAuthEndpoint = "http://192.168.0.228:3000/api/auth"
        usersEndpoint = "http://192.168.0.228:3000/api/users"
        debug = true
        
        #else
        
        pusherKey = "d787868a3ec746b05b36"
        pusherCluster = "eu"
        pusherAuthEndpoint = "https://tactile-controller.samgarson.com/api/auth"
        usersEndpoint = "https://tactile-controller.samgarson.com/api/users"
        debug = false
        
        #endif
    }
}
