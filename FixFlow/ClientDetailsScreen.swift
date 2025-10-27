
import SwiftUI

struct ClientDetailsScreen: View {
    @State var client: Client
    @ObservedObject var viewModel: ClientsViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var isEditing = false
    @State private var editedClient: Client
    
    init(client: Client, viewModel: ClientsViewModel) {
        self.client = client
        self.viewModel = viewModel
        self._editedClient = State(initialValue: client)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    mainInfoCard
                    
                    carsCard
                    
                    contactsCard
                    
                    if let notes = client.notes, !notes.isEmpty {
                        notesCard
                    }
                    
                    ordersHistoryCard
                }
                .padding()
            }
            .navigationTitle("Детали клиента")
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
                Image(systemName: "person.fill")
                    .foregroundColor(.blue)
                    .font(.title2)
                
                VStack(alignment: .leading) {
                    Text("Клиент")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    if isEditing {
                        TextField("Имя клиента", text: $editedClient.name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    } else {
                        Text(client.name)
                            .font(.headline)
                            .fontWeight(.semibold)
                    }
                }
                
                Spacer()
                
                OrdersCountBadge(count: viewModel.getOrdersCount(for: client))
            }
            
            Text("Клиент с \(client.createdAt, formatter: dateFormatter)")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(20)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
    
    private var carsCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: "car.fill")
                    .foregroundColor(.green)
                    .font(.title2)
                
                Text("Автомобили (\(client.cars.count))")
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Spacer()
            }
            
            ForEach(client.cars) { car in
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(car.fullName)
                            .font(.subheadline)
                            .fontWeight(.medium)
                        
                        Spacer()
                    }
                    
                    HStack {
                        if let licensePlate = car.licensePlate {
                            Text("Госномер: \(licensePlate)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        if let vin = car.vin {
                            Text("VIN: \(vin)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .padding(12)
                .background(Color(.systemGray6))
                .cornerRadius(8)
            }
        }
        .padding(20)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
    
    private var contactsCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: "phone.fill")
                    .foregroundColor(.orange)
                    .font(.title2)
                
                Text("Контакты")
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Image(systemName: "phone")
                        .foregroundColor(.blue)
                        .font(.caption)
                    
                    if isEditing {
                        TextField("Телефон", text: $editedClient.phone)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.phonePad)
                    } else {
                        Text(client.phone)
                            .font(.subheadline)
                    }
                }
                
                if let email = client.email {
                    HStack {
                        Image(systemName: "envelope")
                            .foregroundColor(.blue)
                            .font(.caption)
                        
                        if isEditing {
                            TextField("Email", text: Binding(
                                get: { editedClient.email ?? "" },
                                set: { editedClient.email = $0.isEmpty ? nil : $0 }
                            ))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        } else {
                            Text(email)
                                .font(.subheadline)
                        }
                    }
                }
            }
        }
        .padding(20)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
    
    private var notesCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: "note.text")
                    .foregroundColor(.purple)
                    .font(.title2)
                
                Text("Заметки")
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Spacer()
            }
            
            if isEditing {
                TextField("Заметки", text: Binding(
                    get: { editedClient.notes ?? "" },
                    set: { editedClient.notes = $0.isEmpty ? nil : $0 }
                ), axis: .vertical)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .lineLimit(3...6)
            } else {
                Text(client.notes ?? "")
                    .font(.body)
                    .foregroundColor(.primary)
            }
        }
        .padding(20)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
    
    private var ordersHistoryCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: "clock.arrow.circlepath")
                    .foregroundColor(.blue)
                    .font(.title2)
                
                Text("История заказов")
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Spacer()
            }
            
            VStack(spacing: 12) {
                HStack {
                    Text("Всего заказов:")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Text("\(viewModel.getOrdersCount(for: client))")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
                
                Text("Последние заказы будут отображаться здесь")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .italic()
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
        formatter.timeStyle = .none
        return formatter
    }
    
    private func saveChanges() {
        viewModel.updateClient(editedClient)
        client = editedClient
        isEditing = false
    }
}

#Preview {
    let viewModel = ClientsViewModel()
    let sampleClient = viewModel.clients.first!
    return ClientDetailsScreen(client: sampleClient, viewModel: viewModel)
}
