import SwiftUI

struct HomeView: View {
    @Binding var selectedTab: Int // ✅ Bind selected tab to update in ContentView

    var body: some View {
        NavigationStack {
            ScrollView{
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
                            selectedTab = 1 // ✅ Switches to Compound Interest tab
                        }
                        HomeButton(title: "Mortgage Calculator", icon: "house.fill") {
                            selectedTab = 2 // ✅ Switches to Mortgage tab
                        }
                        HomeButton(title: "Savings Calculator", icon: "banknote") {
                            selectedTab = 3 // ✅ Switches to Savings tab
                        }
                        HomeButton(title: "Loan Calculator", icon: "dollarsign.arrow.circlepath") {
                            selectedTab = 4 // ✅ Switches to Loans tab
                        }
                    }
                    .padding(.top, 20)
                    
                    Spacer()
                }
                .padding()
                .navigationTitle("Home")
                .background(Color(.systemGroupedBackground)) // ✅ Light background for better readability
                
            }
            
        }
    }
}

// ✅ Updated Home Button Component
struct HomeButton: View {
    var title: String
    var icon: String
    var action: () -> Void // ✅ Pass action to update tab

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.white)
                    .font(.title2)
                    .frame(width: 40, height: 40)

                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.leading, 5)

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundColor(.white)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .cornerRadius(10)
            .shadow(radius: 3)
            .padding(.horizontal)
        }
    }
}

#Preview {
    HomeView(selectedTab: .constant(0))
}
