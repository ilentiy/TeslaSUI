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
            withAnimation(.easeInOut(duration: 5)) {
                launchAppViewModel.progress = 1
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    withAnimation(.easeIn(duration: 1)) {
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
            VStack {
                HStack {
                    Spacer()
                    ZStack {
                        TeslaIconShape()
                            .trim(from: 0, to: progress)
                            .stroke(.cyan, style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                            .blur(radius: 5)

                        TeslaIconShape()
                            .trim(from: 0, to: progress)
                            .stroke(.cyan, style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                            .opacity(0.7)
                    }
                    Spacer()
                }
                .padding(.horizontal)
            }
        }
    }
}
