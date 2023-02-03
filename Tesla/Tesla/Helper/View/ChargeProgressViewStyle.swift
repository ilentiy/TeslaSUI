// ChargeProgressViewStyle.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Стиль прогрес вью
struct ChargeProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        let progress = configuration.fractionCompleted ?? 0

        return ZStack {
            ChargeProgressShape()
                .fill(
                    LinearGradient(
                        colors: [Color.lightShadow, .clear, Color.lightShadow],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .background {
                    ChargeProgressShape()
                        .fill(
                            Color.selectedStart
                        )
                        .scaleEffect(y: 2.4, anchor: .bottom)
                        .scaleEffect(x: progress, anchor: .leading)
                        .opacity(0.2)
                        .blur(radius: 12)
                }

            ChargeProgressShape()
                .fill(
                    LinearGradient.selectedGradient
                )
                .blur(radius: 2)
                .scaleEffect(x: progress, anchor: .leading)
                .mask(ChargeProgressShape())

            ChargeProgressShape()
                .fill(
                    Color.selectedEnd
                )
                .scaleEffect(y: 1.7, anchor: .bottom)
                .opacity(0.3)
                .blur(radius: 12)
                .scaleEffect(x: progress, anchor: .leading)
        }
    }
}

struct ChargeProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CustomMainTabView()
            .environment(\.colorScheme, .dark)
    }
}
