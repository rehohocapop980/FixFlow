
import SwiftUI

struct JobsScreen: View {
    @StateObject private var viewModel = JobsViewModel()
    @State private var showingAddJob = false
    @State private var selectedJob: Job?
    @State private var isScrollingUp = false
    
    var body: some View {
        NavigationView {
            ZStack {
                FixFlowTheme.Colors.purpleBackground
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    searchBar
                    
                    statusFilter
                    
                    jobsList
                }
            }
            .navigationTitle("Jobs")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarHidden(true)
            .sheet(isPresented: $showingAddJob) {
                AddJobSheet(viewModel: viewModel)
            }
            .sheet(item: $selectedJob) { job in
                JobDetailsScreen(
                    job: job,
                    onUpdate: { updatedJob in
                        viewModel.updateJob(updatedJob)
                    },
                    onComplete: { completedJob in
                        viewModel.updateJob(completedJob)
                    }
                )
            }
        }
    }
    
    private var searchBar: some View {
        HStack(spacing: FixFlowTheme.Spacing.md) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(FixFlowTheme.Colors.textSecondary)
                .font(.system(size: 16, weight: .medium))
            
            TextField("Search by client or car model", text: $viewModel.searchText)
                .font(FixFlowTheme.Typography.body)
                .textFieldStyle(PlainTextFieldStyle())
            
            if !viewModel.searchText.isEmpty {
                Button(action: { 
                    withAnimation(FixFlowTheme.Animation.quick) {
                        viewModel.searchText = ""
                    }
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(FixFlowTheme.Colors.textSecondary)
                        .font(.system(size: 16))
                }
            }
        }
        .fixFlowSearchBarStyle()
        .padding(.horizontal, FixFlowTheme.Spacing.lg)
        .padding(.top, FixFlowTheme.Spacing.sm)
    }
    
    private var statusFilter: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: FixFlowTheme.Spacing.md) {
                FilterButton(
                    title: "All",
                    isSelected: viewModel.selectedStatus == nil,
                    action: { 
                        withAnimation(FixFlowTheme.Animation.spring) {
                            viewModel.selectedStatus = nil
                        }
                    }
                )
                
                ForEach(JobStatus.allCases, id: \.self) { status in
                    FilterButton(
                        title: status.rawValue,
                        isSelected: viewModel.selectedStatus == status,
                        action: { 
                            withAnimation(FixFlowTheme.Animation.spring) {
                                viewModel.selectedStatus = viewModel.selectedStatus == status ? nil : status
                            }
                        }
                    )
                }
            }
            .padding(.horizontal, FixFlowTheme.Spacing.lg)
            .padding(.vertical, 6)
        }
        .padding(.vertical, FixFlowTheme.Spacing.md)
    }
    
    private var jobsList: some View {
        ScrollView {
            LazyVStack(spacing: FixFlowTheme.Spacing.md) {
                ForEach(viewModel.filteredJobs) { job in
                    JobCardView(job: job)
                        .onTapGesture {
                            withAnimation(FixFlowTheme.Animation.spring) {
                                selectedJob = job
                            }
                        }
                        .contextMenu {
                            Button(action: {
                                withAnimation(FixFlowTheme.Animation.spring) {
                                    selectedJob = job
                                }
                            }) {
                                Label("Edit", systemImage: "pencil")
                            }
                            
                            Button(action: {
                                let nextStatus = getNextStatus(for: job.status)
                                withAnimation(FixFlowTheme.Animation.spring) {
                                    viewModel.changeJobStatus(job, to: nextStatus)
                                }
                            }) {
                                Label("Complete", systemImage: "checkmark")
                            }
                            
                            Button(action: {
                                withAnimation(FixFlowTheme.Animation.spring) {
                                    viewModel.deleteJob(job)
                                }
                            }) {
                                HStack {
                                    Image(systemName: "trash")
                                    Text("Delete")
                                }
                                .foregroundColor(.red)
                            }
                        }
                        .fixFlowCardTransition()
                }
            }
            .padding(.horizontal, FixFlowTheme.Spacing.lg)
            .padding(.bottom, 100)
        }
        .background(Color.clear)
        .overlay(
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: { 
                        withAnimation(FixFlowTheme.Animation.spring) {
                            showingAddJob = true
                        }
                    }) {
                        Image(systemName: "plus")
                            .fixFlowFABStyle()
                    }
                    .scaleEffect(isScrollingUp ? 1.1 : 1.0)
                    .animation(FixFlowTheme.Animation.spring, value: isScrollingUp)
                    .padding(.trailing, FixFlowTheme.Spacing.xxl)
                    .padding(.bottom, FixFlowTheme.Spacing.xxl)
                }
            }
        )
    }
    
    private func getNextStatus(for currentStatus: JobStatus) -> JobStatus {
        switch currentStatus {
        case .pending:
            return .inProgress
        case .inProgress:
            return .completed
        case .completed:
            return .paid
        case .paid:
            return .pending
        }
    }
}

