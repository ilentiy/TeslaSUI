// ChargeSliderView.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Кастомный слайдер
struct ChargeSliderView: View {
    // MARK: - Public Properties

    @Binding var value: Double

    @State var lastCoordinateValue: CGFloat = 0.0

    var sliderRange: ClosedRange<Double> = 0 ... 100

    var body: some View {
        GeometryReader { proxy in
            let height = proxy.size.height
            ZStack {
                sliderLine(height: height)
                HStack {
                    sliderThumb(proxy: proxy)
                    Spacer()
                }
            }
        }
    }

    // MARK: - Private Methods

    private func sliderLine(height: CGFloat) -> some View {
        Capsule()
            .fill(
                LinearGradient(
                    colors: [Color.darkShadow, Color.label],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .frame(height: height)
    }

    private func sliderThumb(proxy: GeometryProxy) -> some View {
        ZStack {
            let thumbSize = proxy.size.height * 2
            let maxValue = proxy.size.width - thumbSize
            let scaleFactor = maxValue / (sliderRange.upperBound - sliderRange.lowerBound)
            let lowerBound = sliderRange.lowerBound
            let sliderValue = (self.value - lowerBound) * scaleFactor
            TreangleShape()
                .fill(LinearGradient.selectedGradient)
                .frame(width: thumbSize * 1.3, height: thumbSize)
                .offset(x: sliderValue)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            if abs(value.translation.width) < 0.1 {
                                self.lastCoordinateValue = sliderValue
                            }
                            if value.translation.width > 0 {
                                let nextCoordinateValue = min(
                                    maxValue,
                                    self.lastCoordinateValue + value.translation.width
                                )
                                self.value = (nextCoordinateValue / scaleFactor) + lowerBound
                            } else {
                                let nextCoordinateValue = max(
                                    0,
                                    self.lastCoordinateValue + value.translation.width
                                )
                                self.value = (nextCoordinateValue / scaleFactor) + lowerBound
                            }
                        }
                )
        }
    }
}

/// Фигура Треугольник
struct TreangleShape: Shape {
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

struct ChargeSliderView_Previews: PreviewProvider {
    static var previews: some View {
        CustomMainTabView()
            .environment(\.colorScheme, .dark)
    }
}
