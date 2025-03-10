//
//  HelpView.swift
//  FinanceCalculator
//
//  Created by Hasini Thilakarathna on 2025-02-28.
//

import SwiftUI

struct HelpView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    
                    // App Introduction
                    Text("📌 **Finance Calculator Help Guide**")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("Welcome to the **Finance Calculator**! This app helps you perform essential financial calculations with ease. Whether you are managing savings, loans, or mortgage payments, this guide will walk you through everything you need to know.")
                        .padding(.bottom, 5)

                    Divider()
                    
                    // Features
                    Group {
                        Text("🔹 **Compound Interest Calculator**")
                            .font(.headline)
                        Text("Calculate the **future value** of an investment with compounding interest over a specific time period.")
                        Text("✔ **You can calculate:**")
                        BulletPoint(text: "Future value of an investment")
                        BulletPoint(text: "Required initial investment")
                        BulletPoint(text: "Interest rate needed to reach a target")
                        BulletPoint(text: "Time required to grow the investment")

                        Divider()

                        Text("🔹 **Savings Calculator**")
                            .font(.headline)
                        Text("Determine how much your savings will grow with regular **monthly contributions**.")
                        Text("✔ **You can calculate:**")
                        BulletPoint(text: "Future value of savings with monthly deposits")
                        BulletPoint(text: "Required monthly contributions")
                        BulletPoint(text: "Interest rate needed to reach a goal")
                        BulletPoint(text: "Time required to achieve savings target")

                        Divider()

                        Text("🔹 **Loan Calculator**")
                            .font(.headline)
                        Text("Calculate monthly loan repayments based on loan amount, interest rate, and duration.")
                        Text("✔ **You can calculate:**")
                        BulletPoint(text: "Monthly payment for a given loan amount")
                        BulletPoint(text: "Total loan amount you can borrow")
                        BulletPoint(text: "Interest rate based on monthly payment")
                        BulletPoint(text: "Duration required to repay the loan")

                        Divider()

                        Text("🔹 **Mortgage Calculator**")
                            .font(.headline)
                        Text("Determine your monthly mortgage payments and total repayment amount.")
                        Text("✔ **You can calculate:**")
                        BulletPoint(text: "Monthly mortgage payments")
                        BulletPoint(text: "Total cost of the mortgage over time")
                        BulletPoint(text: "Required loan amount based on budget")
                    }

                    Divider()
                    
                    // How to Use Section
                    Text("💡 **How to Use the App**")
                        .font(.title3)
                        .fontWeight(.bold)

                    VStack(alignment: .leading, spacing: 5) {
                        StepBulletPoint(step: "1️⃣", text: "**Select the type of calculation** you want to perform from the bottom navigation bar.")
                        StepBulletPoint(step: "2️⃣", text: "**Enter your financial details** in the provided fields.")
                        StepBulletPoint(step: "3️⃣", text: "**Choose what you want to solve for** (e.g., future value, interest rate, loan term).")
                        StepBulletPoint(step: "4️⃣", text: "**Tap 'Calculate'** to see the results instantly.")
                        StepBulletPoint(step: "5️⃣", text: "**Use the 'Reset' button** to clear all fields and start over.")
                    }
                    
                    Divider()
                    
                    // Additional Tips
                    Text("📢 **Additional Tips**")
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    BulletPoint(text: "You can switch between different calculators using the bottom tab bar.")
                    BulletPoint(text: "All amounts are displayed with proper currency formatting for clarity.")
                    BulletPoint(text: "Interest rates can be entered as percentages (e.g., 5 for 5%).")
                    BulletPoint(text: "For compounding interest, select the number of compounding periods per year (e.g., 12 for monthly).")

                    Divider()
                }
                .padding()
                .padding(.top, 20) // ✅ Fix cropped text issue
            }
            .navigationTitle("Help Guide")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                            .font(.title2)
                    }
                }
            }
        }
        .presentationDetents([.medium, .large]) // ✅ Reduced the help view height
    }
}

// MARK: - Custom Bullet Point View
struct BulletPoint: View {
    var text: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(.blue)
                .font(.footnote)
            Text(text)
                .font(.body)
        }
    }
}

// MARK: - Step Bullet Point View
struct StepBulletPoint: View {
    var step: String
    var text: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Text(step)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.blue)
            Text(text)
                .font(.body)
        }
    }
}
