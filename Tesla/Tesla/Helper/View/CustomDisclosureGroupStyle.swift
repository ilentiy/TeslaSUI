// CustomDisclosureGroupStyle.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Стиль выпадающего списка
struct CustomDisclosureGroupStyle<Label: View>: DisclosureGroupStyle {
    // MARK: - Public Properties

    let button: Label

    // MARK: - Public Methods

    func makeBody(configuration: Configuration) -> some View {
        GeometryReader { proxy in
            let height = proxy.size.height

            ZStack(alignment: .top) {
                NeumorphismPressedView(
                    shape: RoundedRectangle(cornerRadius: 25),
                    backgroundColor: .backGroundGradient
                )
                ScrollView {
                    HStack(alignment: .center) {
                        configuration.label
                        Spacer()
                        Button {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                configuration.isExpanded.toggle()
                            }
                        } label: {
                            button
                                .padding(7)
                                .rotationEffect(.degrees(configuration.isExpanded ? 180 : 0))
                        }
                        .buttonStyle(NavigationButtonStyle())
                    }
                    .padding(.horizontal)
                    .frame(height: height)

                    if configuration.isExpanded {
                        configuration.content
                            //   .padding(.vertical)
                            .disclosureGroupStyle(self)
                            .scaleEffect(y: configuration.isExpanded ? 1 : 0)
                            .opacity(configuration.isExpanded ? 1 : 0)
                    }
                }
                .frame(height: configuration.isExpanded ? height * 3 : height)
            }
        }
    }
}

struct CustomDisclosureGroupStyle_Previews: PreviewProvider {
    static var previews: some View {
        ChargeView()
            .environment(\.colorScheme, .dark)
    }
}
