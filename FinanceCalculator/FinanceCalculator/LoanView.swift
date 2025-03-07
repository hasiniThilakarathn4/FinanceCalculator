//
//  Untitled.swift
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
                ThemeManager.backgroundGradient
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 20) {
                        Text("💳 Loan Calculator")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.blue)

                        Picker("Solve for", selection: $selectedSolveFor) {
                            ForEach(SolveFor.allCases) { option in
                                Text(option.rawValue).tag(option)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.horizontal)

                        VStack(spacing: 15) {
                            if selectedSolveFor != .loanAmount {
                                CustomTextField(title: "Loan Amount", placeholder: "$0.00", text: $loanAmount)
                            }

                            if selectedSolveFor != .monthlyPayment {
                                CustomTextField(title: "Monthly Payment", placeholder: "$0.00", text: $monthlyPayment)
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
                .navigationTitle("Loans")
                .onTapGesture { hideKeyboard() }
            }
        }
    }

    private func calculate() {
        let r = (Double(rate) ?? 0) / 100 / 12
        let n = (Double(years) ?? 0) * 12

        switch selectedSolveFor {
        case .monthlyPayment:
            guard let loan = Double(loanAmount) else { return }
            result = (loan * r) / (1 - pow(1 + r, -n))

        case .loanAmount:
            guard let payment = Double(monthlyPayment) else { return }
            result = payment * (1 - pow(1 + r, -n)) / r

        case .interestRate:
            // Interest rate solving typically requires iterative methods (not straightforward), so placeholder.
            result = nil

        case .loanTerm:
            guard let loan = Double(loanAmount), let payment = Double(monthlyPayment) else { return }
            result = log(payment / (payment - loan * r)) / log(1 + r) / 12
        }
    }

    private func formattedResult(_ value: Double) -> String {
        switch selectedSolveFor {
        case .interestRate:
            return "Calculation requires advanced methods"
        case .loanTerm:
            return String(format: "%.1f years", value)
        default:
            return String(format: "$%.2f", value)
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
