// CustomStepper.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Кастомный счетчик
struct CustomStepper: View {
    @Binding var isStarted: Bool

    @Binding var value: Int

    var body: some View {
        HStack {
            Button {
                value -= 1
            } label: {
                Image(systemName: "chevron.left")
            }
            Text("\(isStarted ? 15 + value : 0)°")
                .font(.system(size: 34))
                .padding(.horizontal)
            Button {
                value += 1
            } label: {
                Image(systemName: "chevron.right")
            }
        }
        .foregroundColor(.white)
    }
}
