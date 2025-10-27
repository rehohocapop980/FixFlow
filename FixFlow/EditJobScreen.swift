import SwiftUI

struct EditJobScreen: View {
    @Environment(\.dismiss) private var dismiss
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
                
                Section("Информация о создании") {
                    HStack {
                        Text("Создан")
                        Spacer()
                        Text(job.createdAt.formatted(date: .abbreviated, time: .shortened))
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("Редактировать заказ")
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
        
        let updatedJob = Job(
            clientName: clientName,
            carModel: carModel.isEmpty ? "Не указано" : carModel,
            service: service,
            status: status,
            dueDate: dueDate,
            description: job.description
        )
        
        onSave(updatedJob)
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
    EditJobScreen(job: Job(
        clientName: "Иван Петров",
        carModel: "Toyota Camry 2020",
        service: "Замена масла",
        status: .pending,
        dueDate: Date(),
        description: "Полная замена моторного масла и фильтра"
    )) { _ in }
}
