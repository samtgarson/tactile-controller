//
//  InputScreen.swift
//  InputExperiment
//
//  Created by Sam Garson on 08/10/2020.
//

import SwiftUI

struct InputScreen: View {
    var id: String
    
    var body: some View {
        Text(id)
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputScreen(id: "d94679b9-0784-44e5-9f05-2ad06b101acc")
    }
}
