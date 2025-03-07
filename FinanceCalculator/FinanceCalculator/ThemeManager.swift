//
//  ThemeManager.swift
//  FinanceCalculator
//
//  Created by Hasini Thilakarathna on 2025-03-07.
//

import SwiftUI

struct ThemeManager {
    static var backgroundGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.white]),
            startPoint: .top, endPoint: .bottom
        )
    }

    static var primaryGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [Color.blue, Color.purple]),
            startPoint: .leading, endPoint: .trailing
        )
    }

    static let cardBackgroundColor = Color.white

    struct CardBackground: ViewModifier {
        func body(content: Content) -> some View {
            content
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(cardBackgroundColor)
                        .shadow(radius: 3)
                )
                .padding(.horizontal)
        }
    }
}

extension View {
    func cardBackground() -> some View {
        self.modifier(ThemeManager.CardBackground())
    }
}
