// Color+Extension.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Расширение добавляет кастомные цвета
extension Color {
    static let backgroundStart = Color("backgroundTop")
    static let backgroundEnd = Color("backgroundBottom")

    static let lockBackgroundStart = Color("lockTop")
    static let lockBackgroundEnd = Color("lockBottom")

    static let selectedStart = Color("startGradient")
    static let selectedEnd = Color("endGradient")

    static let darkShadow = Color("darkShadow").opacity(0.7)
    static let lightShadow = Color("lightShadow").opacity(0.2)

    static let label = Color("label")
}
