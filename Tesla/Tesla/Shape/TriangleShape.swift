// TriangleShape.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Фигура Треугольник
struct TriangleShape: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX * 0.5, y: rect.midY))
            path.addCurve(
                to: CGPoint(x: rect.midX * 1.5, y: rect.midY),
                control1: CGPoint(x: rect.midX, y: rect.minY),
                control2: CGPoint(x: rect.midX, y: rect.minY)
            )
            path.addCurve(
                to: CGPoint(x: rect.midX, y: rect.maxY),
                control1: CGPoint(x: rect.maxX, y: rect.maxY),
                control2: CGPoint(x: rect.maxX, y: rect.maxY)
            )
            path.addCurve(
                to: CGPoint(x: rect.midX * 0.5, y: rect.midY),
                control1: CGPoint(x: rect.minX, y: rect.maxY),
                control2: CGPoint(x: rect.minX, y: rect.maxY)
            )
        }
    }
}
