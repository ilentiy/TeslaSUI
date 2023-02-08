// TeslaApp.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

@main
struct TeslaApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                UnlockView()
            }
            .environment(\.colorScheme, .dark)
        }
    }
}
