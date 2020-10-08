//
//  ScanScreen.swift
//  InputExperiment
//
//  Created by Sam Garson on 08/10/2020.
//

import SwiftUI
import CodeScanner

struct ScanScreen: View {
    var done: (_ id: String) -> Void
    
    @State private var isShowingScanner = false
    
    var body: some View {
        Button("Scan") { showScanner() }
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "d94679b9-0784-44e5-9f05-2ad06b101acc", completion: self.handleScan)
            }.navigationBarTitle("Input Experiment")
    }
    
    private func showScanner() {
        isShowingScanner = true
    }
    
    private func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        switch result {
        case .success(let id):
            self.isShowingScanner = false
            done(id)
        case .failure(let error):
            dump(error)
        }
    }
}

struct ScanScreen_Previews: PreviewProvider {
    static var previews: some View {
        ScanScreen { id in print(id) }
    }
}
