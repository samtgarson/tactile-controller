//
//  SizeReader.swift
//  TactileController
//
//  Created by Sam Garson on 01/01/2021.
//  https://stackoverflow.com/a/63305935
//

import SwiftUI

protocol SizeReaderKey: PreferenceKey where Value == CGSize {}

extension SizeReaderKey {
    static func reduce(value _: inout CGSize, nextValue: () -> CGSize) {
        _ = nextValue()
    }
}

struct SizeReader<Key: SizeReaderKey>: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { geo in
                    Color.clear
                        .preference(key: Key.self, value: geo.size)
                }
            )
    }
}

extension View {
    func onSizeChanged<Key: SizeReaderKey>(
        _ key: Key.Type,
        perform action: @escaping (CGSize) -> Void) -> some View
    {
        self
            .modifier(SizeReader<Key>())
            .onPreferenceChange(key) { value in
                action(value)
            }
    }
}
