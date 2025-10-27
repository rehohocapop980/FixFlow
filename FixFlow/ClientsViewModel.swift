
import Foundation
import SwiftUI

@MainActor
class ClientsViewModel: ObservableObject {
    @Published var clients: [Client] = []
    @Published var searchText: String = ""
    
    private let clientsKey = "SavedClients"
    
    init() {
        loadClients()
    }
    
    var filteredClients: [Client] {
        if searchText.isEmpty {
            return clients.sorted { $0.name < $1.name }
        } else {
            return clients.filter { client in
                client.name.localizedCaseInsensitiveContains(searchText) ||
                client.phone.localizedCaseInsensitiveContains(searchText) ||
                client.cars.contains { car in
                    car.make.localizedCaseInsensitiveContains(searchText) ||
                    car.model.localizedCaseInsensitiveContains(searchText) ||
                    car.fullName.localizedCaseInsensitiveContains(searchText)
                }
            }.sorted { $0.name < $1.name }
        }
    }
    
    func addClient(_ client: Client) {
        clients.append(client)
        saveClients()
    }
    
    func updateClient(_ client: Client) {
        if let index = clients.firstIndex(where: { $0.id == client.id }) {
            clients[index] = client
            saveClients()
        }
    }
    
    func deleteClient(_ client: Client) {
        clients.removeAll { $0.id == client.id }
        saveClients()
    }
    
    func getOrdersCount(for client: Client) -> Int {
        return 0
    }
    
    func resetSearch() {
        searchText = ""
    }
    
    private func saveClients() {
        do {
            let data = try JSONEncoder().encode(clients)
            UserDefaults.standard.set(data, forKey: clientsKey)
        } catch {
            print("Failed to save clients: \(error)")
        }
    }
    
    private func loadClients() {
        guard let data = UserDefaults.standard.data(forKey: clientsKey) else {
            return
        }
        
        do {
            clients = try JSONDecoder().decode([Client].self, from: data)
        } catch {
            print("Failed to load clients: \(error)")
            clients = []
        }
    }
}
