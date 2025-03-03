import SwiftUI

struct SavingsView: View {
    @State private var principal: String = ""
    @State private var monthlyContribution: String = ""
    @State private var rate: String = ""
    @State private var years: String = ""
    @State private var result: Double?

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    
                    // Title
                    Text("Savings Calculator")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.top, 10)

                    // Input Section
                    VStack(spacing: 15) {
                        CustomTextField(placeholder: "Initial Investment ($)", text: $principal)
                        CustomTextField(placeholder: "Monthly Contribution ($)", text: $monthlyContribution)
                        CustomTextField(placeholder: "Annual Interest Rate (%)", text: $rate)
                        CustomTextField(placeholder: "Years", text: $years)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6))) // Form-like UI
                    .padding(.horizontal)

                    // Calculation Result
                    if let result = result {
                        VStack {
                            Text("Future Value")
                                .font(.headline)
                                .foregroundColor(.gray)
                            
                            Text("$\(result, specifier: "%.2f")")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6))) // Result Box
                        .padding(.horizontal)
                    }

                    // Calculate Button
                    Button(action: calculateFutureValue) {
                        Text("Calculate")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .font(.headline)
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Savings Calculator")
            .background(Color(.systemBackground))
            .onTapGesture {
                hideKeyboard()
            }
        }
    }

    private func calculateFutureValue() {
        guard let p = Double(principal),
              let m = Double(monthlyContribution),
              let r = Double(rate),
              let t = Double(years) else { return }

        let i = r / 100 / 12
        let n = t * 12
        let futureValue = (m * (pow(1 + i, n) - 1) / i) + (p * pow(1 + i, n))

        result = futureValue
    }
}
