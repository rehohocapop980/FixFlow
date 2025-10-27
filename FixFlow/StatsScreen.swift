import SwiftUI
import Charts

struct StatsScreen: View {
    @StateObject private var viewModel = StatsViewModel()
    @State private var showingDetails = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                FixFlowTheme.Colors.purpleBackground
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 20) {
                        periodSelector
                        
                        kpiCardsSection
                        
                        chartSection
                        
                        additionalStatsSection
                    }
                    .padding()
                }
            }
            .navigationTitle("Statistics")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: viewModel.refreshData) {
                        Image(systemName: "arrow.clockwise")
                            .foregroundColor(.accentColor)
                    }
                    .disabled(viewModel.isLoading)
                }
            }
            .refreshable {
                viewModel.refreshData()
            }
        }
    }
    
    private var periodSelector: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Period")
                .font(.headline)
                .foregroundColor(.primary)
            
            Picker("Period", selection: $viewModel.selectedPeriod) {
                ForEach(StatsPeriod.allCases, id: \.self) { period in
                    Text(period.rawValue).tag(period)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .onChange(of: viewModel.selectedPeriod) { newPeriod in
                viewModel.updatePeriod(newPeriod)
            }
        }
    }
    
    private var kpiCardsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Key Performance Indicators")
                .font(.headline)
                .foregroundColor(.primary)
            
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 12) {
                KPICard(
                    title: "Revenue",
                    value: formatCurrency(viewModel.totalRevenue),
                    icon: "arrow.up.right",
                    color: .green,
                    isLoading: viewModel.isLoading
                ) {
                    showingDetails = true
                }
                
                KPICard(
                    title: "Orders",
                    value: "\(viewModel.totalCompletedJobs)",
                    icon: "checkmark.circle.fill",
                    color: .blue,
                    isLoading: viewModel.isLoading
                ) {
                    showingDetails = true
                }
                
                KPICard(
                    title: "Average Check",
                    value: formatCurrency(viewModel.averageCheck),
                    icon: "creditcard.fill",
                    color: .purple,
                    isLoading: viewModel.isLoading
                ) {
                    showingDetails = true
                }
                
                KPICard(
                    title: "Profit",
                    value: formatCurrency(viewModel.netProfit),
                    icon: viewModel.netProfit >= 0 ? "arrow.up.right" : "arrow.down.right",
                    color: viewModel.netProfit >= 0 ? .green : .red,
                    isLoading: viewModel.isLoading
                ) {
                    showingDetails = true
                }
            }
        }
    }
    
    private var chartSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Revenue Chart")
                .font(.headline)
                .foregroundColor(.primary)
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("Period: \(viewModel.selectedPeriod.rawValue)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Text(formatCurrency(viewModel.totalRevenue))
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                }
                
                Chart(viewModel.getChartData(), id: \.0) { data in
                    LineMark(
                        x: .value("Period", data.0),
                        y: .value("Revenue", data.1)
                    )
                    .foregroundStyle(.green.gradient)
                    .lineStyle(StrokeStyle(lineWidth: 3))
                    
                    AreaMark(
                        x: .value("Period", data.0),
                        y: .value("Revenue", data.1)
                    )
                    .foregroundStyle(.green.opacity(0.1))
                }
                .frame(height: 200)
                .chartXAxis {
                    AxisMarks(values: .automatic) { _ in
                        AxisGridLine()
                        AxisTick()
                        AxisValueLabel()
                    }
                }
                .chartYAxis {
                    AxisMarks(values: .automatic) { value in
                        AxisGridLine()
                        AxisTick()
                        AxisValueLabel {
                            if let doubleValue = value.as(Double.self) {
                                Text(formatCurrency(doubleValue))
                            }
                        }
                    }
                }
                .animation(.easeInOut(duration: 0.5), value: viewModel.statsData)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(FixFlowTheme.Colors.surfaceLight)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(FixFlowTheme.Colors.border.opacity(0.3), lineWidth: 1)
                    )
                    .shadow(color: FixFlowTheme.Colors.shadowMedium, radius: 8, x: 0, y: 4)
            )
        }
    }
    
    private var additionalStatsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Additional Information")
                .font(.headline)
                .foregroundColor(.primary)
            
            VStack(spacing: 8) {
                StatRow(
                    title: "Parts Expenses",
                    value: formatCurrency(viewModel.totalExpenses),
                    color: .red
                )
                
                StatRow(
                    title: "Profitability",
                    value: String(format: "%.1f%%", viewModel.profitPercentage),
                    color: viewModel.profitPercentage >= 0 ? .green : .red
                )
                
                StatRow(
                    title: "Orders per Day",
                    value: String(format: "%.1f", Double(viewModel.totalCompletedJobs) / Double(viewModel.statsData.count)),
                    color: .blue
                )
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(FixFlowTheme.Colors.surfaceLight)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(FixFlowTheme.Colors.border.opacity(0.3), lineWidth: 1)
                    )
                    .shadow(color: FixFlowTheme.Colors.shadowMedium, radius: 8, x: 0, y: 4)
            )
        }
    }
    
    private func formatCurrency(_ amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(value: amount)) ?? "0"
    }
}

struct KPICard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    let isLoading: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: icon)
                        .foregroundColor(color)
                        .font(.title2)
                    
                    Spacer()
                    
                    if isLoading {
                        ProgressView()
                            .scaleEffect(0.8)
                    }
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text(value)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
        }
        .buttonStyle(PlainButtonStyle())
        .scaleEffect(isLoading ? 0.95 : 1.0)
        .animation(.easeInOut(duration: 0.2), value: isLoading)
    }
}

struct StatRow: View {
    let title: String
    let value: String
    let color: Color
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.primary)
            
            Spacer()
            
            Text(value)
                .fontWeight(.semibold)
                .foregroundColor(color)
        }
    }
}

#Preview {
    StatsScreen()
}