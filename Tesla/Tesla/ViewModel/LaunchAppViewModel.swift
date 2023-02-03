// LaunchAppViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Вью модель экрана запуска
final class LaunchAppViewModel: ObservableObject {
    @Published var progress = 0.0
    @Published var isActive = false
}
