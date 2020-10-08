//
//  ContentView.swift
//  InputExperiment
//
//  Created by Sam Garson on 04/10/2020.
//

import SwiftUI

enum Screen {
    case scan
    case input(String)
}

struct ContentView: View {
    @State var screen: Screen = .scan
    
    var body: some View {
        NavigationView {
            switch screen {
            case .scan:
                ScanScreen { id in screen = .input(id) }
            case .input(let id):
                InputScreen(id: id)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
