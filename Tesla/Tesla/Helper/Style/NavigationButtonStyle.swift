// NavigationButtonStyle.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Стиль кнопки
struct NavigationButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(12)
            .contentShape(Circle())
            .background(
                ButtonDarkBackgroundView(isHighlighted: configuration.isPressed, shape: Circle())
            )
    }
}

/// Фон темный для кнопки
struct ButtonDarkBackgroundView<S: Shape>: View {
    // MARK: - Public Properties

    var isHighlighted: Bool
    var shape: S

    var body: some View {
        ZStack {
            if isHighlighted {
                shape
                    .fill(LinearGradient.innerShadow)
                    .neumorphismUnselectedStyle()
            } else {
                shape
                    .fill(LinearGradient.innerReverseShadow)
                    .overlay(
                        shape
                            .stroke(LinearGradient.innerShadow, lineWidth: 2)
                    )
                    .neumorphismUnselectedStyle()
            }
        }
    }
}
