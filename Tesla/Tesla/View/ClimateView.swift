// ClimateView.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Экран климат контроль
struct ClimateView: View {
    // MARK: - Public Properties

    var body: some View {
        BackgroundView {
            VStack {
                HStack {
                    backButton
                    Spacer()
                    Text("CLIMATE")
                        .font(.title2)
                        .foregroundColor(Color("label"))
                    Spacer()
                    settingsButton
                }
                .padding(.horizontal)
                .padding(.vertical, 30)
                Spacer()
                climateProgressView
                Spacer()
                climateDisclosureGroupView
                Spacer()
            }
            .overlay {
                ZStack {
                    bottomSheetView
                    if isAlertShown {
                        alertView
                            .transition(.opacity)
                    }
                }
            }
        }
    }

    // MARK: - Private Properties

    @Environment(\.presentationMode) private var presentation

    @StateObject private var climateViewModel = ClimateViewModel()

    @State private var circleProgress: CGFloat = 0
    @State private var progress: CGFloat = 0
    @State private var isDesclosureGroupExpanded = true
    @State private var isAlertShown = false
    @State private var isOnClimate = false
    @State private var selectedFirstColor = Color("startGradient")
    @State private var selectedSecondColor = Color("endGradient")

    private var range = 0 ... 15
    private var minimumTemperature = 15.0

