
import SwiftUI

struct PartDetailsScreen: View {
    @State var part: Part
    @ObservedObject var viewModel: PartsViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var isEditing = false
    @State private var editedPart: Part
    
    init(part: Part, viewModel: PartsViewModel) {
        self.part = part
        self.viewModel = viewModel
        self._editedPart = State(initialValue: part)
    }
    
    var body: some View {
        NavigationStack {
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
            .navigationTitle("Детали детали")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Закрыть") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(isEditing ? "Сохранить" : "Изменить") {
                        if isEditing {
                            saveChanges()
                        } else {
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
                    Text("Деталь")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    if isEditing {
                        TextField("Название детали", text: $editedPart.name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    } else {
                        Text(part.name)
                            .font(.headline)
                            .fontWeight(.semibold)
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
                    Text("Артикул")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    if isEditing {
                        TextField("Артикул", text: $editedPart.partNumber)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocapitalization(.allCharacters)
                    } else {
                        Text(part.partNumber)
                            .font(.headline)
                            .fontWeight(.semibold)
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
                
                Text("Количество и цена")
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Spacer()
            }
            
            VStack(spacing: 16) {
                HStack {
                    Text("Количество на складе")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    if isEditing {
                        Stepper("\(editedPart.quantity)", value: $editedPart.quantity, in: 0...1000)
                    } else {
                        Text("\(part.quantity) шт.")
                            .font(.subheadline)
                            .fontWeight(.medium)
                    }
                }
                
                HStack {
                    Text("Минимальное количество")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    if isEditing {
                        Stepper("\(editedPart.minimumQuantity)", value: $editedPart.minimumQuantity, in: 1...100)
                    } else {
                        Text("\(part.minimumQuantity) шт.")
                            .font(.subheadline)
                            .fontWeight(.medium)
                    }
                }
                
                HStack {
                    Text("Цена за единицу")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    if isEditing {
                        TextField("Price", value: $editedPart.price, format: .number)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    } else {
                        Text("\(Int(part.price))")
                            .font(.subheadline)
                            .fontWeight(.medium)
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
                
                Text("Поставщик и категория")
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Spacer()
            }
            
            VStack(spacing: 16) {
                HStack {
                    Image(systemName: "building.2")
                        .foregroundColor(.blue)
                        .font(.caption)
                    
                    Text("Поставщик")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    if isEditing {
                        TextField("Поставщик", text: $editedPart.supplier)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .multilineTextAlignment(.trailing)
                    } else {
                        Text(part.supplier)
                            .font(.subheadline)
                            .fontWeight(.medium)
                    }
                }
                
                HStack {
                    Image(systemName: part.category.icon)
                        .foregroundColor(.blue)
                        .font(.caption)
                    
                    Text("Категория")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    if isEditing {
                        Picker("Категория", selection: $editedPart.category) {
                            ForEach(PartCategory.allCases, id: \.self) { category in
                                Text(category.rawValue).tag(category)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    } else {
                        Text(part.category.rawValue)
                            .font(.subheadline)
                            .fontWeight(.medium)
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
                
                Text("Описание")
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Spacer()
            }
            
            if isEditing {
                TextField("Описание", text: Binding(
                    get: { editedPart.description ?? "" },
                    set: { editedPart.description = $0.isEmpty ? nil : $0 }
                ), axis: .vertical)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .lineLimit(3...6)
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
                
                Text("Статистика")
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Spacer()
            }
            
            VStack(spacing: 12) {
                HStack {
                    Text("Общая стоимость:")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Text("\(Int(part.totalValue))")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
                
                HStack {
                    Text("Статус:")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    AvailabilityBadge(status: part.availabilityStatus)
                }
                
                HStack {
                    Text("Создана:")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Text(part.createdAt, formatter: dateFormatter)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                HStack {
                    Text("Обновлена:")
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
