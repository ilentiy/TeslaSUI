// NeumorphismCircle.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Стиль нейроморфизм  невыбранный круглый
struct NeumorphismSelectedCircle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(12)
            .contentShape(Circle())
            .background(
                Circle()
                    .fill(
                        Color("background")
                    )
                    .neumorphismSelectedStyle()
            )
    }
}

/// Стиль нейроморфизм  выбранный круглый
struct NeumorphismUnselectedCircle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(12)
            .contentShape(Circle())
            .background(
                Circle()
                    .fill(
                        Color("background")
                    )
                    .neumorphismUnselectedStyle()
            )
    }
}
