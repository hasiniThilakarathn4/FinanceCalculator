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
                ThemeManager.backgroundGradient.edgesIgnoringSafeArea(.all)
                ScrollView {
                    VStack(spacing: 20) {

                        Picker("Solve for", selection: $solveFor) {
                            ForEach(SolveFor.allCases) { option in
                                Text(option.rawValue).tag(option)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding()

                        InputSection {
                            if selectedSolveFor != .monthlyPayment {
                                CustomTextField(title: "Monthly Payment", placeholder: "$0.00", text: $monthlyPayment)
                            }
                            if selectedSolveFor != .loanAmount {
                                CustomTextField(title: "Loan Amount", placeholder: "$0.00", text: $loanAmount)
                            }
                            if selectedSolveFor != .interestRate {
                                CustomTextField(title: "Interest Rate (%)", placeholder: "%", text: $rate)
                            }
                            if selectedSolveFor != .loanTerm {
                                CustomTextField(title: "Loan Duration (Years)", placeholder: "Years", text: $years)
                            }
                        }
                        .cardBackground()

                        if let result = result {
                            ResultView(title: selectedSolveFor.rawValue, value: String(format: "$%.2f", result))
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
                .navigationTitle("🏡 Mortgage Calculator")
                .onTapGesture {
                    hideKeyboard()
                }
            }
        }
    }

    @State private var selectedSolveFor: SolveFor = .monthlyPayment

    private func calculateMortgage() {
        guard let r = Double(rate), r > 0 else { return }

        let i = r / 100 / 12

        switch selectedSolveFor {
        case .monthlyPayment:
            guard let loan = Double(loanAmount), let t = Double(years) else { return }
            let n = t * 12
            result = loan * i / (1 - pow(1 + i, -n))

        case .loanTerm:
            guard let loan = Double(loanAmount), let payment = Double(monthlyPayment), loan > 0, paymentValid(payment, loan, i) else { return }
            let n = log(payment / (payment - loan * i)) / log(1 + i)
            result = n / 12

        case .interestRate, .loanAmount:
            break // Additional implementations can go here
        }
    }

    private func resetFields() {
        loanAmount = ""
        rate = ""
        years = ""
        monthlyPayment = ""
        result = nil
    }

    private func paymentValid(_ payment: Double, _ loan: Double, _ i: Double) -> Bool {
        payment > loan * i
    }
}
