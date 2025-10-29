import SwiftUI

struct EditJobScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var clientName: String
    @State private var carModel: String
    @State private var service: String
    @State private var status: JobStatus
    @State private var dueDate: Date
    @State private var showingValidationAlert = false
    @State private var validationMessage = ""
    
    let job: Job
    let onSave: (Job) -> Void
    
    init(job: Job, onSave: @escaping (Job) -> Void) {
        self.job = job
        self.onSave = onSave
        self._clientName = State(initialValue: job.clientName)
        self._carModel = State(initialValue: job.carModel)
        self._service = State(initialValue: job.service)
        self._status = State(initialValue: job.status)
        self._dueDate = State(initialValue: job.dueDate)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Order Information")) {
                    TextField("Client Name", text: $clientName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("Car Model", text: $carModel)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("Service", text: $service)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Section(header: Text("Status and Deadlines")) {
                    Picker("Status", selection: $status) {
                        ForEach(JobStatus.allCases, id: \.self) { status in
                            Text(status.rawValue).tag(status)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    
                    DatePicker("Deadline", selection: $dueDate, displayedComponents: .date)
                }
                
                Section(header: Text("Creation Information")) {
                    HStack {
                        Text("Created")
                        Spacer()
                        Text(formatDateWithTime(job.createdAt))
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("Edit Order")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Save") {
                    saveJob()
                }
                .font(.system(size: 17, weight: .semibold))
                .disabled(clientName.isEmpty || service.isEmpty)
            )
            .alert(isPresented: $showingValidationAlert) {
                Alert(
                    title: Text("Validation Error"),
                    message: Text(validationMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
    
    private func saveJob() {
        guard validateFields() else { return }
        
        let updatedJob = Job(
            clientName: clientName,
            carModel: carModel.isEmpty ? "Not specified" : carModel,
            service: service,
            status: status,
            dueDate: dueDate,
            description: job.description
        )
        
        onSave(updatedJob)
        presentationMode.wrappedValue.dismiss()
    }
    
    private func validateFields() -> Bool {
        if clientName.isEmpty {
            validationMessage = "Client name is required"
            showingValidationAlert = true
            return false
        }
        
        if service.isEmpty {
            validationMessage = "Service is required"
            showingValidationAlert = true
            return false
        }
        
        return true
    }
    
    private func formatDateWithTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

#Preview {
    EditJobScreen(job: Job(
        clientName: "John Smith",
        carModel: "Toyota Camry 2020",
        service: "Oil Change",
        status: .pending,
        dueDate: Date(),
        description: "Full engine oil and filter replacement"
    )) { _ in }
}
