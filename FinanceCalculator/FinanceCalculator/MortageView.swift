//
//  MortgageView.swift
//  FinanceCalculator
//
//  Created by Hasini Thilakarathna on 2025-02-28.
//
import SwiftUI

struct MortgageView: View {
    enum SolveFor: String, CaseIterable, Identifiable {
        case monthlyPayment = "Monthly Payment"
        case loanAmount = "Loan Amount"
        case interestRate = "Interest Rate"
        case loanTerm = "Loan Term"

        var id: String { self.rawValue }
    }

    @State private var solveFor: SolveFor = .monthlyPayment
    @State private var loanAmount = ""
    @State private var rate = ""
    @State private var years = ""
    @State private var monthlyPayment = ""
    @State private var result: Double?

    var body: some View {
        NavigationStack {
            ZStack {
                ThemeManager.backgroundGradient.ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 20) {
                        Picker("Solve for", selection: $solveFor) {
                            ForEach(SolveFor.allCases) { option in
                                Text(option.rawValue).tag(option)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding()
                        .onChange(of: solveFor) { _,_ in
                            result = nil  // ✅ Reset result when user switches picker
                        }

                        VStack(spacing: 15) {
                            if solveFor != .monthlyPayment {
                                CustomTextField(title: "Monthly Payment", placeholder: "Rs. 0.00", text: $monthlyPayment)
                            }
                            if solveFor != .loanAmount {
                                CustomTextField(title: "Loan Amount", placeholder: "Rs. 0.00", text: $loanAmount)
                            }
                            if solveFor != .interestRate {
                                CustomTextField(title: "Annual Interest Rate (%)", placeholder: "%", text: $rate)
                            }
                            if solveFor != .loanTerm {
                                CustomTextField(title: "Loan Duration (Years)", placeholder: "Years", text: $years)
                            }
                        }
                        .cardBackground()

                        if let result = result {
                            ResultView(title: solveFor.rawValue, value: formattedResult(result))
                        }

                        HStack(spacing: 15) {
                            Button(action: calculateMortgage) {
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
                            Image(systemName: "dollarsign.bank.building.fill")
                            Text("Mortgage Calculator")
                                .font(.headline)
                        }
                    }
                }
                .onTapGesture { hideKeyboard() }
            }
        }
    }

    private func calculateMortgage() {
        let loan = Double(loanAmount.replacingOccurrences(of: ",", with: "")) ?? 0
        let payment = Double(monthlyPayment.replacingOccurrences(of: ",", with: "")) ?? 0
        let r = (Double(rate.replacingOccurrences(of: ",", with: "")) ?? 0) / 100 / 12
        let n = (Double(years.replacingOccurrences(of: ",", with: "")) ?? 0) * 12

        switch solveFor {
        case .monthlyPayment:
            guard loan > 0, r > 0, n > 0 else { return }
            result = (loan * r) / (1 - pow(1 + r, -n))

        case .loanAmount:
            guard payment > 0, r > 0, n > 0 else { return }
            result = payment * (1 - pow(1 + r, -n)) / r

        case .interestRate:
            guard loan > 0, payment > 0, n > 0 else { return }
            result = solveInterestRate(loan: loan, payment: payment, n: n) * 12 * 100

        case .loanTerm:
            guard loan > 0, payment > 0, r > 0 else { return }
            result = log(payment / (payment - loan * r)) / log(1 + r) / 12
        }
    }

    private func solveInterestRate(loan: Double, payment: Double, n: Double) -> Double {
        var guess = 0.05 / 12  // Start with a 5% annual interest rate (monthly rate)
        let maxIterations = 100
        let tolerance = 1e-6

        for _ in 0..<maxIterations {
            let denominator = 1 - pow(1 + guess, -n)
            guard denominator != 0 else { return 0 }  // Prevent division by zero
            
            let fx = payment - (loan * guess) / denominator
            let fxPrime = (loan * (pow(1 + guess, -n) * n) / denominator + loan / denominator)

            let newGuess = guess - fx / fxPrime
            if abs(newGuess - guess) < tolerance { return newGuess }

            guess = newGuess
        }
        return guess
    }

    private func formattedResult(_ value: Double) -> String {
        switch solveFor {
        case .interestRate:
            return value.formattedPercentage()
        case .loanTerm:
            return value.formattedYears()
        default:
            return value.formattedCurrency()
        }
    }

    private func resetFields() {
        loanAmount = ""
        rate = ""
        years = ""
        monthlyPayment = ""
        result = nil
    }
}
