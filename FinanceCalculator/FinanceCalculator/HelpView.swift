//
//  HelpView.swift
//  FinanceCalculator
//
//  Created by Hasini Thilakarathna on 2025-02-28.
//

import SwiftUI

struct HelpView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    Text("📌 **Finance Calculator Help Guide**")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("This app helps you perform financial calculations, including savings, loans, and mortgages.")
                        .padding(.bottom, 10)

                    Text("🔹 **Compound Interest Savings**")
                    Text("Calculate the future value of an investment without monthly contributions.")

                    Text("🔹 **Savings with Contributions**")
                    Text("Calculate future value with regular monthly deposits.")

                    Text("🔹 **Loan Calculator**")
                    Text("Determine your monthly loan repayment.")

                    Text("🔹 **Mortgage Calculator**")
                    Text("Find out how much you need to pay monthly for a mortgage.")

                    Text("💡 **How to Use**")
                    Text("1. Select the relevant tab.")
                    Text("2. Enter the required values.")
                    Text("3. Tap 'Calculate' to get results.")
                }
                .padding()
            }
            .navigationTitle("Help Guide")
        }
    }
}
