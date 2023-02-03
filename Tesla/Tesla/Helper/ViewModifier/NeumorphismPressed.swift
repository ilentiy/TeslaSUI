// NeumorphismPressed.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Эффект нажатого элемента
struct NeumorphismPressedView<S: Shape>: View {
    // MARK: - Public Properties

    var shape: S
    var backgroundColor: LinearGradient?

    var body: some View {
        ZStack {
            ZStack {
                if let backgroundColor = backgroundColor {
                    shape
                        .fill(backgroundColor)
                } else {
                    shape
                        .stroke(.clear)
                }
            }
            .overlay(
                shape
                    .stroke(Color.darkShadow, lineWidth: 8)
                    .blur(radius: 8)
                    .offset(x: 10, y: 10)
                    .mask(
                        shape
                            .fill(
                                LinearGradient(
                                    colors: [Color.black, Color.black, Color.clear],
                                    startPoint: .top,
                                    endPoint: .bottomTrailing
                                )
                            )
                    )
            )
            .overlay(
                shape
                    .stroke(Color.lightShadow, lineWidth: 8)
                    .blur(radius: 8)
                    .offset(x: -10, y: -10)

                    .mask(
                        shape
                            .fill(
                                LinearGradient(
                                    colors: [Color.clear, Color.black],
                                    startPoint: .topLeading,
                                    endPoint: .bottom
                                )
                            )
                    )
            )
        }
    }
}
