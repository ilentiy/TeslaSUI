// LinearGradient+Extension.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Расширение добавляет собвтвенные градиенты
extension LinearGradient {
    static let selectedGradient = LinearGradient(
        colors:
        [Color.selectedStart, Color.selectedEnd],
        startPoint: .bottom,
        endPoint: .top
    )

    static let unselectedGradient = LinearGradient(
        colors:
        [Color.label],
        startPoint: .bottom,
        endPoint: .top
    )

    static let lockBackgroundGradient = LinearGradient(
        colors:
        [Color.lockBackgroundStart, .black, .black, Color.lockBackgroundEnd],
        startPoint: .top,
        endPoint: .bottom
    )

    static let backGroundGradient = LinearGradient(
        colors:
        [Color.backgroundStart, Color.backgroundEnd],
        startPoint: .top,
        endPoint: .bottom
    )

    static let innerShadow = LinearGradient(
        colors: [Color.darkShadow, Color.lightShadow],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let innerReverseShadow = LinearGradient(
        colors: [Color.darkShadow, Color.lightShadow],
        startPoint: .bottomTrailing,
        endPoint: .topLeading
    )

    static let innerBlueShadow = LinearGradient(
        colors: [.blue.opacity(0.5), .cyan],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )

    static let innerInvertBlueShadow = LinearGradient(
        colors: [.blue, .cyan.opacity(0.7)],
        startPoint: .bottomTrailing, endPoint: .topLeading
    )
}
