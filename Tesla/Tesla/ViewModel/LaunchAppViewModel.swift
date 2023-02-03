// LaunchAppViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

final class LaunchAppViewModel: ObservableObject {
    @Published var progress = 0.0
    @Published var isActive = false
}
