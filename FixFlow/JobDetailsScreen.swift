import SwiftUI

struct JobDetailsScreen: View {
    @Environment(\.dismiss) private var dismiss
    @State private var showingEditScreen = false
    @State private var showingCompleteAlert = false
    
    let job: Job
    let onUpdate: (Job) -> Void
    let onComplete: (Job) -> Void
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Image(systemName: "person.circle.fill")
                                .foregroundColor(.blue)
                                .font(.title2)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Клиент")
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
                                Text("Автомобиль")
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
                                Text("Услуга")
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
                                Text("Статус")
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
                                Text("Срок выполнения")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text(job.dueDate.formatted(date: .abbreviated, time: .omitted))
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
                                Text("Создан")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text(job.createdAt.formatted(date: .abbreviated, time: .shortened))
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
                                    Text("Отметить как завершённый")
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
                                Text("Редактировать заказ")
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
            .navigationTitle("Детали заказа")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Редактировать") {
                        showingEditScreen = true
                    }
                }
            }
            .sheet(isPresented: $showingEditScreen) {
                EditJobScreen(job: job) { updatedJob in
                    onUpdate(updatedJob)
                }
            }
            .alert("Завершить заказ", isPresented: $showingCompleteAlert) {
                Button("Отмена", role: .cancel) { }
                Button("Завершить", role: .destructive) {
                    completeJob()
                }
            } message: {
                Text("Вы уверены, что хотите отметить этот заказ как завершённый?")
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
}

#Preview {
    JobDetailsScreen(
        job: Job(
            clientName: "Иван Петров",
            carModel: "Toyota Camry 2020",
            service: "Замена масла",
            status: .pending,
            dueDate: Date(),
            description: "Полная замена моторного масла и фильтра"
        ),
        onUpdate: { _ in },
        onComplete: { _ in }
    )
}