import SwiftUI

struct AddJobScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var clientName = ""
    @State private var carModel = ""
    @State private var service = ""
    @State private var status: JobStatus = .pending
    @State private var dueDate = Date()
    @State private var showingValidationAlert = false
    @State private var validationMessage = ""
    
    let onSave: (Job) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Order information")) {
                    TextField("Customer name", text: $clientName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("Car model", text: $carModel)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("Service", text: $service)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Section(header: Text("Status and deadlines")) {
                    Picker("Status", selection: $status) {
                        ForEach(JobStatus.allCases, id: \.self) { status in
                            Text(status.rawValue).tag(status)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    
                    DatePicker("Deadline", selection: $dueDate, displayedComponents: .date)
                }
            }
            .navigationTitle("New order")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveJob()
                    }
                    .font(.system(size: 17, weight: .semibold))
                    .disabled(clientName.isEmpty || service.isEmpty)
                }
            }
            .alert(isPresented: $showingValidationAlert) {
                Alert(
                    title: Text("Validation error"),
                    message: Text(validationMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
    
    private func saveJob() {
        guard validateFields() else { return }
        
        let newJob = Job(
            clientName: clientName,
            carModel: carModel.isEmpty ? "Not specified" : carModel,
            service: service,
            status: status,
            dueDate: dueDate,
            description: nil
        )
        
        onSave(newJob)
        presentationMode.wrappedValue.dismiss()
    }
    
    private func validateFields() -> Bool {
        if clientName.isEmpty {
            validationMessage = "Client name is required"
            showingValidationAlert = true
            return false
        }
        
        if service.isEmpty {
            validationMessage = "This service is required to be filled in."
            showingValidationAlert = true
            return false
        }
        
        return true
    }
}

#Preview {
    AddJobScreen { _ in }
}
