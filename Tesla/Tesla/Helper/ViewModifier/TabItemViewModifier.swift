// TabItemViewModifier.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Модификатор таб итема
struct TabItemModifier: ViewModifier {
    let tabBarItem: TabItem

    func body(content: Content) -> some View {
        content
            .preference(key: TabItemPreferenceKey.self, value: [tabBarItem])
    }
}
