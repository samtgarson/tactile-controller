//
//  ContentView.swift
//  TactileController
//
//  Created by Sam Garson on 04/10/2020.
//

import SwiftUI

enum Screen {
    case loading
    case scan
    case input(String)
}

struct ContentView: View {
    @State var channel: String?
    @ObservedObject var userService = UserService()
    
    var body: some View {
        if let channel = channel, let token = userService.token {
            InputScreen(id: channel, token: token) {
                self.channel = nil
            }
        } else if userService.token != nil {
            ScanScreen { id in channel = id }
        } else {
            loader
        }
    }
    
    private var loader: some View {
        VStack(alignment: .center) {
            Spacer()
            ProgressView()
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
