import SwiftUI

struct JobDetailsScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showingEditScreen = false
    @State private var showingCompleteAlert = false
    
    let job: Job
    let onUpdate: (Job) -> Void
    let onComplete: (Job) -> Void
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Image(systemName: "person.circle.fill")
                                .foregroundColor(.blue)
                                .font(.title2)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Client")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text(job.clientName)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                            }
                            
                            Spacer()
                        }
                        
                        Divider()
                        
                        HStack {
                            Image(systemName: "car.fill")
                                .foregroundColor(.green)
                                .font(.title2)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Car")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text(job.carModel)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                            }
                            
                            Spacer()
                        }
                        
                        Divider()
                        
                        HStack {
                            Image(systemName: "wrench.and.screwdriver.fill")
                                .foregroundColor(.orange)
                                .font(.title2)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Service")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text(job.service)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                            }
                            
                            Spacer()
                        }
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Image(systemName: "clock.fill")
                                .foregroundColor(.purple)
                                .font(.title2)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Status")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text(job.status.rawValue)
                                    .font(.headline)
                                    .foregroundColor(statusColor)
                            }
                            
                            Spacer()
                            
                            statusIcon
                        }
                        
                        Divider()
                        
                        HStack {
                            Image(systemName: "calendar")
                                .foregroundColor(.red)
                                .font(.title2)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Deadline")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text(formatDate(job.dueDate))
                                    .font(.headline)
                                    .foregroundColor(.primary)
                            }
                            
                            Spacer()
                        }
                        
                        Divider()
                        
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.gray)
                                .font(.title2)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Created")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text(formatDateWithTime(job.createdAt))
                                    .font(.headline)
                                    .foregroundColor(.primary)
                            }
                            
                            Spacer()
                        }
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                    
                    VStack(spacing: 12) {
                        if job.status != .completed {
                            Button(action: { showingCompleteAlert = true }) {
                                HStack {
                                    Image(systemName: "checkmark.circle.fill")
                                    Text("Mark as complete")
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                            }
                        }
                        
                        Button(action: { showingEditScreen = true }) {
                            HStack {
                                Image(systemName: "pencil.circle.fill")
                                Text("Edit order")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                        }
                    }
                    .padding(.horizontal)
                }
                .padding()
            }
            .navigationTitle("Order details")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Edit") {
                        showingEditScreen = true
                    }
                }
            }
            .sheet(isPresented: $showingEditScreen) {
                EditJobScreen(job: job) { updatedJob in
                    onUpdate(updatedJob)
                }
            }
            .alert(isPresented: $showingCompleteAlert) {
                Alert(
                    title: Text("Complete order"),
                    message: Text("Are you sure you want to mark this order as complete??"),
                    primaryButton: .cancel(Text("Cancel")),
                    secondaryButton: .default(Text("Complete")) {
                        completeJob()
                    }
                )
            }
        }
    }
    
    private var statusColor: Color {
        switch job.status {
        case .pending:
            return .orange
        case .inProgress:
            return .blue
        case .completed:
            return .green
        case .paid:
            return .purple
        }
    }
    
    private var statusIcon: some View {
        Group {
            switch job.status {
            case .pending:
                Image(systemName: "clock.fill")
                    .foregroundColor(.orange)
            case .inProgress:
                Image(systemName: "gear.circle.fill")
                    .foregroundColor(.blue)
            case .completed:
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
            case .paid:
                Image(systemName: "creditcard.fill")
                    .foregroundColor(.purple)
            }
        }
        .font(.title2)
    }
    
    private func completeJob() {
        let completedJob = Job(
            clientName: job.clientName,
            carModel: job.carModel,
            service: job.service,
            status: .completed,
            dueDate: job.dueDate,
            description: job.description
        )
        
        onComplete(completedJob)
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
    
    private func formatDateWithTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

#Preview {
    JobDetailsScreen(
        job: Job(
            clientName: "John Smith",
            carModel: "Toyota Camry 2020",
            service: "Oil Change",
            status: .pending,
            dueDate: Date(),
            description: "Full engine oil and filter replacement"
        ),
        onUpdate: { _ in },
        onComplete: { _ in }
    )
}
