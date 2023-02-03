// ClimateSliderView.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Кастомный слайдер экрана климат
struct ClimateSliderView: View {
    // MARK: - Public Properties

    @Binding var color: Color

    @Binding var value: Double

    @State var lastCoordinateValue: CGFloat = 0.0

    var sliderRange: ClosedRange<Double> = 0 ... 100

    var body: some View {
        GeometryReader { proxy in
            let thumbSize = proxy.size.height * 2
            let maxValue = proxy.size.width - thumbSize
            let scaleFactor = maxValue / (sliderRange.upperBound - sliderRange.lowerBound)
            let lowerBound = sliderRange.lowerBound
            let height = proxy.size.height
            let sliderValue = (self.value - lowerBound) * scaleFactor

            ZStack {
                sliderLine(height: height)
                sliderProgress(height: height, value: sliderValue)
                    .clipShape(Capsule())
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
                    colors: [Color.darkShadow, Color.clear, Color.label],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .frame(height: height)
            .clipShape(Capsule())
    }

    private func sliderProgress(height: CGFloat, value: Double) -> some View {
        HStack {
            Capsule()
                .fill(color)
                .frame(width: value, height: height)
            Spacer()
        }
    }

    private func sliderThumb(proxy: GeometryProxy) -> some View {
        ZStack {
            let thumbSize = proxy.size.height * 2
            let maxValue = proxy.size.width - thumbSize
            let scaleFactor = maxValue / (sliderRange.upperBound - sliderRange.lowerBound)
            let lowerBound = sliderRange.lowerBound
            let sliderValue = (self.value - lowerBound) * scaleFactor
            thumbView(thumbSize: thumbSize)
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

    private func thumbView(thumbSize: CGFloat) -> some View {
        ZStack {
            Capsule()
                .fill(
                    LinearGradient.backGroundGradient
                )
                .overlay {
                    Capsule()
                        .stroke(
                            LinearGradient.innerReverseShadow,
                            lineWidth: 3
                        )
                        .clipShape(Capsule())
                }
                .overlay {
                    HStack(spacing: 5) {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(LinearGradient.innerShadow)
                        RoundedRectangle(cornerRadius: 5)
                            .fill(LinearGradient.innerShadow)
                    }
                    .scaleEffect(x: 0.5, y: 0.8)
                }
        }
        .frame(width: thumbSize * 2, height: thumbSize * 1.2)
    }
}
