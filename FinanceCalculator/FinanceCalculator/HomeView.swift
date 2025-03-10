//
//  HomeView.swift
//  FinanceCalculator
//
//  Created by Hasini Thilakarathna on 2025-02-28.
//

import SwiftUI

struct HomeView: View {
    @Binding var selectedTab: Int // ✅ Bind selected tab to update in ContentView

    var body: some View {
        NavigationStack {
            ZStack {
                ThemeManager.backgroundGradient // ✅ Added background gradient
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 30) {
                        // App Icon
                        Image(systemName: "chart.bar.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 100)
                            .foregroundColor(.blue)
                            .padding(.top, 40)

                        // Title & Description
                        VStack(spacing: 10) {
                            Text("Finance Calculator")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)

                            Text("Easily calculate interest rates, loans, savings, and mortgages!")
                                .font(.body)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.secondary)
                                .padding(.horizontal)
                        }

                        // Navigation Buttons
                        VStack(spacing: 15) {
                            HomeButton(title: "Compound Interest", icon: "chart.line.uptrend.xyaxis") {
                                selectedTab = 1
                            }
                            HomeButton(title: "Mortgage Calculator", icon: "house.fill") {
                                selectedTab = 2
                            }
                            HomeButton(title: "Savings Calculator", icon: "banknote") {
                                selectedTab = 3
                            }
                            HomeButton(title: "Loan Calculator", icon: "dollarsign.arrow.circlepath") {
                                selectedTab = 4
                            }
                        }
                        .padding(.top, 20)

                        Spacer()
                    }
                    .padding()
                }
                .navigationTitle("")
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        HStack {
                            Image(systemName: "house.fill")
                            Text("Home")
                                .font(.headline)
                        }
                    }
                }
                .onTapGesture { hideKeyboard() }
            }
        }
    }
}
