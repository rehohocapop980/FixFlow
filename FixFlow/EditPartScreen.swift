import SwiftUI

struct EditPartScreen: View {
    @Environment(\.presentationMode) var presentationMode
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
        NavigationView {
            Form {
                Section(header: Text("Part Information")) {
                    TextField("Part Name", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("Supplier", text: $supplier)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Section(header: Text("Quantity and Price")) {
                    HStack {
                        Text("Quantity")
                        Spacer()
                        Stepper(value: $quantity, in: 1...1000) {
                            Text("\(quantity)")
                                .font(.system(size: 17, weight: .semibold))
                        }
                    }
                    
                    TextField("Price per Unit", text: $price)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                    
                    HStack {
                        Text("Total Cost")
                            .foregroundColor(.secondary)
                        Spacer()
                        Text("\(totalCost, specifier: "%.2f")")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.primary)
                    }
                }
                
                Section(header: Text("Creation Information")) {
                    HStack {
                        Text("Created")
                        Spacer()
                        Text(formatDateWithTime(part.createdAt))
                            .foregroundColor(.secondary)
                    }
                }
                
                Section {
                    Button(action: savePart) {
                        HStack {
                            Image(systemName: "pencil.circle.fill")
                            Text("Save Changes")
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
            .navigationTitle("Edit Part")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .alert(isPresented: $showingValidationAlert) {
                Alert(
                    title: Text("Validation Error"),
                    message: Text(validationMessage),
                    dismissButton: .default(Text("OK"))
                )
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
            supplier: supplier.isEmpty ? "Not specified" : supplier,
            category: part.category,
            description: part.description,
            minimumQuantity: part.minimumQuantity
        )
        
        onSave(updatedPart)
        presentationMode.wrappedValue.dismiss()
    }
    
    private func formatDateWithTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    private func validateFields() -> Bool {
        if name.isEmpty {
            validationMessage = "Part name is required"
            showingValidationAlert = true
            return false
        }
        
        if price.isEmpty {
            validationMessage = "Price is required"
            showingValidationAlert = true
            return false
        }
        
        guard let priceValue = Double(price), priceValue > 0 else {
            validationMessage = "Price must be a positive number"
            showingValidationAlert = true
            return false
        }
        
        return true
    }
}

#Preview {
    EditPartScreen(part: Part(
        name: "",
        partNumber: "",
        quantity: 15,
        price: 850.0,
        supplier: "",
        category: .filters,
        description: "",
        minimumQuantity: 10
    )) { _ in }
}
