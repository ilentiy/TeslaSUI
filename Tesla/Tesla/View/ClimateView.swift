// ClimateView.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Экран климат контроль
struct ClimateView: View {
    // MARK: - Public Properties

    var body: some View {
        BackgroundView(backgroundColor: .backGroundGradient) {
            VStack {
                HStack {
                    backButton
                    Spacer()
                    Text(Constants.Text.climate)
                        .font(.title2)
                        .foregroundColor(Color.label)
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
    @State private var selectedFirstColor = Color.selectedStart
    @State private var selectedSecondColor = Color.selectedEnd

    private var range = 0 ... 15
    private var minimumTemperature = 15.0

    private var backButton: some View {
        Button(action: {
            presentation.wrappedValue.dismiss()
        }, label: {
            Image(systemName: Constants.Image.chevronLeft)
                .foregroundColor(Color.label)
                .frame(width: 25, height: 25)
        })
        .buttonStyle(NavigationButtonStyle())
    }

    private var settingsButton: some View {
        Button(action: {
            isAlertShown.toggle()
        }, label: {
            Image(systemName: Constants.Image.gear)
                .foregroundColor(Color.label)
                .frame(width: 25, height: 25)
        })
        .buttonStyle(NavigationButtonStyle())
    }

    private var alertView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(LinearGradient.backGroundGradient.opacity(0.5))
                .overlay {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(LinearGradient.backGroundGradient.opacity(0.5))
                        .frame(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.width / 2)
                        .neumorphismUnselectedStyle()
                        .overlay {
                            VStack {
                                Text(Constants.Text.support)
                                    .multilineTextAlignment(.center)
                                    .font(.title2)
                                    .foregroundColor(.white)
                                if let url = URL(string: Constants.Text.urlText) {
                                    Link(Constants.Text.support, destination: url)
                                        .foregroundColor(.blue)
                                        .padding(10)
                                }
                                Button(Constants.Text.okText) {
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
        DisclosureGroup(Constants.Text.climateControl, isExpanded: $isDesclosureGroupExpanded) {
            VStack {
                acButtonView
                fanButtonView
                heatButtonView
                autoButtonView
            }
            .buttonStyle(NavigationButtonStyle())
        }
        .tint(Color.label)
        .foregroundColor(Color.label)
        .padding()
    }

    private var acButtonView: some View {
        HStack(spacing: 15) {
            Text(Constants.Text.autoClimate)
                .frame(width: 40)
                .padding(.horizontal, 5)
                .foregroundColor(Color.label)
            Button {} label: {
                Image(systemName: Constants.Image.snowFlake)
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
            Text(Constants.Text.fan)
                .frame(width: 40)
                .padding(.horizontal, 5)
                .foregroundColor(Color.label)
            Button {} label: {
                Image(systemName: Constants.Image.wind)
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
            Text(Constants.Text.heat)
                .frame(width: 40)
                .padding(.horizontal, 5)
                .foregroundColor(Color.label)
            Button {} label: {
                Image(systemName: Constants.Image.heat)
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
            Text(Constants.Text.auto)
                .frame(width: 40)
                .padding(.horizontal, 5)
                .foregroundColor(Color.label)
            Button {} label: {
                Image(systemName: Constants.Image.timer)
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
            Text(
                isOnClimate ? "\(Int(minimumTemperature + circleProgress))\(Constants.Text.celsius)" : Constants.Text
                    .emptyString
            )
            .font(.largeTitle.bold())
        }
        .neumorphismUnselectedStyle()
    }

    private var headerBotomView: some View {
        RoundedRectangle(cornerRadius: 25)
            .stroke(Color.label.opacity(0.1), lineWidth: 2)
            .frame(height: 85)
            .overlay(
                HStack {
                    VStack(spacing: 0) {
                        Text(
                            "\(Constants.Text.acBottom)\(isOnClimate ? Constants.Text.onText : Constants.Text.offText)"
                        )
                        .font(.system(size: 18).bold())
                        .frame(width: 160, alignment: .leading)

                        Text(Constants.Text.bottomMesage)
                            .font(.system(size: 13))
                            .foregroundColor(Color.label)
                            .frame(width: 160, height: 45, alignment: .leading)
                    }
                    Spacer()

                    Toggle(isOn: $isOnClimate) {
                        ZStack {
                            if isOnClimate {
                                Image(systemName: Constants.Image.power)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .blur(radius: 5)
                            }
                            Image(systemName: Constants.Image.power)
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
                        LinearGradient.selectedGradient
                            .mask {
                                Image(systemName: Constants.Image.power)
                            }
                            .frame(width: 25, height: 25)
                            .padding(.bottom, 30)
                        Text(Constants.Text.onText)
                            .font(.system(size: 13))
                            .foregroundColor(Color.label)
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
                        LinearGradient.unselectedGradient
                            .mask {
                                Image(Constants.Image.vent)
                            }
                            .frame(width: 25, height: 25)
                            .padding(.bottom, 30)
                        Text(Constants.Image.vent)
                            .font(.system(size: 13))
                            .foregroundColor(Color.label)
                    }
                }
        }
        .padding(.horizontal, 30)
    }

    private var colorPickerView: some View {
        HStack(alignment: .firstTextBaseline, spacing: 30) {
            VStack {
                ColorPicker(Constants.Text.emptyString, selection: $selectedFirstColor)
                    .frame(width: 50)
                    .neumorphismUnselectedStyle(4)
                    .padding(.trailing, 15)
                Text(Constants.Text.startColor)
                    .font(.subheadline)
                    .foregroundColor(Color.label)
            }
            VStack {
                ColorPicker(Constants.Text.emptyString, selection: $selectedSecondColor)
                    .frame(width: 50)
                    .neumorphismUnselectedStyle(4)
                    .padding(.trailing, 15)
                Text(Constants.Text.endColor)
                    .font(.subheadline)
                    .foregroundColor(Color.label)
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
