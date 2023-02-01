// Neumorphism.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Стиль нейроморфизм невыбранный
struct NeumorphismUnselected: ViewModifier {
    var value: CGFloat = 10

    func body(content: Content) -> some View {
        content
            .shadow(
                color: Color("ligthShadow").opacity(0.2),
                radius: value,
                x: -value,
                y: -value
            )
            .shadow(
                color: Color("darkShadow").opacity(0.7),
                radius: value,
                x: value,
                y: value
            )
    }
}

/// Стиль нейроморфизм  выбранный
struct NeumorphismSelected: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(
                color: Color("ligthShadow").opacity(0.2),
                radius: 10,
                x: 10,
                y: 10
            )
            .shadow(
                color: Color("darkShadow").opacity(0.7),
                radius: 10,
                x: -5,
                y: -5
            )
    }
}
