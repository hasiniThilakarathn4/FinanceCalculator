//
//  ResultView.swift
//  FinanceCalculator
//
//  Created by Hasini Thilakarathna on 2025-03-07.
//

import SwiftUI

struct ResultView: View {
    var title: String
    var value: String

    var body: some View {
        VStack {
            Text(title).font(.headline).foregroundColor(.gray)
            Text(value).font(.title).bold().foregroundColor(.blue)
        }
        .cardBackground()
    }
}
