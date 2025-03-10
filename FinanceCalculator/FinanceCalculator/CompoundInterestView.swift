//
//  CompoundInterestView.swift
//  FinanceCalculator
//
//  Created by Hasini Thilakarathna on 2025-02-28.
//
import SwiftUI

struct CompoundInterestView: View {
    enum SolveFor: String, CaseIterable, Identifiable {
        case futureValue, presentValue, interestRate, timePeriod

        var id: String { self.rawValue }

        var displayName: String {
            switch self {
            case .futureValue: return "Future Value"
            case .presentValue: return "Present Value"
            case .interestRate: return "Interest Rate"
            case .timePeriod: return "Time Period"
            }
        }
    }

    @State private var selectedSolveFor: SolveFor = .futureValue
    @State private var principal = ""
    @State private var rate = ""
    @State private var years = ""
    @State private var compoundingPeriods = ""
    @State private var futureValue = ""

    @State private var result: Double?

    var body: some View {
        NavigationStack {
            ZStack {
                ThemeManager.backgroundGradient.ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 20) {
                        Picker("Solve For", selection: $selectedSolveFor) {
                            ForEach(SolveFor.allCases) { option in
                                Text(option.displayName).tag(option)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding()
                        .onChange(of: selectedSolveFor) {_, _ in
                            result = nil  // ✅ Reset result when user switches picker
                        }

                        VStack(spacing: 15) {
                            if selectedSolveFor != .presentValue {
                                CustomTextField(title: "Initial Investment (Rs)", placeholder: "Rs. 0.00", text: $principal)
                            }
                            if selectedSolveFor != .futureValue {
                                CustomTextField(title: "Future Value (Rs)", placeholder: "Rs. 0.00", text: $futureValue)
                            }
                            if selectedSolveFor != .interestRate {
                                CustomTextField(title: "Annual Interest Rate (%)", placeholder: "%", text: $rate)
                            }
                            if selectedSolveFor != .timePeriod {
                                CustomTextField(title: "Duration (Years)", placeholder: "Years", text: $years)
                            }

                            CustomTextField(title: "Compounding Periods/Year", placeholder: "e.g., 12", text: $compoundingPeriods)
                        }
                        .cardBackground()

                        if result != nil {
                            ResultView(title: selectedSolveFor.displayName, value: formattedResult())
                        }

                        HStack {
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
                            Image(systemName: "chart.line.uptrend.xyaxis") 
                                .font(.headline)
                            Text("Interest Calculator")
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
        let r = (Double(rate.replacingOccurrences(of: ",", with: "")) ?? 0) / 100
        let t = Double(years.replacingOccurrences(of: ",", with: "")) ?? 0
        let fv = Double(futureValue.replacingOccurrences(of: ",", with: "")) ?? 0
        let m = Double(compoundingPeriods.replacingOccurrences(of: ",", with: "")) ?? 1  // Default to 1 if empty
        let i = r / m  // Periodic rate
        let n = t * m  // Total periods

        switch selectedSolveFor {
        case .futureValue:
            result = p * pow(1 + i, n)

        case .presentValue:
            result = fv / pow(1 + i, n)

        case .interestRate:
            guard p > 0, fv > 0 else { return }
            result = (pow(fv / p, 1 / n) - 1) * m * 100

        case .timePeriod:
            guard p > 0, fv > 0, i > 0 else { return }
            result = log(fv / p) / (m * log(1 + i))
        }
    }

    private func formattedResult() -> String {
        switch selectedSolveFor {
        case .futureValue, .presentValue:
            return (result ?? 0).formattedCurrency()
        case .interestRate:
            return (result ?? 0).formattedPercentage()
        case .timePeriod:
            return (result ?? 0).formattedYears()
        }
    }

    private func resetFields() {
        principal = ""
        rate = ""
        years = ""
        compoundingPeriods = ""
        futureValue = ""
        result = nil
    }
}
