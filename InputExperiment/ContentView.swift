//
//  ContentView.swift
//  InputExperiment
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
        NavigationView {
            if let channel = channel, let token = userService.token {
                InputScreen(id: channel, token: token)
            } else if userService.token == nil {
                loader
            } else {
                ScanScreen { id in channel = id }
            }
        }
    }
    
    private var loader: some View {
        VStack(alignment: .center) {
            Spacer()
            ProgressView()
            Spacer()
        }
    }
    
//    private var screen: Screen {
//
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
