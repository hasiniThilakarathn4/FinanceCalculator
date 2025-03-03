import SwiftUI

struct MortgageView: View {
    @State private var loanAmount: String = ""
    @State private var rate: String = ""
    @State private var years: String = ""
    @State private var result: Double?

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    
                    // Title
                    Text("Mortgage Calculator")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.top, 10)

                    // Input Section
                    VStack(spacing: 15) {
                        CustomTextField(placeholder: "Loan Amount ($)", text: $loanAmount)
                        CustomTextField(placeholder: "Annual Interest Rate (%)", text: $rate)
                        CustomTextField(placeholder: "Loan Term (Years)", text: $years)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
                    .padding(.horizontal)

                    // Calculation Result
                    if let result = result {
                        VStack {
                            Text("Monthly Payment")
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
                    Button(action: calculateMortgage) {
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
            .navigationTitle("Mortgage Calculator")
            .background(Color(.systemBackground))
            .onTapGesture {
                hideKeyboard()
            }
        }
    }

    private func calculateMortgage() {
        guard let loan = Double(loanAmount),
              let r = Double(rate),
              let t = Double(years) else { return }

        let i = r / 100 / 12
        let n = t * 12
        let payment = (loan * i) / (1 - pow(1 + i, -n))

        result = payment
    }
}
