import SwiftUI

struct AddPartScreen: View {
    @Environment(\.dismiss) private var dismiss
    @State private var name = ""
    @State private var quantity = 1
    @State private var price = ""
    @State private var supplier = ""
    @State private var showingValidationAlert = false
    @State private var validationMessage = ""
    
    let onSave: (Part) -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Part Information") {
                    TextField("Part Name", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("Supplier", text: $supplier)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Section("Quantity and Price") {
                    HStack {
                        Text("Quantity")
                        Spacer()
                        Stepper(value: $quantity, in: 1...1000) {
                            Text("\(quantity)")
                                .fontWeight(.semibold)
                        }
                    }
                    
                    TextField("Price per unit", text: $price)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                    
                    if !price.isEmpty {
                        HStack {
                            Text("Total Cost")
                                .foregroundColor(.secondary)
                            Spacer()
                            Text("\(totalCost, specifier: "%.2f")")
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)
                        }
                    }
                }
                
                Section {
                    Button(action: savePart) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("Add Part")
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
            .navigationTitle("New Part")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .alert("Validation Error", isPresented: $showingValidationAlert) {
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
        
        let newPart = Part(
            name: name,
            partNumber: "AUTO-\(Int.random(in: 1000...9999))",
            quantity: quantity,
            price: Double(price) ?? 0,
            supplier: supplier.isEmpty ? "Not specified" : supplier,
            category: .other,
            description: nil,
            minimumQuantity: 5
        )
        
        onSave(newPart)
        dismiss()
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
    AddPartScreen { _ in }
}
