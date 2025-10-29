
import SwiftUI

struct PartDetailsScreen: View {
    @State var part: Part
    @ObservedObject var viewModel: PartsViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State private var isEditing = false
    @State private var editedPart: Part
    @State private var priceText: String = ""
    
    init(part: Part, viewModel: PartsViewModel) {
        self.part = part
        self.viewModel = viewModel
        self._editedPart = State(initialValue: part)
        self._priceText = State(initialValue: "")
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    mainInfoCard
                    
                    quantityPriceCard
                    
                    supplierCategoryCard
                    
                    if let description = part.description, !description.isEmpty {
                        descriptionCard
                    }
                    
                    statisticsCard
                }
                .padding()
            }
            .navigationTitle("Part Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(isEditing ? "Save" : "Edit") {
                        if isEditing {
                            if let priceValue = Double(priceText) {
                                editedPart.price = priceValue
                            }
                            saveChanges()
                        } else {
                            priceText = String(format: "%.2f", editedPart.price)
                            isEditing = true
                        }
                    }
                }
            }
        }
    }
    
    private var mainInfoCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: part.category.icon)
                    .foregroundColor(.blue)
                    .font(.title2)
                
                VStack(alignment: .leading) {
                    Text("Part")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    if isEditing {
                        TextField("Part Name", text: $editedPart.name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    } else {
                        Text(part.name)
                            .font(.system(size: 17, weight: .semibold))
                    }
                }
                
                Spacer()
                
                AvailabilityBadge(status: part.availabilityStatus)
            }
            
            HStack {
                Image(systemName: "barcode")
                    .foregroundColor(.green)
                    .font(.title2)
                
                VStack(alignment: .leading) {
                    Text("Part Number")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    if isEditing {
                        TextField("Part Number", text: $editedPart.partNumber)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocapitalization(.allCharacters)
                    } else {
                        Text(part.partNumber)
                            .font(.system(size: 17, weight: .semibold))
                    }
                }
                
                Spacer()
            }
        }
        .padding(20)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
    
    private var quantityPriceCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: "slider.horizontal.3")
                    .foregroundColor(.orange)
                    .font(.title2)
                
                Text("Quantity and Price")
                    .font(.headline)
                    .font(.system(size: 17, weight: .semibold))
                
                Spacer()
            }
            
            VStack(spacing: 16) {
                HStack {
                    Text("Stock Quantity")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    if isEditing {
                        Stepper("\(editedPart.quantity)", value: $editedPart.quantity, in: 0...1000)
                    } else {
                        Text("\(part.quantity) pcs.")
                            .font(.subheadline)
                            .font(.system(size: 17, weight: .medium))
                    }
                }
                
                HStack {
                    Text("Minimum Quantity")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    if isEditing {
                        Stepper("\(editedPart.minimumQuantity)", value: $editedPart.minimumQuantity, in: 1...100)
                    } else {
                        Text("\(part.minimumQuantity) pcs.")
                            .font(.subheadline)
                            .font(.system(size: 17, weight: .medium))
                    }
                }
                
                HStack {
                    Text("Price per Unit")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    if isEditing {
                        TextField("Price", text: $priceText)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .onChange(of: priceText) { newValue in
                                let filtered = newValue.filter { $0.isNumber || $0 == "." }
                                if filtered != newValue {
                                    priceText = filtered
                                } else {
                                    if let priceValue = Double(filtered) {
                                        editedPart.price = priceValue
                                    }
                                }
                            }
                    } else {
                        Text("\(Int(part.price))")
                            .font(.subheadline)
                            .font(.system(size: 17, weight: .medium))
                    }
                }
            }
        }
        .padding(20)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
    
    private var supplierCategoryCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: "building.2.fill")
                    .foregroundColor(.purple)
                    .font(.title2)
                
                Text("Supplier and Category")
                    .font(.headline)
                    .font(.system(size: 17, weight: .semibold))
                
                Spacer()
            }
            
            VStack(spacing: 16) {
                HStack {
                    Image(systemName: "building.2")
                        .foregroundColor(.blue)
                        .font(.caption)
                    
                    Text("Supplier")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    if isEditing {
                        TextField("Supplier", text: $editedPart.supplier)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .multilineTextAlignment(.trailing)
                    } else {
                        Text(part.supplier)
                            .font(.subheadline)
                            .font(.system(size: 17, weight: .medium))
                    }
                }
                
                HStack {
                    Image(systemName: part.category.icon)
                        .foregroundColor(.blue)
                        .font(.caption)
                    
                    Text("Category")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    if isEditing {
                        Picker("Category", selection: $editedPart.category) {
                            ForEach(PartCategory.allCases, id: \.self) { category in
                                Text(category.rawValue).tag(category)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    } else {
                        Text(part.category.rawValue)
                            .font(.subheadline)
                            .font(.system(size: 17, weight: .medium))
                    }
                }
            }
        }
        .padding(20)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
    
    private var descriptionCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: "note.text")
                    .foregroundColor(.blue)
                    .font(.title2)
                
                Text("Description")
                    .font(.headline)
                    .font(.system(size: 17, weight: .semibold))
                
                Spacer()
            }
            
            if isEditing {
                TextEditor(text: Binding(
                    get: { editedPart.description ?? "" },
                    set: { editedPart.description = $0.isEmpty ? nil : $0 }
                ))
                .frame(minHeight: 80, maxHeight: 120)
            } else {
                Text(part.description ?? "")
                    .font(.body)
                    .foregroundColor(.primary)
            }
        }
        .padding(20)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
    
    private var statisticsCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: "chart.bar.fill")
                    .foregroundColor(.green)
                    .font(.title2)
                
                Text("Statistics")
                    .font(.headline)
                    .font(.system(size: 17, weight: .semibold))
                
                Spacer()
            }
            
            VStack(spacing: 12) {
                HStack {
                    Text("Total Value:")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Text("\(Int(part.totalValue))")
                        .font(.subheadline)
                        .font(.system(size: 17, weight: .semibold))
                }
                
                HStack {
                    Text("Status:")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    AvailabilityBadge(status: part.availabilityStatus)
                }
                
                HStack {
                    Text("Created:")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Text(part.createdAt, formatter: dateFormatter)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                HStack {
                    Text("Updated:")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Text(part.lastUpdated, formatter: dateFormatter)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(20)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }
    
    private func saveChanges() {
        viewModel.updatePart(editedPart)
        part = editedPart
        isEditing = false
    }
}

#Preview {
    let viewModel = PartsViewModel()
    let samplePart = viewModel.parts.first!
    return PartDetailsScreen(part: samplePart, viewModel: viewModel)
}
