// ContentView.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

///
struct ContentView: View {
    var body: some View {
        BackgroundView {
            VStack {
                headerView
                Spacer()
            }
            .padding()
        }
    }

    private var headerView: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Tesla")
                    .font(
                        .system(size: 28, weight: .bold)
                    )
                    .foregroundColor(Color("label"))
                Text("187 km")
                    .font(
                        .system(size: 17, weight: .semibold)
                    )
                    .foregroundColor(Color("label"))
                    .opacity(0.4)
            }
            Spacer()
        }
        .padding(25)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.colorScheme, .dark)
    }
}
