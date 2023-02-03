// ChargeView.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Экран зарядки
struct ChargeView: View {
    // MARK: - Private Enum

    enum Numbers {
        static let chargeCount = 0 ..< 2
    }

    // MARK: - Public Properties

    var body: some View {
        BackgroundView(backgroundColor: .backGroundGradient) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    HStack {
                        backButton
                        Spacer()
                        Text(Constants.Text.charging)
                            .font(.title2)
                            .foregroundColor(Color.label)
                        Spacer()
                        settingsButton
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 30)
                    carImageView
                    chargeProgressView
                    disclosureGroupView
                }
            }
        }
    }

    // MARK: - Private Properties

    @Environment(\.presentationMode) private var presentation
    @State private var chargeValue = 65.0
    @State private var isExpandedNeardy: Bool = false

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
        Button(action: {}, label: {
            Image(systemName: Constants.Image.gearshape)
                .foregroundColor(Color.label)
                .frame(width: 25, height: 25)
        })
        .buttonStyle(NavigationButtonStyle())
    }

    private var carImageView: some View {
        Image(Constants.Image.tesla)
            .resizable()
            .scaledToFill()
            .frame(height: 150)
    }

    private var chargeProgressView: some View {
        VStack {
            HStack(spacing: 0) {
                Text("\(Int(chargeValue))")
                    .font(.title.bold())
                Text(Constants.Text.pecentSign)
                    .font(.title2.bold())
                    .foregroundColor(Color.label)
            }
            VStack(alignment: .trailing) {
                ProgressView(value: chargeValue / 100)
                    .progressViewStyle(ChargeProgressViewStyle())
                    .frame(height: 40)
                HStack {
                    VStack(alignment: .trailing, spacing: 0) {
                        Rectangle()
                            .fill(LinearGradient.selectedGradient)
                            .frame(width: 3, height: 10)

                        Text(Constants.Text.sevenPercent)
                            .font(.system(size: 13))
                            .foregroundColor(Color.white)
                    }
                    .frame(width: 55, alignment: .trailing)
                    VStack(alignment: .trailing, spacing: 0) {
                        Rectangle()
                            .fill(LinearGradient.selectedGradient)
                            .frame(width: 3, height: 10)
                        Text(Constants.Text.tenPercent)
                            .font(.system(size: 13))
                            .foregroundColor(Color.label)
                    }
                    .frame(width: 60, alignment: .trailing)
                }
            }
            VStack(spacing: 10) {
                ChargeSliderView(value: $chargeValue)
                    .frame(height: 10)
                Text(Constants.Text.limit)
                    .font(.system(size: 13))
                    .foregroundColor(Color.label)
            }
            Spacer()
        }
        .frame(width: 275)
    }

    private var disclosureGroupView: some View {
        VStack {
            DisclosureGroup(isExpanded: $isExpandedNeardy) {
                ForEach(Numbers.chargeCount) { _ in
                    HStack(alignment: .center) {
                        VStack(alignment: .leading) {
                            Text(Constants.Text.superCharger)
                                .foregroundColor(.white)

                            Text(Constants.Text.limit)
                                .foregroundColor(.white)

                            HStack(spacing: 0) {
                                Text(Constants.Text.countCharge)
                                    .foregroundColor(.white)
                                Text(Constants.Text.availableCharge)
                            }
                        }
                        .font(.system(size: 13))
                        Spacer()
                        VStack {
                            Image(systemName: Constants.Image.boltCircle)
                                .foregroundColor(Color.selectedStart)
                            Text(Constants.Text.kmText)
                        }
                    }
                    .font(.system(size: 13))
                    .foregroundColor(Color.label)
                }
                .padding(.vertical)
                .padding(.horizontal, 25)

            } label: {
                Text(Constants.Text.neardy)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(Color.label)
            }
            .frame(height: 100)
            .padding(.horizontal, 25)
            .disclosureGroupStyle(CustomDisclosureGroupStyle(button: Image(systemName: Constants.Image.chevronUp)))
            .padding(.vertical)
        }
    }
}

struct ChargeView_Previews: PreviewProvider {
    static var previews: some View {
        ChargeView()
            .environment(\.colorScheme, .dark)
    }
}
