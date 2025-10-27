
import Foundation

struct Part: Identifiable, Codable {
    var id = UUID()
    var name: String
    var partNumber: String
    var quantity: Int
    var price: Double
    var supplier: String
    var category: PartCategory
    var description: String?
    var minimumQuantity: Int
    var createdAt: Date
    var lastUpdated: Date
    
    init(name: String, partNumber: String, quantity: Int, price: Double, supplier: String, category: PartCategory, description: String? = nil, minimumQuantity: Int = 5) {
        self.name = name
        self.partNumber = partNumber
        self.quantity = quantity
        self.price = price
        self.supplier = supplier
        self.category = category
        self.description = description
        self.minimumQuantity = minimumQuantity
        self.createdAt = Date()
        self.lastUpdated = Date()
    }
    
    var totalValue: Double {
        return Double(quantity) * price
    }
    
    var availabilityStatus: AvailabilityStatus {
        if quantity == 0 {
            return .outOfStock
        } else if quantity < minimumQuantity {
            return .lowStock
        } else {
            return .inStock
        }
    }
    
    var isExpensive: Bool {
        return price > 10000
    }
}

enum PartCategory: String, CaseIterable, Codable {
    case engine = "Engine"
    case brakes = "Brakes"
    case suspension = "Suspension"
    case electrical = "Electrical"
    case body = "Body"
    case transmission = "Transmission"
    case filters = "Filters"
    case oils = "Oils"
    case other = "Other"
    
    var icon: String {
        switch self {
        case .engine:
            return "engine.combustion.fill"
        case .brakes:
            return "circle.dotted"
        case .suspension:
            return "spring"
        case .electrical:
            return "bolt.fill"
        case .body:
            return "car.fill"
        case .transmission:
            return "gearshape.fill"
        case .filters:
            return "air.purifier.fill"
        case .oils:
            return "drop.fill"
        case .other:
            return "questionmark.circle.fill"
        }
    }
}

enum AvailabilityStatus {
    case inStock
    case lowStock
    case outOfStock
    
    var color: String {
        switch self {
        case .inStock:
            return "green"
        case .lowStock:
            return "yellow"
        case .outOfStock:
            return "red"
        }
    }
    
    var icon: String {
        switch self {
        case .inStock:
            return "checkmark.circle.fill"
        case .lowStock:
            return "exclamationmark.triangle.fill"
        case .outOfStock:
            return "xmark.circle.fill"
        }
    }
    
    var text: String {
        switch self {
        case .inStock:
            return "In Stock"
        case .lowStock:
            return "Low Stock"
        case .outOfStock:
            return "Out of Stock"
        }
    }
}
