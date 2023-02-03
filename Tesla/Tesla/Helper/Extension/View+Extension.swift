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

extension View {
    func customTabItem(_ label: () -> TabItem) -> some View {
        modifier(TabItemModifier(tabBarItem: label()))
    }
}

struct UnlckView_Previews: PreviewProvider {
    static var previews: some View {
        ClimateView()
            .environment(\.colorScheme, .dark)
    }
}
