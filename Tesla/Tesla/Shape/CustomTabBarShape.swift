// CustomTabBarShape.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Форма кастомного таба
struct CustomTabBarShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(
            to: CGPoint(x: rect.minX - 10, y: rect.midY)
        )

        path.addLine(
            to: CGPoint(x: rect.minX, y: rect.maxY + 10)
        )

        path.addLine(
            to: CGPoint(x: rect.maxX, y: rect.maxY + 10)
        )

        path.addLine(
            to: CGPoint(x: rect.maxX + 10, y: rect.midY)
        )

        path.addLine(
            to: CGPoint(x: rect.maxX + 10, y: rect.midY)
        )

        path.addCurve(
            to: CGPoint(x: rect.midX * 1.7, y: rect.minY),
            control1: CGPoint(x: rect.midX * 1.9, y: rect.minY),
            control2: CGPoint(x: rect.midX * 1.9, y: rect.minY)
        )

        path.addLine(
            to: CGPoint(x: rect.midX * 1.4, y: rect.minY)
        )

        path.addCurve(
            to: CGPoint(x: rect.midX * 1.25, y: rect.midY * 0.25),
            control1: CGPoint(x: rect.midX * 1.32, y: rect.minY),
            control2: CGPoint(x: rect.midX * 1.3, y: rect.minY)
        )

        path.addQuadCurve(
            to: CGPoint(x: rect.midX * 0.75, y: rect.midY * 0.25),
            control: CGPoint(x: rect.midX, y: rect.midY * 1.5)
        )

        path.addCurve(
            to: CGPoint(x: rect.midX * 0.6, y: rect.minY),
            control1: CGPoint(x: rect.midX * 0.7, y: rect.minY),
            control2: CGPoint(x: rect.midX * 0.67, y: rect.minY)
        )

        path.addLine(
            to: CGPoint(x: rect.midX * 0.5, y: rect.minY)
        )

        path.addLine(
            to: CGPoint(x: rect.midX * 0.3, y: rect.minY)
        )

        path.addCurve(
            to: CGPoint(x: rect.minX - 10, y: rect.midY),
            control1: CGPoint(x: rect.midX * 0.1, y: rect.minY),
            control2: CGPoint(x: rect.midX * 0.1, y: rect.minY)
        )
        path.closeSubpath()
        return path
    }
}
