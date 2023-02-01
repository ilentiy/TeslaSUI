// View+Extension.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Расширение добавляет модификаторы Стиля Неоморфизм
extension View {
    func neumorphismUnselectedStyle(_ value: CGFloat = 10) -> some View {
        modifier(NeumorphismUnselected(value: value))
    }

    func neumorphismSelectedStyle() -> some View {
        modifier(NeumorphismSelected())
    }

    func neumorphismSelectedCircleStyle() -> some View {
        modifier(NeumorphismSelectedCircle())
    }

    func neumorphismUnselectedCircleStyle() -> some View {
        modifier(NeumorphismUnselectedCircle())
    }
}

/// Расширение добавляет градиент нажатой кнопки
extension View {
    var selectedGradient: LinearGradient {
        LinearGradient(
            colors:
            [Color("startGradient"), Color("endGradient")],
            startPoint: .bottom,
            endPoint: .top
        )
    }

    var unselectedGradient: LinearGradient {
        LinearGradient(
            colors:
            [Color("label")],
            startPoint: .bottom,
            endPoint: .top
        )
    }

    var lockBackgroundGradient: LinearGradient {
        LinearGradient(
            colors:
            [Color("lockTop"), .black, .black, Color("lockBottom")],
            startPoint: .top,
            endPoint: .bottom
        )
    }

    var backGroundGradient: LinearGradient {
        LinearGradient(
            colors:
            [Color("backgroundTop"), Color("backgroundBottom")],
            startPoint: .top,
            endPoint: .bottom
        )
    }

    var innerShadow: LinearGradient {
        LinearGradient(
            colors: [Color("darkShadow").opacity(0.7), Color("ligthShadow").opacity(0.2)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    var innerReverseShadow: LinearGradient {
        LinearGradient(
            colors: [Color("darkShadow").opacity(0.7), Color("ligthShadow").opacity(0.2)],
            startPoint: .bottomTrailing,
            endPoint: .topLeading
        )
    }

    var innerBlueShadow: LinearGradient {
        LinearGradient(
            colors: [.blue.opacity(0.5), .cyan],
            startPoint: .topLeading, endPoint: .bottomTrailing
        )
    }

    var innerInvertBlueShadow: LinearGradient {
        LinearGradient(
            colors: [.blue, .cyan.opacity(0.7)],
            startPoint: .bottomTrailing, endPoint: .topLeading
        )
    }
}

struct UnlckView_Previews: PreviewProvider {
    static var previews: some View {
        ClimateView()
            .environment(\.colorScheme, .dark)
    }
}
