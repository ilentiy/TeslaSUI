// PowerToggleStyle.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Стиль для переключателя
struct PowerToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            configuration.label
                .padding()
                .tint(.white)
        }
        .background(ToggleBlueBackgroundView(isHighlighted: configuration.isOn, shape: Circle()))
    }
}

/// Фон для стиля переключения
struct ToggleBlueBackgroundView<S: Shape>: View {
    var isHighlighted: Bool
    var shape: S

    var body: some View {
        ZStack {
            if isHighlighted {
                shape
                    .fill(innerBlueShadow)
                    .neumorphismUnselectedStyle()
            } else {
                shape
                    .fill(innerInvertBlueShadow)
                    .overlay(
                        shape
                            .stroke(innerShadow, lineWidth: 2)
                    )
                    .neumorphismUnselectedStyle()
            }
        }
    }
}
