
import SwiftUI

struct ClientDetailsScreen: View {
    @State var client: Client
    @ObservedObject var viewModel: ClientsViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State private var isEditing = false
    @State private var editedClient: Client
    
    init(client: Client, viewModel: ClientsViewModel) {
        self.client = client
        self.viewModel = viewModel
        self._editedClient = State(initialValue: client)
    }
    
    var body: some View {
        NavigationView {
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
            .navigationTitle("Client Details")
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
                    Text("Client")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    if isEditing {
                        TextField("Client Name", text: $editedClient.name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    } else {
                        Text(client.name)
                            .font(.system(size: 17, weight: .semibold))
                    }
                }
                
                Spacer()
                
                OrdersCountBadge(count: viewModel.getOrdersCount(for: client))
            }
            
            Text("Client since \(client.createdAt, formatter: dateFormatter)")
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
                
                Text("Cars (\(client.cars.count))")
                    .font(.system(size: 17, weight: .semibold))
                
                Spacer()
            }
            
            ForEach(client.cars) { car in
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(car.fullName)
                            .font(.system(size: 15, weight: .medium))
                        
                        Spacer()
                    }
                    
                    HStack {
                        if let licensePlate = car.licensePlate {
                            Text("License Plate: \(licensePlate)")
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
                
                Text("Contacts")
                    .font(.headline)
                    .font(.system(size: 17, weight: .semibold))
                
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Image(systemName: "phone")
                        .foregroundColor(.blue)
                        .font(.caption)
                    
                    if isEditing {
                        TextField("Phone", text: $editedClient.phone)
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
                
                Text("Notes")
                    .font(.headline)
                    .font(.system(size: 17, weight: .semibold))
                
                Spacer()
            }
            
            if isEditing {
                TextEditor(text: Binding(
                    get: { editedClient.notes ?? "" },
                    set: { editedClient.notes = $0.isEmpty ? nil : $0 }
                ))
                .frame(minHeight: 80, maxHeight: 120)
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
                
                Text("Order History")
                    .font(.headline)
                    .font(.system(size: 17, weight: .semibold))
                
                Spacer()
            }
            
            VStack(spacing: 12) {
                HStack {
                    Text("Total Orders:")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Text("\(viewModel.getOrdersCount(for: client))")
                        .font(.subheadline)
                        .font(.system(size: 17, weight: .semibold))
                }
                
                Text("Recent orders will be displayed here")
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
