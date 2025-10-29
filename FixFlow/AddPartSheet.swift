
import SwiftUI

struct AddPartSheet: View {
    @ObservedObject var viewModel: PartsViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name = ""
    @State private var partNumber = ""
    @State private var quantity = 0
    @State private var priceText = ""
    @State private var supplier = ""
    @State private var selectedCategory: PartCategory = .other
    @State private var description = ""
    @State private var minimumQuantity = 5
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Basic Information")) {
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
                
                Section(header: Text("Quantity and Price")) {
                    Stepper("Quantity: \(quantity)", value: $quantity, in: 0...1000)
                    
                    HStack {
                        Text("Price")
                        Spacer()
                        TextField("0", text: $priceText)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .onChange(of: priceText) { newValue in
                                let filtered = newValue.filter { $0.isNumber || $0 == "." }
                                if filtered != newValue {
                                    priceText = filtered
                                }
                            }
                    }
                    
                    Stepper("Minimum: \(minimumQuantity)", value: $minimumQuantity, in: 1...100)
                }
                
                Section(header: Text("Supplier")) {
                    TextField("Supplier Name", text: $supplier)
                }
                
                Section(header: Text("Description")) {
                    TextEditor(text: $description)
                        .frame(minHeight: 80, maxHeight: 120)
                }
            }
            .navigationTitle("New Part")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
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
        !name.isEmpty && !partNumber.isEmpty && !supplier.isEmpty && (Double(priceText) ?? 0) > 0
    }
    
    private func savePart() {
        let price = Double(priceText) ?? 0.0
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
        presentationMode.wrappedValue.dismiss()
    }
}

#Preview {
    AddPartSheet(viewModel: PartsViewModel())
}
