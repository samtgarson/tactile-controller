//
//  ContentView.swift
//  InputExperiment
//
//  Created by Sam Garson on 04/10/2020.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Button("Send message") { sendMessage() }
    }
    
    private func sendMessage() {
        let uuid = UUID().uuidString
        print(uuid)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
