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

                        VStack(spacing: 15) {
                            CustomTextField(title: "Initial Investment", placeholder: "$0.00", text: $principal)

                            if solveFor != .monthlyContribution {
                                CustomTextField(title: "Monthly Contribution", placeholder: "$0.00", text: $monthlyContribution)
                            }

                            if solveFor != .interestRate {
                                CustomTextField(title: "Annual Interest Rate (%)", placeholder: "0%", text: $rate)
                            }

                            if solveFor != .duration {
                                CustomTextField(title: "Duration (Years)", placeholder: "Years", text: $years)
                            }

                            if solveFor != .futureValue {
                                CustomTextField(title: "Future Value", placeholder: "$0.00", text: $futureValue)
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
                .navigationTitle("💰 Savings Calculator")
                .onTapGesture { hideKeyboard() }
            }
        }
    }

    private func calculate() {
        let p = Double(principal) ?? 0
        let m = Double(monthlyContribution) ?? 0
        let r = (Double(rate) ?? 0) / 100 / 12
        let t = (Double(years) ?? 0) * 12
        let fv = Double(futureValue) ?? 0

        switch solveFor {
        case .futureValue:
            result = (m * (pow(1 + r, t) - 1) / r) + (p * pow(1 + r, t))
        case .monthlyContribution:
            result = (fv - p * pow(1 + r, t)) * r / (pow(1 + r, t) - 1)
        case .interestRate:
            result = (pow(fv / (p + m * t), 1 / t) - 1) * 12 * 100
        case .duration:
            result = log((fv * r + m) / (p * r + m)) / log(1 + r) / 12
        }
    }

    private func formattedResult(_ value: Double) -> String {
        switch solveFor {
        case .interestRate:
            return String(format: "%.2f%%", value * 100)
        case .duration:
            return String(format: "%.1f years", value / 12)
        default:
            return String(format: "$%.2f", value)
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
