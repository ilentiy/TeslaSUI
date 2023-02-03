// LaunchAppView.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Экран запуска
struct LaunchAppView: View {
    // MARK: - Public Properties

    var body: some View {
        VStack {
            if launchAppViewModel.isActive {
                UnlockView()
                    .transition(.opacity)
            } else {
                launchView(progress: launchAppViewModel.progress)
                    .transition(.opacity)
            }
        }
        .onAppear {
            withAnimation(.linear(duration: 5)) {
                launchAppViewModel.progress = 1
                DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                    withAnimation(.easeIn(duration: 2)) {
                        self.launchAppViewModel.isActive = true
                    }
                }
            }
        }
    }

    // MARK: - Private Properties

    @StateObject private var launchAppViewModel = LaunchAppViewModel()

    // MARK: - Private Methods

    private func launchView(progress: Double) -> some View {
        BackgroundView(backgroundColor: .lockBackgroundGradient) {
            HStack(alignment: .center) {
                ZStack(alignment: .center) {
                    TeslaIconShape()
                        .trim(from: 0, to: progress)
                        .stroke(
                            Color.selectedStart,
                            style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round)
                        )
                        .blur(radius: 10)
                    NeumorphismPressedView(shape: TeslaIconShape(), backgroundColor: .backGroundGradient)
                    TeslaIconShape()
                        .trim(from: 0, to: progress)
                        .stroke(
                            Color.selectedStart,
                            style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round)
                        )
                        .blur(radius: 5)
                        .opacity(0.7)
                    TeslaIconShape()
                        .trim(from: 0, to: progress)
                        .stroke(
                            Color.selectedEnd,
                            style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round)
                        )
                        .opacity(0.7)
                }
                .padding(.top, UIScreen.main.bounds.height * 0.3)
                .padding(.horizontal, 25)
            }
        }
    }
}

struct LaunchAppView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchAppView()
            .environment(\.colorScheme, .dark)
    }
}
