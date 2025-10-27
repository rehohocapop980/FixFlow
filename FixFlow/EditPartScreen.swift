import SwiftUI

struct EditPartScreen: View {
    @Environment(\.dismiss) private var dismiss
    @State private var name: String
    @State private var quantity: Int
    @State private var price: String
    @State private var supplier: String
    @State private var showingValidationAlert = false
    @State private var validationMessage = ""
    
    let part: Part
    let onSave: (Part) -> Void
    
    init(part: Part, onSave: @escaping (Part) -> Void) {
        self.part = part
        self.onSave = onSave
        self._name = State(initialValue: part.name)
        self._quantity = State(initialValue: part.quantity)
        self._price = State(initialValue: String(part.price))
        self._supplier = State(initialValue: part.supplier)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Информация о детали") {
                    TextField("Название детали", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("Поставщик", text: $supplier)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Section("Количество и цена") {
                    HStack {
                        Text("Количество")
                        Spacer()
                        Stepper(value: $quantity, in: 1...1000) {
                            Text("\(quantity)")
                                .fontWeight(.semibold)
                        }
                    }
                    
                    TextField("Цена за единицу", text: $price)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                    
                    HStack {
                        Text("Общая стоимость")
                            .foregroundColor(.secondary)
                        Spacer()
                        Text("\(totalCost, specifier: "%.2f")")
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                    }
                }
                
                Section("Информация о создании") {
                    HStack {
                        Text("Создан")
                        Spacer()
                        Text(part.createdAt.formatted(date: .abbreviated, time: .shortened))
                            .foregroundColor(.secondary)
                    }
                }
                
                Section {
                    Button(action: savePart) {
                        HStack {
                            Image(systemName: "pencil.circle.fill")
                            Text("Сохранить изменения")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isValid ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    }
                    .disabled(!isValid)
                }
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets())
            }
            .navigationTitle("Редактировать деталь")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Отмена") {
                        dismiss()
                    }
                }
            }
            .alert("Ошибка валидации", isPresented: $showingValidationAlert) {
                Button("OK") { }
            } message: {
                Text(validationMessage)
            }
        }
    }
    
    private var isValid: Bool {
        !name.isEmpty && !price.isEmpty && Double(price) != nil
    }
    
    private var totalCost: Double {
        guard let priceValue = Double(price) else { return 0 }
        return priceValue * Double(quantity)
    }
    
    private func savePart() {
        guard validateFields() else { return }
        
        let updatedPart = Part(
            name: name,
            partNumber: part.partNumber,
            quantity: quantity,
            price: Double(price) ?? 0,
            supplier: supplier.isEmpty ? "Не указан" : supplier,
            category: part.category,
            description: part.description,
            minimumQuantity: part.minimumQuantity
        )
        
        onSave(updatedPart)
        dismiss()
    }
    
    private func validateFields() -> Bool {
        if name.isEmpty {
            validationMessage = "Название детали обязательно для заполнения"
            showingValidationAlert = true
            return false
        }
        
        if price.isEmpty {
            validationMessage = "Цена обязательна для заполнения"
            showingValidationAlert = true
            return false
        }
        
        guard let priceValue = Double(price), priceValue > 0 else {
            validationMessage = "Цена должна быть положительным числом"
            showingValidationAlert = true
            return false
        }
        
        return true
    }
}

#Preview {
    EditPartScreen(part: Part(
        name: "Масляный фильтр",
        partNumber: "OF-001",
        quantity: 15,
        price: 850.0,
        supplier: "Манн-Фильтр",
        category: .filters,
        description: "Оригинальный масляный фильтр для большинства автомобилей",
        minimumQuantity: 10
    )) { _ in }
}
