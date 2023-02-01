// MenuView.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Экран с навигацией на другие экраны
struct MenuView: View {
    // MARK: - Public Properties

    var body: some View {
        BackgroundView {
            VStack(spacing: 30) {
                headerView
                carImageView
                Spacer()
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
            settingsButton
        }
        .padding(25)
    }

    private var settingsButton: some View {
        Button(action: {}, label: {
            Image(systemName: "person.fill")
                .scaledToFill()
                .foregroundColor(Color("label"))
                .frame(width: 25, height: 25)
        })
        .buttonStyle(NavigationButtonStyle())
    }

    private var carImageView: some View {
        Image("teslaMain")
            .resizable()
            .scaledToFill()
            .frame(height: 150)
            .padding(.horizontal)
            .padding(.bottom, 40)
            .shadow(color: Color("ligthShadow").opacity(0.25), radius: 20, x: 10, y: 10)
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
                .fill(Color("background"))
                .neumorphismUnselectedStyle()
                .frame(height: 100)
        )
    }

    private var navigationLinkView: some View {
        NavigationLink(isActive: $isNavigationTapped) {
            ClimateView()
                .navigationBarBackButtonHidden()
        } label: {
            Text("")
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
                                .stroke(selectedGradient, lineWidth: 3)
                                .opacity(tagSelected == index ? 1 : 0)
                                .blur(radius: 6)
                            Circle()
                                .stroke(selectedGradient, lineWidth: 2)
                                .opacity(tagSelected == index ? 1 : 0)
                            (tagSelected == index ? selectedGradient : unselectedGradient)
                                .mask {
                                    Image(menuIconImageNames[index])
                                }
                        }
                    }
            }
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
            .environment(\.colorScheme, .dark)
    }
}
