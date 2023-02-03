// TeslaApp.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

@main
struct TeslaApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                LaunchAppView()
            }
            .environment(\.colorScheme, .dark)
        }
    }
}
