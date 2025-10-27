import SwiftUI

struct AddJobScreen: View {
    @Environment(\.dismiss) private var dismiss
    @State private var clientName = ""
    @State private var carModel = ""
    @State private var service = ""
    @State private var status: JobStatus = .pending
    @State private var dueDate = Date()
    @State private var showingValidationAlert = false
    @State private var validationMessage = ""
    
    let onSave: (Job) -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Информация о заказе") {
                    TextField("Имя клиента", text: $clientName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("Модель авто", text: $carModel)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("Услуга", text: $service)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Section("Статус и сроки") {
                    Picker("Статус", selection: $status) {
                        ForEach(JobStatus.allCases, id: \.self) { status in
                            Text(status.rawValue).tag(status)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    
                    DatePicker("Срок выполнения", selection: $dueDate, displayedComponents: .date)
                }
            }
            .navigationTitle("Новый заказ")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Отмена") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Сохранить") {
                        saveJob()
                    }
                    .fontWeight(.semibold)
                    .disabled(clientName.isEmpty || service.isEmpty)
                }
            }
            .alert("Ошибка валидации", isPresented: $showingValidationAlert) {
                Button("OK") { }
            } message: {
                Text(validationMessage)
            }
        }
    }
    
    private func saveJob() {
        guard validateFields() else { return }
        
        let newJob = Job(
            clientName: clientName,
            carModel: carModel.isEmpty ? "Не указано" : carModel,
            service: service,
            status: status,
            dueDate: dueDate,
            description: nil
        )
        
        onSave(newJob)
        dismiss()
    }
    
    private func validateFields() -> Bool {
        if clientName.isEmpty {
            validationMessage = "Имя клиента обязательно для заполнения"
            showingValidationAlert = true
            return false
        }
        
        if service.isEmpty {
            validationMessage = "Услуга обязательна для заполнения"
            showingValidationAlert = true
            return false
        }
        
        return true
    }
}

#Preview {
    AddJobScreen { _ in }
}
