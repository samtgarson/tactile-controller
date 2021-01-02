//
//  UserService.swift
//  TactileController
//
//  Created by Sam Garson on 09/10/2020.
//

import Foundation
import SwiftUI
import Alamofire

class UserService: ObservableObject {
    @Published var token: String?
    
    init () {
        if let token = storedToken { self.token = token }
        else { fetchUser() }
    }
    
    private let storeKey = "user_token"
    private var storedToken: String? {
        return UserDefaults.standard.string(forKey: storeKey)
    }
    
    private func fetchUser() {
        guard let url = URL(string: Config.usersEndpoint) else { fatalError("Could not parse usersEndpoint") }
        
        AF.request(url)
            .validate()
            .responseDecodable(of: UserResponse.self, completionHandler: handleResponse)
    }
    
    private func handleResponse(_ response: AFDataResponse<UserResponse>) {
        guard let value = response.value else { return }
        
        UserDefaults.standard.setValue(value.token, forKey: self.storeKey)
        self.token = value.token
    }
    
    private struct UserResponse: Codable {
        let id: String
        let role: Role
        let token: String
        
        enum Role: String, Codable {
            case input = "input"
            case interface = "interface"
        }
    }
}
