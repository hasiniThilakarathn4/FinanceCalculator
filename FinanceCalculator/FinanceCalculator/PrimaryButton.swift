//
//  PrimaryButton.swift
//  FinanceCalculator
//
//  Created by Hasini Thilakarathna on 2025-03-07.
//
import SwiftUI

import SwiftUI

struct PrimaryButton: View {
    var title: String
    var body: some View {
        Text(title)
            .frame(maxWidth: .infinity)
            .padding()
            .background(ThemeManager.primaryGradient)
            .foregroundColor(.white)
            .cornerRadius(10)
            .shadow(radius: 3)
    }
}
