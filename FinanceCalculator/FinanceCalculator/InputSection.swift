//
//  InputSection.swift
//  FinanceCalculator
//
//  Created by Hasini Thilakarathna on 2025-03-07.
//

import SwiftUI

struct InputSection<Content: View>: View {
    var content: Content
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    var body: some View {
        VStack(spacing: 15) {
            content
        }
        .cardBackground()
    }
}
