
import SwiftUI

struct AddJobSheet: View {
    @ObservedObject var viewModel: JobsViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State private var clientName = ""
    @State private var carModel = ""
    @State private var service = ""
    @State private var dueDate = Date()
    @State private var description = ""
    @State private var selectedStatus: JobStatus = .pending
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Client Information")) {
                    TextField("Client Name", text: $clientName)
                    TextField("Car Model", text: $carModel)
                }
                
                Section(header: Text("Job Details")) {
                    TextField("Service", text: $service)
                    
                    Picker("Status", selection: $selectedStatus) {
                        ForEach(JobStatus.allCases, id: \.self) { status in
                            Text(status.rawValue).tag(status)
                        }
                    }
                    
                    DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
                }
                
                Section(header: Text("Description")) {
                    TextEditor(text: $description)
                        .frame(minHeight: 80, maxHeight: 120)
                }
            }
            .navigationTitle("New Order")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Save") {
                    saveJob()
                }
                .disabled(!isFormValid)
            )
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
        presentationMode.wrappedValue.dismiss()
    }
}

#Preview {
    AddJobSheet(viewModel: JobsViewModel())
}
