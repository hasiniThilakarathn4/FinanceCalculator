//
//  CompoundInterestView.swift
//  FinanceCalculator
//
//  Created by Hasini Thilakarathna on 2025-02-28.
//

import SwiftUI

struct CompoundInterestView: View {
    @State private var principal: String = ""
    @State private var rate: String = ""
    @State private var years: String = ""
    @State private var compoundingPeriods: String = ""
    @State private var result: Double?

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
    
                    
                    // Input Section
                    VStack(spacing: 15) {
                        CustomTextField(placeholder: "Initial Investment ($)", text: $principal)
                        CustomTextField(placeholder: "Annual Interest Rate (%)", text: $rate)
                        CustomTextField(placeholder: "Years", text: $years)
                        CustomTextField(placeholder: "Compounding Periods Per Year", text: $compoundingPeriods)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
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
            .navigationTitle("Compound Interest")
            .background(Color(.systemBackground)) // Ensure tap is detected on background
            .onTapGesture {
                hideKeyboard() // ✅ Hide keyboard when tapping outside
            }
        }
    }

    private func calculateFutureValue() {
        guard let p = Double(principal),
              let r = Double(rate),
              let t = Double(years),
              let m = Double(compoundingPeriods) else { return }

        let i = r / 100 / m
        let n = t * m
        let futureValue = p * pow((1 + i), n)

        result = futureValue
    }
}

// ✅ Custom Styled TextField Component
struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String

    var body: some View {
        TextField(placeholder, text: $text)
            .padding()
            .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
            .keyboardType(.decimalPad)
    }
}

#Preview {
    CompoundInterestView()
}
