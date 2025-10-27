import Foundation
import SwiftUI

enum StatsPeriod: String, CaseIterable {
    case day = "Day"
    case week = "Week"
    case month = "Month"
}

struct StatsData: Equatable {
    let date: Date
    let revenue: Double
    let expenses: Double
    let completedJobs: Int
}

@MainActor
class StatsViewModel: ObservableObject {
    @Published var selectedPeriod: StatsPeriod = .month
    @Published var statsData: [StatsData] = []
    @Published var isLoading = false
    
    var totalRevenue: Double {
        statsData.reduce(0) { $0 + $1.revenue }
    }
    
    var totalExpenses: Double {
        statsData.reduce(0) { $0 + $1.expenses }
    }
    
    var totalCompletedJobs: Int {
        statsData.reduce(0) { $0 + $1.completedJobs }
    }
    
    var averageCheck: Double {
        guard totalCompletedJobs > 0 else { return 0 }
        return totalRevenue / Double(totalCompletedJobs)
    }
    
    var netProfit: Double {
        totalRevenue - totalExpenses
    }
    
    var profitPercentage: Double {
        guard totalRevenue > 0 else { return 0 }
        return (netProfit / totalRevenue) * 100
    }
    
    init() {
    }
    
    func updatePeriod(_ period: StatsPeriod) {
        withAnimation(.easeInOut(duration: 0.3)) {
            selectedPeriod = period
            isLoading = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(.easeInOut(duration: 0.3)) {
                self.isLoading = false
            }
        }
    }
    
    func refreshData() {
        withAnimation(.easeInOut(duration: 0.3)) {
            isLoading = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            withAnimation(.easeInOut(duration: 0.3)) {
                self.isLoading = false
            }
        }
    }
    
    func getChartData() -> [(String, Double)] {
        let formatter: DateFormatter = {
            let formatter = DateFormatter()
            switch selectedPeriod {
            case .day:
                formatter.dateFormat = "HH:mm"
            case .week:
                formatter.dateFormat = "dd.MM"
            case .month:
                formatter.dateFormat = "dd.MM"
            }
            return formatter
        }()
        
        return statsData.map { data in
            (formatter.string(from: data.date), data.revenue)
        }
    }
}
