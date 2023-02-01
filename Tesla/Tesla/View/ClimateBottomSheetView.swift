// ClimateBottomSheetView.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Выезжающий снизу экран
struct ClimateBottomSheetView<Content: View, S: Shape>: View {
    // MARK: - Private Properties

    let shape: S
    let content: () -> Content

    var body: some View {
        ZStack {
            content()
                .frame(width: UIScreen.main.bounds.width, height: height)
                .background(.ultraThinMaterial, in: shape)
                .overlay(
                    shape
                        .stroke(Color("label").opacity(0.2), lineWidth: 2)
                )
                .ignoresSafeArea(.all, edges: .bottom)
                .offset(y: height + 130)
                .offset(y: currentMenuOffsetY)
                .gesture(dragGesture)
        }
        .ignoresSafeArea(edges: .top)
    }

    // MARK: - Private Properties

    @GestureState private var gestureOffset = CGSize.zero

    @State private var currentMenuOffsetY: CGFloat = 0.0
    @State private var lastMenuOffsetY: CGFloat = 0.0

    private let height = UIScreen.main.bounds.height / 2 - 50

    private var dragGesture: some Gesture {
        DragGesture()
            .updating($gestureOffset) { value, state, _ in
                state = value.translation
                onChangeMenuOffset()
            }
            .onEnded { _ in
                let maxHeight: CGFloat = height - 100
                withAnimation {
                    if -currentMenuOffsetY > maxHeight / 3 {
                        currentMenuOffsetY = -maxHeight
                    } else {
                        currentMenuOffsetY = 0
                    }
                    lastMenuOffsetY = currentMenuOffsetY
                }
            }
    }

    // MARK: - Public Methods

    func onChangeMenuOffset() {
        DispatchQueue.main.async {
            self.currentMenuOffsetY = gestureOffset.height + lastMenuOffsetY
        }
    }
}
