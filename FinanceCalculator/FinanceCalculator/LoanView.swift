//
//  Untitled.swift
//  FinanceCalculator
//
//  Created by Hasini Thilakarathna on 2025-02-28.
//
import SwiftUI

struct LoanView: View {
    @State private var loanAmount: String = ""
    @State private var rate: String = ""
    @State private var years: String = ""
    @State private var result: Double?

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Loan Amount ($)", text: $loanAmount)
                        .keyboardType(.decimalPad)

                    TextField("Annual Interest Rate (%)", text: $rate)
                        .keyboardType(.decimalPad)

                    TextField("Loan Term (Years)", text: $years)
                        .keyboardType(.decimalPad)
                }

                if let result = result {
                    Section {
                        Text("Monthly Payment: $\(result, specifier: "%.2f")")
                    }
                }

                Button("Calculate") {
                    calculateLoanPayment()
                }
                .buttonStyle(.borderedProminent)
            }
            .navigationTitle("Loan Calculator")
        }
    }

    private func calculateLoanPayment() {
        guard let loan = Double(loanAmount),
              let r = Double(rate),
              let t = Double(years) else { return }

        let i = r / 100 / 12
        let n = t * 12
        let payment = (loan * i) / (1 - pow(1 + i, -n))

        result = payment
    }
}

#Preview {
    LoanView()
}
