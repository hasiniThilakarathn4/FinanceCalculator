//
//  HomeButton.swift
//  FinanceCalculator
//
//  Created by Hasini Thilakarathna on 2025-03-07.
//

import SwiftUI

struct HomeButton: View {
    var title: String
    var icon: String
    var action: () -> Void

    var body: some View {
        Button(action: {
            withAnimation(.easeInOut(duration: 0.2)) {
                action()
            }
        }) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.white)
                    .font(.title2)
                    .frame(width: 40, height: 40)

                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.leading, 5)

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundColor(.white)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(ThemeManager.primaryGradient)
            .cornerRadius(10)
            .shadow(radius: 3)
            .padding(.horizontal)
        }
    }
}
