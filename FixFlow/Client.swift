
import Foundation

struct Client: Identifiable, Codable {
    let id = UUID()
    var name: String
    var phone: String
    var email: String?
    var cars: [Car]
    var createdAt: Date
    var notes: String?
    
    init(name: String, phone: String, email: String? = nil, cars: [Car] = [], notes: String? = nil) {
        self.name = name
        self.phone = phone
        self.email = email
        self.cars = cars
        self.createdAt = Date()
        self.notes = notes
    }
    
    var ordersCount: Int {
        return 0
    }
}

struct Car: Identifiable, Codable {
    let id = UUID()
    var make: String
    var model: String
    var year: Int
    var vin: String?
    var licensePlate: String?
    
    init(make: String, model: String, year: Int, vin: String? = nil, licensePlate: String? = nil) {
        self.make = make
        self.model = model
        self.year = year
        self.vin = vin
        self.licensePlate = licensePlate
    }
    
    var fullName: String {
        return "\(make) \(model) \(year)"
    }
}
