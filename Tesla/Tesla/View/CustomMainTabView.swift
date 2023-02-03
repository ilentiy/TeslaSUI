// CustomMainTabView.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Экран с таб баром
struct CustomMainTabView: View {
    // MARK: - Public Properties

    var body: some View {
        CustomTabView(selected: $selected) {
            MenuView()
                .customTabItem {
                    TabItem(imageName: Constants.Image.car)
                }
                .matchedGeometryEffect(id: Constants.Text.geometryId, in: lightView)
                .opacity(selected == 0 ? 1 : 0)
            ChargeView()
                .customTabItem {
                    TabItem(imageName: Constants.Image.bolt)
                }
                .matchedGeometryEffect(id: Constants.Text.geometryId, in: lightView)
                .opacity(selected == 1 ? 1 : 0)

            soonView
                .customTabItem {
                    TabItem(imageName: Constants.Image.map)
                }
                .matchedGeometryEffect(id: Constants.Text.geometryId, in: lightView)
                .opacity(selected == 2 ? 1 : 0)

            soonView
                .customTabItem {
                    TabItem(imageName: Constants.Image.person)
                }
                .matchedGeometryEffect(id: Constants.Text.geometryId, in: lightView)
                .opacity(selected == 3 ? 1 : 0)
        }
    }

    // MARK: - Private Properties

    @State private var selected = 0

    @Namespace private var lightView

    private var soonView: some View {
        BackgroundView(backgroundColor: .backGroundGradient) {
            VStack {
                Image(systemName: Constants.Image.gear)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 75, height: 75)
                Text(Constants.Text.soon)
                    .font(.title)
            }
            .foregroundColor(Color.label)
        }
    }
}

struct CustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        CustomMainTabView()
            .environment(\.colorScheme, .dark)
    }
}
