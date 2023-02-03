// CustomTabView.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Preference Key
struct TabItemPreferenceKey: PreferenceKey {
    // MARK: - Public Properties

    static var defaultValue: [TabItem] = []

    // MARK: - Public Methods

    static func reduce(value: inout [TabItem], nextValue: () -> [TabItem]) {
        value += nextValue()
    }
}

/// Кастомный таб бар
struct CustomTabView<Content: View>: View {
    // MARK: - Public Properties

    @Binding var selected: Int

    var body: some View {
        ZStack(alignment: .bottom) {
            content
            VStack(alignment: .center) {
                Button {} label: {
                    Image(systemName: "plus")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 30, height: 30)
                        .padding(20)
                        .foregroundColor(Color.selectedStart)
                }
                .background(
                    Circle()
                        .fill(Color.backgroundStart)
                        .overlay {
                            Circle()
                                .stroke(LinearGradient.innerReverseShadow, lineWidth: 4)
                                .blur(radius: 2)
                        }
                )
                .padding(.bottom, -30)

                HStack {
                    tabItemsView
                        .padding(.top, 30)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 35)
                .padding(.vertical, 5)
                .background(
                    CustomTabBarShape()
                        .fill(.black)
                        .overlay(
                            CustomTabBarShape()
                                .stroke(
                                    Color.lightShadow,
                                    lineWidth: 2
                                )
                                .blur(radius: 1.5)
                        )
                        .ignoresSafeArea(edges: .bottom)
                )
                .ignoresSafeArea()
            }
        }
        .onPreferenceChange(TabItemPreferenceKey.self) { value in
            tabItems = value
        }
    }

    // MARK: - Private Properties

    @State private var tabItems: [TabItem] = []
    @State private var ligthOpacity: CGFloat = 0.6
    @State private var ligthScale: CGFloat = 1
    @State private var ligthRadius: CGFloat = 25

    private var content: Content

    private var tabItemsView: some View {
        ForEach(Array(tabItems.enumerated()), id: \.offset) { index, item in
            Spacer()
            tabItemView(index: index, item: item)
            Spacer()
            if index == (tabItems.count - 1) / 2 {
                Spacer()
                    .padding(.horizontal, 30)
            }
        }
    }

    // MARK: - Private Methods

    private func tabItemView(index: Int, item: TabItem) -> some View {
        Image(systemName: item.imageName)
            .resizable()
            .scaledToFit()
            .frame(width: 25, height: 25)
            .foregroundColor(selected == index ? Color.selectedStart : Color.label)
            .padding(.horizontal)
            .background(
                ZStack {
                    if selected == index {
                        Circle()
                            .fill(LinearGradient.selectedGradient)
                            .frame(height: 75)
                            .blur(radius: ligthRadius)
                            .opacity(ligthOpacity)
                            .scaleEffect(x: ligthScale, y: ligthScale)
                    }
                }
            )
            .onTapGesture {
                withAnimation(.easeIn(duration: 0.5)) {
                    ligthScale = 0.5
                    ligthOpacity = 0
                    ligthRadius = 1
                }
                withAnimation(.linear.delay(0.25)) {
                    selected = index
                }
                withAnimation(.easeInOut(duration: 0.5).delay(0.25)) {
                    ligthOpacity = 0.6
                    ligthScale = 1
                    ligthRadius = 25
                }
            }
    }

    init(selected: Binding<Int>, @ViewBuilder content: () -> Content) {
        _selected = selected
        self.content = content()
    }
}
