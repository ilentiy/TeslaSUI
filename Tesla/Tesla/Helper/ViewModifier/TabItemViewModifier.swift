// TabItemViewModifier.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Модификатор таб итема
struct TabItemModifier: ViewModifier {
    // MARK: - Public Properties

    let tabBarItem: TabItem

    // MARK: - Public Methods

    func body(content: Content) -> some View {
        content
            .preference(key: TabItemPreferenceKey.self, value: [tabBarItem])
    }
}
