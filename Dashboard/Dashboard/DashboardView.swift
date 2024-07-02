//
//  DashboardView.swift
//  Dashboard
//
//  Created by Fenuku kekeli on 6/30/24.
//

import SwiftUI

struct DashboardView: View {
    @State private var showDetails = false
    @State private var showNotifications = false

    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        GreetingView()
                        StatisticsView(showDetails: $showDetails)
                        ProgressSectionView()
                        AdditionalBudgetView()
                        NotificationSectionView(showNotifications: $showNotifications)
                    }
                    .padding(.horizontal)
                }
            }
            .background(Color(.systemGray6))
            .navigationBarHidden(true)
        }
    }
}

struct GreetingView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Statistics")
                .font(.headline)
            
            HStack {
                Text("Hello 👋 Eugenia,")
                    .font(.largeTitle)
                    .bold()
                Spacer()
                Image(systemName: "gearshape")
                    .resizable()
                    .frame(width: 25, height: 25)
                
            }
            
            Text("your overall score is above average")
                .font(.title3)
                .foregroundColor(.gray)
            
            HStack {
                StatButton(title: "Growth +34%")
                StatButton(title: "Best Result 10/18 Tasks")
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(radius: 5)
    }
}

struct StatButton: View {
    let title: String
    
    var body: some View {
        Button(action: {}) {
            Text(title)
                .font(.footnote)
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .background(Color(.systemGray5))
                .cornerRadius(12)
        }
    }
}

struct StatisticsView: View {
    @Binding var showDetails: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Statistics shared to 10 friends")
                    .font(.headline)
                Spacer()
                Image(systemName: "person.2.fill")
                    .resizable()
                    .frame(width: 25, height: 25)
            }
            
            HStack {
                Spacer()
                Button(action: {
                    withAnimation(.spring()) {
                        showDetails.toggle()
                    }
                }) {
                    Image(systemName: showDetails ? "chevron.up" : "chevron.down")
                        .foregroundColor(.black)
                }
            }
        }
        .padding()
        .background(Color.orange)
        .cornerRadius(16)
        .shadow(radius: 5)
        
        if showDetails {
            AdditionalStatsView()
                .transition(.opacity)
                .padding(.horizontal)
        }
    }
}

struct AdditionalStatsView: View {
    var body: some View {
        Text("Additional Statistics Details")
            .font(.body)
            .padding()
            .background(Color.white)
            .cornerRadius(16)
            .shadow(radius: 5)
    }
}

struct ProgressSectionView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Your progress")
                    .font(.headline)
                Spacer()
                ToggleView()
            }
            
            Text("You are doing well 😊")
                .font(.title)
                .bold()
            Text("86%")
                .font(.system(size: 60))
                .bold()
        }
        .padding()
        .background(Color.yellow)
        .cornerRadius(16)
        .shadow(radius: 5)
    }
}

struct ToggleView: View {
    @State private var isWeekly = true
    
    var body: some View {
        HStack(spacing: 0) {
            Button(action: { isWeekly = true }) {
                Text("Weekly")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(isWeekly ? Color.black : Color.clear)
                    .foregroundColor(isWeekly ? .white : .black)
                    .cornerRadius(isWeekly ? 8 : 0)
            }
            Button(action: { isWeekly = false }) {
                Text("Monthly")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(!isWeekly ? Color.black : Color.clear)
                    .foregroundColor(!isWeekly ? .white : .black)
                    .cornerRadius(!isWeekly ? 8 : 0)
            }
        }
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 20)
    }
}

struct AdditionalBudgetView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Additional Budgets")
                    .font(.headline)
                Spacer()
                Image(systemName: "plus.circle")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.blue)
            }
            
            BudgetItemView(title: "Transportation", percentage: 86, amount: "$678 left", color: .orange)
            BudgetItemView(title: "Groceries", percentage: 67, amount: "$326 left", color: .green)
            BudgetItemView(title: "Electricity", percentage: 45, amount: "$150 left", color: .red)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(radius: 5)
    }
}

struct BudgetItemView: View {
    let title: String
    let percentage: Int
    let amount: String
    let color: Color
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                Text(amount)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            ZStack {
                Circle()
                    .trim(from: 0, to: CGFloat(percentage) / 100)
                    .stroke(color, lineWidth: 10)
                    .rotationEffect(.degrees(-90))
                    .frame(width: 50, height: 50)
                Text("\(percentage)%")
                    .font(.headline)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(radius: 5)
    }
}

struct NotificationSectionView: View {
    @Binding var showNotifications: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Notifications")
                    .font(.headline)
                Spacer()
                Button(action: {
                    withAnimation(.spring()) {
                        showNotifications.toggle()
                    }
                }) {
                    Image(systemName: "bell.fill")
                        .foregroundColor(.black)
                }
            }
            
            if showNotifications {
                NotificationFeedView()
                    .transition(.opacity)
                    .padding(.horizontal)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(radius: 5)
    }
}

struct NotificationFeedView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ForEach(0..<5) { index in
                HStack {
                    VStack(alignment: .leading) {
                        Text("Notification \(index + 1)")
                            .font(.headline)
                        Text("This is the detail of the notification.")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
                .padding()
                .background(Color(.systemGray5))
                .cornerRadius(16)
                .shadow(radius: 2)
            }
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
