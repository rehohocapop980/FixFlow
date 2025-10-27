
import Foundation
import SwiftUI

@MainActor
class PartsViewModel: ObservableObject {
    @Published var parts: [Part] = []
    @Published var selectedFilter: PartsFilter = .all
    @Published var searchText: String = ""
    
    private let partsKey = "SavedParts"
    
    init() {
        loadParts()
    }
    
    var filteredParts: [Part] {
        var filtered = parts
        
        switch selectedFilter {
        case .all:
            break
        case .lowStock:
            filtered = filtered.filter { $0.availabilityStatus == .lowStock }
        case .expensive:
            filtered = filtered.filter { $0.isExpensive }
        case .outOfStock:
            filtered = filtered.filter { $0.availabilityStatus == .outOfStock }
        case .bySupplier(let supplier):
            filtered = filtered.filter { $0.supplier == supplier }
        }
        
        if !searchText.isEmpty {
            filtered = filtered.filter { part in
                part.name.localizedCaseInsensitiveContains(searchText) ||
                part.partNumber.localizedCaseInsensitiveContains(searchText) ||
                part.supplier.localizedCaseInsensitiveContains(searchText) ||
                part.category.rawValue.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        return filtered.sorted { $0.name < $1.name }
    }
    
    var suppliers: [String] {
        return Array(Set(parts.map { $0.supplier })).sorted()
    }
    
    var totalInventoryValue: Double {
        return parts.reduce(0) { $0 + $1.totalValue }
    }
    
    var lowStockCount: Int {
        return parts.filter { $0.availabilityStatus == .lowStock }.count
    }
    
    var outOfStockCount: Int {
        return parts.filter { $0.availabilityStatus == .outOfStock }.count
    }
    
    func addPart(_ part: Part) {
        parts.append(part)
        saveParts()
    }
    
    func updatePart(_ part: Part) {
        if let index = parts.firstIndex(where: { $0.id == part.id }) {
            var updatedPart = part
            updatedPart.lastUpdated = Date()
            parts[index] = updatedPart
            saveParts()
        }
    }
    
    func deletePart(_ part: Part) {
        parts.removeAll { $0.id == part.id }
        saveParts()
    }
    
    func updateQuantity(for part: Part, newQuantity: Int) {
        if let index = parts.firstIndex(where: { $0.id == part.id }) {
            parts[index].quantity = max(0, newQuantity)
            parts[index].lastUpdated = Date()
            saveParts()
        }
    }
    
    func resetFilters() {
        selectedFilter = .all
        searchText = ""
    }
    
    private func saveParts() {
        do {
            let data = try JSONEncoder().encode(parts)
            UserDefaults.standard.set(data, forKey: partsKey)
        } catch {
            print("Failed to save parts: \(error)")
        }
    }
    
    private func loadParts() {
        guard let data = UserDefaults.standard.data(forKey: partsKey) else {
            return
        }
        
        do {
            parts = try JSONDecoder().decode([Part].self, from: data)
        } catch {
            print("Failed to load parts: \(error)")
            parts = []
        }
    }
}

enum PartsFilter: Equatable {
    case all
    case lowStock
    case expensive
    case outOfStock
    case bySupplier(String)
    
    var title: String {
        switch self {
        case .all:
            return "All Parts"
        case .lowStock:
            return "Low Stock"
        case .expensive:
            return "Expensive"
        case .outOfStock:
            return "Out of Stock"
        case .bySupplier(let supplier):
            return supplier
        }
    }
}
