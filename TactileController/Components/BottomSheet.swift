//
//  BottomSheet.swift
//  TactileController
//
//  Created by Sam Garson on 31/12/2020.
//  https://swiftwithmajid.com/2019/12/11/building-bottom-sheet-in-swiftui/
//

import SwiftUI

fileprivate enum Constants {
    static let radius: CGFloat = 12
    static let snapRatio: CGFloat = 0.3
    static let frictionMultiplier: CGFloat = 8
    static let bottomMargin: CGFloat = 100
}

fileprivate struct BottomSheetViewSize: SizeReaderKey {
    static var defaultValue: CGSize = .zero
}

struct BottomSheetView<Content: View>: View {
    @Binding var isOpen: Bool
    
    let content: Content
    let title: String?
    let icon: String?
    let dismissable: Bool
    
    @State private var contentHeight: CGFloat = 0
    @GestureState private var translation: CGFloat = 0
    
    private var offset: CGFloat {
        isOpen ? 0 : contentHeight
    }
    
    init(isOpen: Binding<Bool>, title: String? = nil, icon: String? = nil, dismissable: Bool? = nil, @ViewBuilder content: () -> Content) {
        self.content = content()
        self._isOpen = isOpen
        self.title = title
        self.icon = icon
        self.dismissable = dismissable ?? true
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .bottom) {
                overlay
                
                VStack(spacing: 20) {
                    if let icon = icon {
                        Image(systemName: icon)
                            .font(.title)
                    }
                    if let title = title {
                        Text(title).bold()
                    }
                    self.content
                        .multilineTextAlignment(.center)
                        .padding()
                }
                .padding()
                .padding(.vertical, 20)
                .onSizeChanged(BottomSheetViewSize.self) { contentHeight = $0.height }
                .background(background(for: geo))
                .offset(y: offset + self.translation)
                .animation(.interactiveSpring())
                .gesture(dragGesture)
            }
        }
    }
    
    private var overlay: some View {
        Color(.secondarySystemBackground)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            .opacity(isOpen ? 0.5 : 0)
            .animation(.easeOut)
            .onTapGesture {
                guard dismissable else { return }
                withAnimation { isOpen = false }
            }
    }
    
    private func background(for geo: GeometryProxy) -> some View {
        RoundedRectangle(cornerRadius: Constants.radius)
            .fill(Color(.systemBackground))
            .frame(width: geo.frame(in: .global).width, height: contentHeight + Constants.bottomMargin)
            .offset(y: Constants.bottomMargin / 2)
    }
    
    private var dragGesture: _EndedGesture<GestureStateGesture<DragGesture, CGFloat>> {
        DragGesture().updating(self.$translation) { value, state, _ in
            if value.translation.height > 0, dismissable {
                state = value.translation.height
                return
            }
            
            state = value.translation.height / Constants.frictionMultiplier
        }.onEnded { value in
            guard abs(value.translation.height) > contentHeight * Constants.snapRatio, dismissable else {
                return
            }
            withAnimation {
                self.isOpen = value.translation.height < 0
            }
        }
    }
}

struct BottomSheet<SheetContent: View>: ViewModifier {
    var isOpen: Binding<Bool>
    var sheetContent: SheetContent
    let title: String?
    let icon: String?
    let dismissable: Bool?
    
    internal init(isOpen: Binding<Bool>, title: String? = nil, icon: String? = nil, dismissable: Bool? = nil, content: SheetContent) {
        self.isOpen = isOpen
        self.sheetContent = content
        self.title = title
        self.icon = icon
        self.dismissable = dismissable
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content
            BottomSheetView(isOpen: isOpen, title: title, icon: icon, dismissable: dismissable) { sheetContent }
        }
        .frame(maxHeight: .infinity)
        .edgesIgnoringSafeArea(.bottom)
    }
}

extension View {
    func bottomSheet<Content: View>(_ isOpen: Binding<Bool>, title: String? = nil, icon: String? = nil, dismissable: Bool? = nil, @ViewBuilder content: () -> Content) -> some View {
        self.modifier(BottomSheet(isOpen: isOpen, title: title, icon: icon, dismissable: dismissable, content: content()))
    }
}

struct BottomSheetView_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheetPreview()
    }
    
    struct BottomSheetPreview: View {
        @State() var isOpen = false
        @State() var dismissable = true
        
        var body: some View {
            ZStack {
                Color.purple.ignoresSafeArea()
                VStack {
                    Toggle("Dismissable", isOn: $dismissable)
                    Button("Toggle") { withAnimation { isOpen.toggle() } }
                }
                .foregroundColor(.white)
                .padding()
            }
            .bottomSheet($isOpen, title: "Testing", icon: "exclamationmark.triangle", dismissable: dismissable) {
                Text("foo")
                RoundedButton(action: { isOpen.toggle() }) { Text("Dismiss") }
            }
        }
    }
}