    private var backButton: some View {
        Button(action: {
            presentation.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "chevron.left")
                .foregroundColor(Color("label"))
                .frame(width: 25, height: 25)
        })
        .buttonStyle(NavigationButtonStyle())
    }

    private var settingsButton: some View {
        Button(action: {
            isAlertShown.toggle()
        }, label: {
            Image(systemName: "gearshape.fill")
                .foregroundColor(Color("label"))
                .frame(width: 25, height: 25)
        })
        .buttonStyle(NavigationButtonStyle())
    }

    private var alertView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(backGroundGradient.opacity(0.5))
                .overlay {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(backGroundGradient.opacity(0.5))
                        .frame(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.width / 2)
                        .neumorphismUnselectedStyle()
                        .overlay {
                            VStack {
                                Text("Tesla Support")
                                    .multilineTextAlignment(.center)
                                    .font(.title2)
                                    .foregroundColor(.white)
                                if let url = URL(string: "https://www.tesla.com/support") {
                                    Link("Tesla Support", destination: url)
                                        .foregroundColor(.blue)
                                        .padding(10)
                                }
                                Button("Ok") {
                                    withAnimation {
                                        isAlertShown.toggle()
                                    }
                                }
                                .foregroundColor(.red)
                                .font(.title2)
                            }
                        }
                }
        }
        .background(.ultraThinMaterial)
        .ignoresSafeArea()
    }

    private var climateDisclosureGroupView: some View {
        DisclosureGroup("Climate control", isExpanded: $isDesclosureGroupExpanded) {
            VStack {
                acButtonView
                fanButtonView
                heatButtonView
                autoButtonView
            }
            .buttonStyle(NavigationButtonStyle())
        }
        .tint(Color("label"))
        .foregroundColor(Color("label"))
        .padding()
    }

    private var acButtonView: some View {
        HStack(spacing: 15) {
            Text("A/С")
                .frame(width: 40)
                .padding(.horizontal, 5)
                .foregroundColor(Color("label"))
            Button {} label: {
                Image(systemName: "snowflake")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.gray)
            }
            .frame(width: 30, height: 30)
            Slider(value: $circleProgress, in: 0 ... 15, step: 0.3)
                .tint(selectedFirstColor)
                .padding(.vertical, 30)
                .padding(.horizontal)
                .animation(
                    isOnClimate ? .easeInOut : .easeInOut(duration: circleProgress * 2).delay(1),
                    value: circleProgress
                )
                .disabled(!isOnClimate)
        }
    }

    private var fanButtonView: some View {
        HStack(spacing: 15) {
            Text("Fan")
                .frame(width: 40)
                .padding(.horizontal, 5)
                .foregroundColor(Color("label"))
            Button {} label: {
                Image(systemName: "wind")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.gray)
            }
            .frame(width: 30, height: 30)
            withAnimation {
                Slider(value: $progress, in: 0 ... 15, step: 0.3)
            }
            .padding(.vertical, 30)
            .padding(.horizontal)
        }
    }

    private var heatButtonView: some View {
        HStack(spacing: 15) {
            Text("Heat")
                .frame(width: 40)
                .padding(.horizontal, 5)
                .foregroundColor(Color("label"))
            Button {} label: {
                Image(systemName: "humidity.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.gray)
            }
            .frame(width: 30, height: 30)
            withAnimation {
                Slider(value: $progress, in: 0 ... 15, step: 0.3)
            }
            .padding(.vertical, 30)
            .padding(.horizontal)
        }
    }

    private var autoButtonView: some View {
        HStack(spacing: 15) {
            Text("Auto")
                .frame(width: 40)
                .padding(.horizontal, 5)
                .foregroundColor(Color("label"))
            Button {} label: {
                Image(systemName: "timer")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.gray)
            }
            .frame(width: 30, height: 30)
            withAnimation {
                Slider(value: $progress, in: 0 ... 15, step: 0.3)
            }
            .padding(.vertical, 30)
            .padding(.horizontal)
        }
    }

    private var climateProgressView: some View {
        ZStack {
            CircularProgressView(selectedColors: [selectedFirstColor, selectedSecondColor], progress: circleProgress)
                .frame(width: 140)
                .animation(.easeInOut, value: circleProgress)
            Text(isOnClimate ? "\(Int(minimumTemperature + circleProgress))° C" : "")
                .font(.largeTitle.bold())
        }
        .neumorphismUnselectedStyle()
    }

    private var headerBotomView: some View {
        RoundedRectangle(cornerRadius: 25)
            .stroke(Color("label").opacity(0.1), lineWidth: 2)
            .frame(height: 85)
            .overlay(
                HStack {
                    VStack(spacing: 0) {
                        Text("A/C is On")
                            .font(.system(size: 18).bold())
                            .frame(width: 160, alignment: .leading)

                        Text("Tap to turn off or swipe up for a fast setup")
                            .font(.system(size: 13))
                            .foregroundColor(Color("label"))
                            .frame(width: 160, height: 45, alignment: .leading)
                    }
                    Spacer()

                    Toggle(isOn: $isOnClimate) {
                        ZStack {
                            if isOnClimate {
                                Image(systemName: "power")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .blur(radius: 5)
                            }
                            Image(systemName: "power")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 15, height: 15)
                                .foregroundColor(isOnClimate ? .white : .black)
                                .padding(5)
                        }
                        .animation(.easeInOut, value: isOnClimate)
                    }
                    .toggleStyle(PowerToggleStyle())
                    .onChange(of: isOnClimate) { _ in
                        circleProgress = 0
                    }
                }
                .padding()
            )
            .padding(5)
            .padding(.horizontal, 10)
    }

    private var stepperView: some View {
        HStack(alignment: .top, spacing: 70) {
            Button {}
            label: {
                    VStack {
                        selectedGradient
                            .mask {
                                Image(systemName: "power")
                            }
                            .frame(width: 25, height: 25)
                            .padding(.bottom, 30)
                        Text("On")
                            .font(.system(size: 13))
                            .foregroundColor(Color("label"))
                    }
                }
            CustomStepper(
                isStarted: $isOnClimate,
                value: Binding(
                    get: {
                        Int(circleProgress)
                    },
                    set: { newValue in
                        if range ~= newValue {
                            circleProgress = CGFloat(newValue)
                        }
                    }
                )
            )
            .disabled(!isOnClimate)
            Button {}
            label: {
                    VStack {
                        unselectedGradient
                            .mask {
                                Image("Vent")
                            }
                            .frame(width: 25, height: 25)
                            .padding(.bottom, 30)
                        Text("Vent")
                            .font(.system(size: 13))
                            .foregroundColor(Color("label"))
                    }
                }
        }
        .padding(.horizontal, 30)
    }

    private var colorPickerView: some View {
        HStack(alignment: .firstTextBaseline, spacing: 30) {
            VStack {
                ColorPicker("", selection: $selectedFirstColor)
                    .frame(width: 50)
                    .neumorphismUnselectedStyle(4)
                    .padding(.trailing, 15)
                Text("Start color")
                    .font(.subheadline)
                    .foregroundColor(Color("label"))
            }
            VStack {
                ColorPicker("", selection: $selectedSecondColor)
                    .frame(width: 50)
                    .neumorphismUnselectedStyle(4)
                    .padding(.trailing, 15)
                Text("End color")
                    .font(.subheadline)
                    .foregroundColor(Color("label"))
            }
        }
        .padding(.horizontal, 80)
        .padding(.bottom, 50)
    }

    private var bottomSheetView: some View {
        ClimateBottomSheetView(shape: RoundedRectangle(cornerRadius: 25)) {
            VStack {
                headerBotomView
                Spacer()
                stepperView
                Spacer()
                colorPickerView
                Spacer()
            }
        }
    }
}

struct ClimateView_Previews: PreviewProvider {
    static var previews: some View {
        ClimateView()
            .environment(\.colorScheme, .dark)
    }
}
