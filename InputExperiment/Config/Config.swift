//
//  Config.swift
//  InputExperiment
//
//  Created by Sam Garson on 09/10/2020.
//

import Foundation

public struct Configuration: Codable {
    public let pusherAppId: String
    public let pusherKey: String
    public let pusherCluster: String
    public let pusherAuthEndpoint: String
    
    static func read() -> Configuration {
        guard let configFileName = ProcessInfo.processInfo.environment["CONFIG_FILE"],
              let filePath = Bundle.main.path(forResource: configFileName, ofType: nil),
              let fileData = FileManager.default.contents(atPath: filePath) else {
            fatalError("Config path not found")
        }
        
        do {
            let decoder = PropertyListDecoder()
            return try decoder.decode(Configuration.self, from: fileData)
        } catch {
            fatalError("Failed to decode Info.plist")
        }
    }
}
