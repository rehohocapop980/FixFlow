
import SwiftUI

struct AddJobSheet: View {
    @ObservedObject var viewModel: JobsViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var clientName = ""
    @State private var carModel = ""
    @State private var service = ""
    @State private var dueDate = Date()
    @State private var description = ""
    @State private var selectedStatus: JobStatus = .pending
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Client Information") {
                    TextField("Client Name", text: $clientName)
                    TextField("Car Model", text: $carModel)
                }
                
                Section("Job Details") {
                    TextField("Service", text: $service)
                    
                    Picker("Status", selection: $selectedStatus) {
                        ForEach(JobStatus.allCases, id: \.self) { status in
                            Text(status.rawValue).tag(status)
                        }
                    }
                    
                    DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
                }
                
                Section("Description") {
                    TextField("Additional information", text: $description, axis: .vertical)
                        .lineLimit(3...6)
                }
            }
            .navigationTitle("New Order")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveJob()
                    }
                    .disabled(!isFormValid)
                }
            }
        }
    }
    
    private var isFormValid: Bool {
        !clientName.isEmpty && !carModel.isEmpty && !service.isEmpty
    }
    
    private func saveJob() {
        let newJob = Job(
            clientName: clientName,
            carModel: carModel,
            service: service,
            status: selectedStatus,
            dueDate: dueDate,
            description: description.isEmpty ? nil : description
        )
        
        viewModel.addJob(newJob)
        dismiss()
    }
}

#Preview {
    AddJobSheet(viewModel: JobsViewModel())
}
