// BackgroundView.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Основной фон экранов
struct BackgroundView<Content: View>: View {
    // MARK: - Public Properties

    var backgroundColor: LinearGradient
    var content: () -> Content

    var body: some View {
        ZStack {
            Rectangle()
                .fill(
                    backgroundColor
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
            content()
        }
    }
}
