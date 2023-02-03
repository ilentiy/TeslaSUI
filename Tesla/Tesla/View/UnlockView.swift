// UnlockView.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Экран блокировки
struct UnlockView: View {
    // MARK: - Public Properties
    
    var body: some View {
        BackgroundView(backgroundColor: unlockViewModel.isUnclocked ? LinearGradient.backGroundGradient : LinearGradient
            .lockBackgroundGradient) {
                VStack {
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
                    }
                    lockCarControlView
                    
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
            Text(Constants.Text.nameWelcome)
            Text(Constants.Text.welcome.uppercased())
                .font(.largeTitle)
                .bold()
        }
        .opacity(unlockViewModel.isUnclocked ? 1 : 0)
    }
    
    private var settingsButton: some View {
        NavigationLink {
            CustomMainTabView()
                .navigationBarBackButtonHidden(true)
        } label: {
            Button(action: {}, label: {
                Image(systemName: Constants.Image.gear)
                    .foregroundColor(Color.label)
                    .frame(width: 25, height: 25)
            })
            .opacity(unlockViewModel.isUnclocked ? 1 : 0.6)
            .buttonStyle(NavigationButtonStyle())
            .disabled(unlockViewModel.isUnclocked)
        }
    }
    
    private var carImageView: some View {
        Image(unlockViewModel.isUnclocked ? Constants.Image.teslaUnlock : Constants.Image.teslaLock)
            .resizable()
            .scaledToFill()
            .frame(height: 255)
            .offset(x: unlockViewModel.isUnclocked ? 0 : 10)
    }
    
    private var lockCarControlView: some View {
        HStack {
            Text(unlockViewModel.isUnclocked ? Constants.Text.unlock : Constants.Text.lock)
                .font(.system(size: 13))
                .foregroundColor(Color.white)
                .frame(width: 60)
            
            Button {
                withAnimation(.easeOut(duration: 1)) {
                    unlockViewModel.isUnclocked.toggle()
                }
            } label: {
                ZStack {
                    Circle()
                        .fill(LinearGradient.selectedGradient)
                        .blur(radius: 12)
                    
                    LinearGradient.selectedGradient
                        .mask {
                            Image(
                                systemName: unlockViewModel.isUnclocked ? Constants.Image.unlock : Constants.Image.lock
                            )
                        }
                        .frame(width: 25, height: 25)
                }
            }
            .buttonStyle(NavigationButtonStyle())
        }
        .frame(width: 120, height: 60)
        .animation(.linear(duration: 0), value: unlockViewModel.isUnclocked)
        .padding(10)
        .background(
            NeumorphismPressedView(shape: RoundedRectangle(cornerRadius: 50), backgroundColor: .innerShadow)
        )
        .padding(.horizontal, 112)
    }
}

struct UnlockView_Previews: PreviewProvider {
    static var previews: some View {
        UnlockView()
            .environment(\.colorScheme, .dark)
    }
}
