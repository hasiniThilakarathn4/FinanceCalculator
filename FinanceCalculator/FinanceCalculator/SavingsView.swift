//
//  SavingsView.swift
//  FinanceCalculator
//
//  Created by Hasini Thilakarathna on 2025-02-28.
//

import SwiftUI

struct SavingsView: View {
    enum SolveFor: String, CaseIterable, Identifiable {
        case futureValue, monthlyContribution, interestRate, duration

        var id: Self { self }
        var displayName: String {
            switch self {
            case .futureValue: return "Future Value"
            case .monthlyContribution: return "Monthly Contribution"
            case .interestRate: return "Interest Rate"
            case .duration: return "Duration"
            }
        }
    }

    @State private var solveFor: SolveFor = .futureValue
    @State private var principal = ""
    @State private var monthlyContribution = ""
    @State private var rate = ""
    @State private var years = ""
    @State private var futureValue = ""

    @State private var result: Double?

    var body: some View {
        NavigationStack {
            ZStack {
                ThemeManager.backgroundGradient.ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 20) {
                        Picker("Solve For", selection: $solveFor) {
                            ForEach(SolveFor.allCases) { option in
                                Text(option.displayName).tag(option)
                            }
                        }
                        .pickerStyle(.segmented)
                        .padding(.horizontal)
                        .onChange(of: solveFor) {_, _ in
                            result = nil  // ✅ Reset result when user switches picker
                        }

                        VStack(spacing: 15) {
                            CustomTextField(title: "Initial Investment", placeholder: "Rs. 0.00", text: $principal)

                            if solveFor != .monthlyContribution {
                                CustomTextField(title: "Monthly Contribution", placeholder: "Rs. 0.00", text: $monthlyContribution)
                            }

                            if solveFor != .interestRate {
                                CustomTextField(title: "Annual Interest Rate (%)", placeholder: "0%", text: $rate)
                            }

                            if solveFor != .duration {
                                CustomTextField(title: "Duration (Years)", placeholder: "Years", text: $years)
                            }

                            if solveFor != .futureValue {
                                CustomTextField(title: "Future Value", placeholder: "Rs. 0.00", text: $futureValue)
                            }
                        }
                        .cardBackground()

                        if let result = result {
                            ResultView(title: solveFor.displayName, value: formattedResult(result))
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
                            Image(systemName: "banknote")
                            Text("Savings Calculator")
                                .font(.headline)
                        }
                    }
                }
                .onTapGesture { hideKeyboard() }
            }
        }
    }

    private func calculate() {
        let p = Double(principal.replacingOccurrences(of: ",", with: "")) ?? 0
        let m = Double(monthlyContribution.replacingOccurrences(of: ",", with: "")) ?? 0
        let r = (Double(rate.replacingOccurrences(of: ",", with: "")) ?? 0) / 100 / 12
        let t = (Double(years.replacingOccurrences(of: ",", with: "")) ?? 0) * 12
        let fv = Double(futureValue.replacingOccurrences(of: ",", with: "")) ?? 0

        switch solveFor {
        case .futureValue:
            result = (m * (pow(1 + r, t) - 1) / r) + (p * pow(1 + r, t))

        case .monthlyContribution:
            result = (fv - p * pow(1 + r, t)) * r / (pow(1 + r, t) - 1)

        case .interestRate:
            guard p + m * t > 0, fv > 0 else { return }
            result = (pow(fv / (p + m * t), 1 / t) - 1) * 12 * 100

        case .duration:
            guard p > 0, fv > 0, r > 0 else { return }
            result = log((fv * r + m) / (p * r + m)) / log(1 + r) / 12
        }
    }

    private func formattedResult(_ value: Double) -> String {
        switch solveFor {
        case .interestRate:
            return (value).formattedPercentage()
        case .duration:
            return (value).formattedYears()
        default:
            return (value).formattedCurrency()
        }
    }

    private func resetFields() {
        principal = ""
        monthlyContribution = ""
        rate = ""
        years = ""
        futureValue = ""
        result = nil
    }
}