struct FilterButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .fixFlowCapsuleFilterStyle(isActive: isSelected)
        }
    }
}

struct JobCardView: View {
    let job: Job
    @State private var isPressed = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: FixFlowTheme.Spacing.md) {
            HStack {
                VStack(alignment: .leading, spacing: FixFlowTheme.Spacing.xs) {
                    Text(job.clientName)
                        .fixFlowCardTitleStyle()
                    
                    Text(job.carModel)
                        .fixFlowCardSubtitleStyle()
                }
                
                Spacer()
                
                StatusBadge(status: job.status)
            }
            
            HStack(spacing: FixFlowTheme.Spacing.sm) {
                Image(systemName: "wrench.and.screwdriver.fill")
                    .foregroundColor(FixFlowTheme.Colors.blue)
                    .font(.system(size: 14, weight: .medium))
                
                Text(job.service)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.primary)
            }
            
            HStack(spacing: FixFlowTheme.Spacing.sm) {
                Image(systemName: "calendar")
                    .foregroundColor(FixFlowTheme.Colors.orange)
                    .font(.system(size: 12, weight: .medium))
                
                Text("Due: \(job.dueDate, formatter: dateFormatter)")
                    .font(FixFlowTheme.Typography.caption)
                    .foregroundColor(FixFlowTheme.Colors.textSecondary)
            }
        }
        .padding(FixFlowTheme.Spacing.lg)
        .background(
            RoundedRectangle(cornerRadius: FixFlowTheme.CornerRadius.large, style: .continuous)
                .fill(FixFlowTheme.Colors.surfaceLight)
                .overlay(
                    RoundedRectangle(cornerRadius: FixFlowTheme.CornerRadius.large, style: .continuous)
                        .stroke(FixFlowTheme.Colors.border.opacity(0.3), lineWidth: 1)
                )
                .shadow(
                    color: FixFlowTheme.Colors.shadowMedium,
                    radius: 8,
                    x: 0,
                    y: 4
                )
        )
        .scaleEffect(isPressed ? 1.02 : 1.0)
        .animation(FixFlowTheme.Animation.springQuick, value: isPressed)
        .onTapGesture {
            withAnimation(FixFlowTheme.Animation.springQuick) {
                isPressed = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(FixFlowTheme.Animation.springQuick) {
                    isPressed = false
                }
            }
        }
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter
    }
}

struct StatusBadge: View {
    let status: JobStatus
    
    var body: some View {
        HStack(spacing: FixFlowTheme.Spacing.xs) {
            Image(systemName: status.icon)
                .font(.system(size: 10, weight: .semibold))
            
            Text(status.rawValue)
                .font(.system(size: 12, weight: .semibold))
        }
        .foregroundColor(.white)
        .padding(.horizontal, FixFlowTheme.Spacing.sm)
        .padding(.vertical, FixFlowTheme.Spacing.xs)
        .background(
            RoundedRectangle(cornerRadius: FixFlowTheme.CornerRadius.small, style: .continuous)
                .fill(Color.statusColor(for: status.rawValue))
        )
    }
}

#Preview {
    JobsScreen()
}
