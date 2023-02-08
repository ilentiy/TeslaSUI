// UnlockView.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Экран блокировки
struct UnlockView: View {
    // MARK: - Public Properties

    var body: some View {
        backGroundView {
            VStack {
                HStack {
                    Spacer()
                    settingsButton
                        .padding(.horizontal, 30)
                }
                Spacer()
                welcomeTextView
                Spacer()
                carImageView
                    .padding(.bottom, 125)
                lockCarControlView
                Spacer()
            }
        }
        .onDisappear {
            unlockViewModel.isUnclocked = false
        }
    }

    // MARK: - Private Properties

    @StateObject private var unlockViewModel = UnlockViewModel()

    private var welcomeTextView: some View {
        VStack {
            Text("Hi, Ilentiy")
            Text("Welcome back".uppercased())
                .font(.largeTitle)
                .bold()
        }
        .opacity(unlockViewModel.isUnclocked ? 1 : 0)
    }

    private var settingsButton: some View {
        NavigationLink {
            MenuView()
                .navigationBarBackButtonHidden(true)
        } label: {
            Button(action: {}, label: {
                Image(systemName: "gearshape.fill")
                    .foregroundColor(Color("label"))
                    .frame(width: 25, height: 25)
            })
            .opacity(unlockViewModel.isUnclocked ? 1 : 0.6)
            .buttonStyle(NavigationButtonStyle())
            .disabled(unlockViewModel.isUnclocked)
        }
    }

    private var carImageView: some View {
        Image(unlockViewModel.isUnclocked ? "teslaUnlocked" : "teslaLocked")
            .resizable()
            .scaledToFill()
            .frame(height: 255)
            .offset(x: unlockViewModel.isUnclocked ? 0 : 10)
    }

    private var lockCarControlView: some View {
        Button {
            withAnimation(.linear(duration: 0.6)) {
                unlockViewModel.isUnclocked.toggle()
            }
        } label: {
            HStack {
                Text(unlockViewModel.isUnclocked ? "Unlock" : "Lock")
                    .foregroundColor(Color("label"))
                    .frame(width: 60)
                Spacer()
                selectedGradient
                    .mask {
                        Image(systemName: unlockViewModel.isUnclocked ? "lock.open.fill" : "lock.fill")
                    }
                    .frame(width: 20, height: 20)
                    .neumorphismUnselectedCircleStyle()
            }
            .padding(.horizontal)
            .background(
                RoundedRectangle(cornerRadius: 50)
                    .fill(Color("background"))
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(Color("darkShadow"), lineWidth: 4)
                            .blur(radius: 4)
                            .offset(x: 2, y: 2)
                            .mask {
                                RoundedRectangle(cornerRadius: 50)
                                    .fill(
                                        LinearGradient(
                                            colors: [.black.opacity(0.7), .clear],
                                            startPoint: .topLeading,
                                            endPoint: .bottom
                                        )
                                    )
                            }
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(Color("label"), lineWidth: 8)
                            .blur(radius: 4)
                            .offset(x: -2, y: -2)
                            .mask {
                                RoundedRectangle(cornerRadius: 50)
                                    .fill(
                                        LinearGradient(
                                            colors: [.clear, .black.opacity(0.2)],
                                            startPoint: .top,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                            }
                    )
                    .frame(height: 80)
            )
            .padding(.horizontal, 112)
        }
    }

    // MARK: - Private Methods

    private func backGroundView<Content: View>(content: () -> Content) -> some View {
        ZStack {
            Rectangle()
                .fill(
                    unlockViewModel.isUnclocked ? backGroundGradient : lockBackgroundGradient
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
            content()
        }
    }
}

struct UnlockView_Previews: PreviewProvider {
    static var previews: some View {
        UnlockView()
            .environment(\.colorScheme, .dark)
    }
}
