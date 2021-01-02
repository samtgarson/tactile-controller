//
//  Config.swift
//  TactileController
//
//  Created by Sam Garson on 09/10/2020.
//

import Foundation

public struct Configuration: Codable {
    let pusherKey: String
    let pusherCluster: String
    let pusherAuthEndpoint: String
    let usersEndpoint: String
    
    static func read() -> Configuration {
        guard let configFileName = ProcessInfo.processInfo.environment["CONFIG_FILE"],
              let filePath = Bundle.main.path(forResource: configFileName, ofType: nil),
              let fileData = FileManager.default.contents(atPath: filePath) else {
            fatalError("Config path not found (file name: \(ProcessInfo.processInfo.environment["CONFIG_FILE"] ?? "not provided")")
        }
        
        do {
            let decoder = PropertyListDecoder()
            return try decoder.decode(Configuration.self, from: fileData)
        } catch {
            fatalError("Failed to decode Info.plist")
        }
    }
}
