//
//  LoanView.swift
//  FinanceCalculator
//
//  Created by Hasini Thilakarathna on 2025-02-28.
//

import SwiftUI

struct LoanView: View {
    enum SolveFor: String, CaseIterable, Identifiable {
        case monthlyPayment = "Monthly Payment"
        case loanAmount = "Loan Amount"
        case interestRate = "Interest Rate"
        case loanTerm = "Loan Term"

        var id: String { self.rawValue }
    }

    @State private var selectedSolveFor: SolveFor = .monthlyPayment

    @State private var loanAmount = ""
    @State private var monthlyPayment = ""
    @State private var rate = ""
    @State private var years = ""

    @State private var result: Double?

    var body: some View {
        NavigationStack {
            ZStack {
                ThemeManager.backgroundGradient.ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 20) {

                        Picker("Solve for", selection: $selectedSolveFor) {
                            ForEach(SolveFor.allCases) { option in
                                Text(option.rawValue).tag(option)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.horizontal)
                        .onChange(of: selectedSolveFor) { _,_ in
                            result = nil  // ✅ Reset result when user switches picker
                        }

                        VStack(spacing: 15) {
                            if selectedSolveFor != .loanAmount {
                                CustomTextField(title: "Loan Amount", placeholder: "Rs. 0.00", text: $loanAmount)
                            }

                            if selectedSolveFor != .monthlyPayment {
                                CustomTextField(title: "Monthly Payment", placeholder: "Rs. 0.00", text: $monthlyPayment)
                            }

                            if selectedSolveFor != .interestRate {
                                CustomTextField(title: "Annual Interest Rate", placeholder: "%", text: $rate)
                            }

                            if selectedSolveFor != .loanTerm {
                                CustomTextField(title: "Loan Term", placeholder: "Years", text: $years)
                            }
                        }
                        .cardBackground()

                        if let result = result {
                            ResultView(title: selectedSolveFor.rawValue, value: formattedResult(result))
                        }

                        HStack(spacing: 15) {
                            Button(action: calculate) {
                                PrimaryButton(title: "Calculate")
                            }

                            Button(action: resetFields) {
                                PrimaryButton(title: "Reset")
                            }
                        }
                        .padding(.horizontal)

                        Spacer()
                    }
                    .padding()
                }
                .navigationTitle("")
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        HStack {
                            Image(systemName: "dollarsign.circle.fill") 
                            Text("Loan Calculator")
                                .font(.headline)
                        }
                    }
                }
                .onTapGesture { hideKeyboard() }
            }
        }
    }

    private func calculate() {
        let p = Double(loanAmount.replacingOccurrences(of: ",", with: "")) ?? 0
        let payment = Double(monthlyPayment.replacingOccurrences(of: ",", with: "")) ?? 0
        let n = (Double(years.replacingOccurrences(of: ",", with: "")) ?? 0) * 12 // Convert years to months
        let r = (Double(rate.replacingOccurrences(of: ",", with: "")) ?? 0) / 100 / 12 // Convert annual rate to monthly rate

        switch selectedSolveFor {
        case .monthlyPayment:
            guard p > 0, r > 0, n > 0 else { return }
            result = (p * r) / (1 - pow(1 + r, -n))

        case .loanAmount:
            guard payment > 0, r > 0, n > 0 else { return }
            result = payment * (1 - pow(1 + r, -n)) / r

        case .interestRate:
            guard p > 0, payment > 0, n > 0 else { return }
            result = solveInterestRate(p: p, payment: payment, n: n) * 12 * 100 // Convert to annual %

        case .loanTerm:
            guard p > 0, payment > 0, r > 0 else { return }
            result = log(payment / (payment - p * r)) / log(1 + r) / 12 // Convert months to years
        }
    }

    private func solveInterestRate(p: Double, payment: Double, n: Double) -> Double {
        var guess = 0.05 / 12 // Start with a 5% annual interest rate (monthly rate)
        let maxIterations = 100
        let tolerance = 1e-6

        for _ in 0..<maxIterations {
            let denominator = 1 - pow(1 + guess, -n)
            guard denominator != 0 else { return 0 } // Prevent division by zero

            let fx = payment - (p * guess) / denominator
            let fxPrime = (p * (pow(1 + guess, -n) * n) / denominator + p / denominator)

            let newGuess = guess - fx / fxPrime
            if abs(newGuess - guess) < tolerance { return newGuess }

            guess = newGuess
        }
        return guess
    }

    private func formattedResult(_ value: Double) -> String {
        switch selectedSolveFor {
        case .interestRate:
            return (value).formattedPercentage()
        case .loanTerm:
            return (value).formattedYears()
        default:
            return (value).formattedCurrency()
        }
    }

    private func resetFields() {
        loanAmount = ""
        monthlyPayment = ""
        rate = ""
        years = ""
        result = nil
    }
}
