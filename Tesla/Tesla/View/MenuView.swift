// MenuView.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Экран с навигацией на другие экраны
struct MenuView: View {
    // MARK: - Public Properties

    var body: some View {
        BackgroundView(backgroundColor: .backGroundGradient) {
            VStack(spacing: 30) {
                headerView
                carImageView
                controllPanelView
                navigationLinkView
                Spacer()
            }
            .padding()
        }
    }

    // MARK: - Private Properties

    @Environment(\.presentationMode) private var presentation

    @State private var isUnlock = false
    @State private var isNavigationTapped = false
    @State private var tagSelected = -1

    private var menuIconImageNames = ["Lock", "Climate", "Charge", "Open"]

    private var headerView: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(Constants.Text.tesla)
                    .font(
                        .system(size: 28, weight: .bold)
                    )

                Text(Constants.Text.allKm)
                    .font(
                        .system(size: 17, weight: .semibold)
                    )
                    .opacity(0.4)
            }
            .foregroundColor(Color.label)
            Spacer()
            settingsButton
        }
        .padding(25)
    }

    private var settingsButton: some View {
        Button(action: {}, label: {
            Image(systemName: Constants.Image.person)
                .scaledToFill()
                .foregroundColor(Color.label)
                .frame(width: 25, height: 25)
        })
        .buttonStyle(NavigationButtonStyle())
    }

    private var carImageView: some View {
        Image(Constants.Image.teslaMain)
            .resizable()
            .scaledToFill()
            .frame(height: 150)
            .padding(.horizontal)
            .padding(.bottom, 40)
            .shadow(color: Color.lightShadow, radius: 20, x: 10, y: 10)
    }

    private var controllPanelView: some View {
        HStack(spacing: 30) {
            ForEach(0 ..< menuIconImageNames.count) { index in
                makeMenuButton(index: index)
            }
        }
        .padding(.horizontal, 30)
        .background(
            RoundedRectangle(cornerRadius: 50)
                .fill(Color.backgroundStart)
                .neumorphismUnselectedStyle()
                .frame(height: 100)
        )
    }

    private var navigationLinkView: some View {
        NavigationLink(isActive: $isNavigationTapped) {
            ClimateView()
                .navigationBarBackButtonHidden()
        } label: {
            Text(Constants.Text.emptyString)
        }
    }

    private func makeMenuButton(index: Int) -> some View {
        Button(
            action: {
                withAnimation {
                    tagSelected = index
                }
                if index == 1 {
                    isNavigationTapped.toggle()
                }
                if index == 0 {
                    presentation.wrappedValue.dismiss()
                }
            },
            label: {
                Image(menuIconImageNames[index])
                    .frame(width: 25, height: 25)
                    .padding(10)
                    .overlay {
                        ZStack {
                            Circle()
                                .stroke(LinearGradient.selectedGradient, lineWidth: 3)
                                .opacity(tagSelected == index ? 1 : 0)
                                .blur(radius: 6)
                            Circle()
                                .stroke(LinearGradient.selectedGradient, lineWidth: 2)
                                .opacity(tagSelected == index ? 1 : 0)
                            (tagSelected == index ? LinearGradient.selectedGradient : LinearGradient.unselectedGradient)
                                .mask {
                                    Image(menuIconImageNames[index])
                                }
                        }
                    }
            }
        )
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
            .environment(\.colorScheme, .dark)
    }
}
