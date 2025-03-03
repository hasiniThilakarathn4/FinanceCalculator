//
//  ContentView.swift
//  FinanceCalculator
//
//  Created by Hasini Thilakarathna on 2025-02-27.
//

import SwiftUI

struct ContentView: View {
    @State private var showHelp = false // ✅ Controls the Help modal
    @State private var selectedTab = 0 // ✅ Tracks the currently selected tab

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                HomeView(selectedTab: $selectedTab) // ✅ Pass selectedTab binding
                    .navigationTitle("Home")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: { showHelp.toggle() }) {
                                Image(systemName: "questionmark.circle")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
            }
            .tabItem {
                Label("Home", systemImage: selectedTab == 0 ? "house.fill" : "house")
            }
            .tag(0)

            NavigationStack {
                CompoundInterestView()
                    .navigationTitle("Compound Interest")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: { showHelp.toggle() }) {
                                Image(systemName: "questionmark.circle")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
            }
            .tabItem {
                Label("Compound Interest", systemImage:  "chart.line.uptrend.xyaxis")
            }
            .tag(1)

            NavigationStack {
                MortgageView()
                    .navigationTitle("Mortgage")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: { showHelp.toggle() }) {
                                Image(systemName: "questionmark.circle")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
            }
            .tabItem {
                Label("Mortgage", systemImage: selectedTab == 2 ? "dollarsign.bank.building.fill" : "dollarsign.bank.building")
            }
            .tag(2)

            NavigationStack {
                SavingsView()
                    .navigationTitle("Savings")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: { showHelp.toggle() }) {
                                Image(systemName: "questionmark.circle")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
            }
            .tabItem {
                Label("Savings", systemImage: selectedTab == 3 ? "banknote.fill" : "banknote")
            }
            .tag(3)

            NavigationStack {
                LoanView()
                    .navigationTitle("Loans")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: { showHelp.toggle() }) {
                                Image(systemName: "questionmark.circle")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
            }
            .tabItem {
                Label("Loans", systemImage:  "dollarsign.arrow.circlepath")
            }
            .tag(4)
        }
        .sheet(isPresented: $showHelp) {
            HelpView() // ✅ HelpView shown as a modal
        }
    }
}

// Function to hide keyboard
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    ContentView()
}
