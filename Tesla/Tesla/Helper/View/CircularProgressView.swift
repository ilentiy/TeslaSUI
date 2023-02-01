// CircularProgressView.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Кастомный круглый прогресс вью
struct CircularProgressView: View {
    // MARK: - Public Properties

    var selectedColors = [Color("startGradient"), Color("endGradient")]

    var progress = 0.0

    var body: some View {
        ZStack {
            Circle()
                .fill(
                    innerShadow
                )
                .padding()
                .neumorphismUnselectedStyle(5)
                .overlay {
                    Circle()
                        .stroke(
                            lineWidth: 25
                        )
                        .fill(innerShadow)
                }
            Circle()
                .trim(from: 0, to: progress / 15)
                .stroke(
                    selectColorToGradient(selectedColors),
                    style: StrokeStyle(
                        lineWidth: 20,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
        }
    }

    // MARK: - Private Methods

    private func selectColorToGradient(_ colors: [Color]) -> LinearGradient {
        LinearGradient(colors: colors, startPoint: .leading, endPoint: .trailing)
    }
}

struct CircularProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ClimateView()
            .environment(\.colorScheme, .dark)
    }
}
