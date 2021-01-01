//
//  BottomSheet.swift
//  TactileController
//
//  Created by Sam Garson on 31/12/2020.
//  https://swiftwithmajid.com/2019/12/11/building-bottom-sheet-in-swiftui/
//

import SwiftUI

fileprivate enum Constants {
    static let radius: CGFloat = 8
    static let snapRatio: CGFloat = 0.3
    static let frictionMultiplier: CGFloat = 12
    static let bottomMargin: CGFloat = 100
}

fileprivate struct BottomSheetViewSize: SizeReaderKey {
    static var defaultValue: CGSize = .zero
}

struct BottomSheetView<Content: View>: View {
    @Binding var isOpen: Bool
    
    let content: Content
    let overlayColor = Color(.secondarySystemBackground)
    
    @State private var contentHeight: CGFloat = 0
    @GestureState private var translation: CGFloat = 0
    
    private var offset: CGFloat {
        isOpen ? 0 : contentHeight
    }
    
    init(isOpen: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self.content = content()
        self._isOpen = isOpen
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .bottom) {
                self.overlayColor
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                    .opacity(isOpen ? 0.5 : 0)
                    .animation(.easeOut)
                    .onTapGesture { withAnimation { isOpen = false } }
                self.content
                    .onSizeChanged(BottomSheetViewSize.self) { contentHeight = $0.height }
                    .background(
                        RoundedRectangle(cornerRadius: Constants.radius)
                            .fill(Color(.systemBackground))
                            .frame(width: geo.frame(in: .global).width, height: contentHeight + Constants.bottomMargin)
                            .offset(y: Constants.bottomMargin / 2)
                    )
                    .offset(y: offset + self.translation)
                    .animation(.interactiveSpring())
                    .gesture(
                        DragGesture().updating(self.$translation) { value, state, _ in
                            if value.translation.height > 0 {
                                state = value.translation.height
                                return
                            }
                            
                            state = value.translation.height / Constants.frictionMultiplier
                        }.onEnded { value in
                            guard abs(value.translation.height) > contentHeight * Constants.snapRatio else {
                                return
                            }
                            withAnimation {
                                self.isOpen = value.translation.height < 0
                            }
                        }
                    )
            }
        }
    }
}

struct BottomSheetView_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheetPreview()
    }
    
    struct BottomSheetPreview: View {
        @State() var isOpen = false
        
        var body: some View {
            ZStack {
                Color.green.ignoresSafeArea()
                Button("Toggle") { withAnimation { isOpen.toggle() } }
                    .foregroundColor(.white)
                BottomSheetView(isOpen: $isOpen) {
                    Text("foo")
                        .frame(height: 200)
                }.edgesIgnoringSafeArea(.all)
            }
        }
    }
}
