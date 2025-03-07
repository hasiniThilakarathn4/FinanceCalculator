//
//  CompoundInterestView.swift
//  FinanceCalculator
//
//  Created by Hasini Thilakarathna on 2025-02-28.
//
import SwiftUI

struct CompoundInterestView: View {
    enum SolveFor: String, CaseIterable, Identifiable {
        case futureValue
        case presentValue
        case interestRate
        case timePeriod

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
    @State private var principal: String = ""
    @State private var rate: String = ""
    @State private var years: String = ""
    @State private var compoundingPeriods: String = ""
    @State private var futureValue: String = ""

    @State private var result: Double?

    var body: some View {
        NavigationStack {
            ZStack {
                ThemeManager.backgroundGradient.edgesIgnoringSafeArea(.all)
                ScrollView {
                    VStack(spacing: 20) {
                        Picker("Solve For", selection: $selectedSolveFor) {
                            ForEach(SolveFor.allCases) { option in
                                Text(option.displayName).tag(option)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding()

                        VStack(spacing: 15) {
                            if selectedSolveFor != .presentValue {
                                CustomTextField(title: "Initial Investment ($)", placeholder: "$0.00", text: $principal)
                            }
                            if selectedSolveFor != .futureValue {
                                CustomTextField(title: "Future Value ($)", placeholder: "$0.00", text: $futureValue)
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

                        if let result = result {
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
                .navigationTitle("📈 Interest Calculator")
                .onTapGesture { hideKeyboard() }
            }
        }
    }

    private func calculate() {
        guard let m = Double(compoundingPeriods), m > 0 else { return }

        switch selectedSolveFor {
        case .futureValue:
            guard let p = Double(principal), let r = Double(rate), let t = Double(years) else { return }
            let i = r / 100 / m
            result = p * pow((1 + i), m * t)

        case .presentValue:
            guard let fv = Double(futureValue), let r = Double(rate), let t = Double(years) else { return }
            let i = r / 100 / m
            let n = t * m
            result = fv / pow((1 + i), n)

        case .interestRate:
            guard let p = Double(principal), let fv = Double(futureValue), let t = Double(years), p > 0, fv > 0 else { return }
            let n = t * m
            result = (pow(fv/p, 1/n) - 1) * m * 100

        case .timePeriod:
            guard let fv = Double(futureValue), let p = Double(principal), let r = Double(rate) else { return }
            let i = r / 100 / m
            result = log(fv / p) / (m * log(1 + i))
        }
    }

    private func formattedResult() -> String {
        switch selectedSolveFor {
        case .futureValue, .presentValue:
            return String(format: "$%.2f", result ?? 0)
        case .interestRate:
            return String(format: "%.2f%%", result ?? 0)
        case .timePeriod:
            return "\(String(format: "%.2f", result ?? 0)) years"
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
