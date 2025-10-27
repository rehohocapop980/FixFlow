
import SwiftUI

struct AddPartSheet: View {
    @ObservedObject var viewModel: PartsViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var name = ""
    @State private var partNumber = ""
    @State private var quantity = 0
    @State private var price = 0.0
    @State private var supplier = ""
    @State private var selectedCategory: PartCategory = .other
    @State private var description = ""
    @State private var minimumQuantity = 5
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Basic Information") {
                    TextField("Part Name", text: $name)
                    TextField("Part Number", text: $partNumber)
                        .autocapitalization(.allCharacters)
                    
                    Picker("Category", selection: $selectedCategory) {
                        ForEach(PartCategory.allCases, id: \.self) { category in
                            HStack {
                                Image(systemName: category.icon)
                                Text(category.rawValue)
                            }.tag(category)
                        }
                    }
                }
                
                Section("Quantity and Price") {
                    Stepper("Quantity: \(quantity)", value: $quantity, in: 0...1000)
                    
                    HStack {
                        Text("Price")
                        Spacer()
                        TextField("0", value: $price, format: .number)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    Stepper("Minimum: \(minimumQuantity)", value: $minimumQuantity, in: 1...100)
                }
                
                Section("Supplier") {
                    TextField("Supplier Name", text: $supplier)
                }
                
                Section("Description") {
                    TextField("Additional information", text: $description, axis: .vertical)
                        .lineLimit(3...6)
                }
            }
            .navigationTitle("New Part")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        savePart()
                    }
                    .disabled(!isFormValid)
                }
            }
        }
    }
    
    private var isFormValid: Bool {
        !name.isEmpty && !partNumber.isEmpty && !supplier.isEmpty && price > 0
    }
    
    private func savePart() {
        let newPart = Part(
            name: name,
            partNumber: partNumber,
            quantity: quantity,
            price: price,
            supplier: supplier,
            category: selectedCategory,
            description: description.isEmpty ? nil : description,
            minimumQuantity: minimumQuantity
        )
        
        viewModel.addPart(newPart)
        dismiss()
    }
}

#Preview {
    AddPartSheet(viewModel: PartsViewModel())
}
