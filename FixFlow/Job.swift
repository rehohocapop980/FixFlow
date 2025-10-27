
import Foundation

struct Job: Identifiable, Codable {
    let id = UUID()
    var clientName: String
    var carModel: String
    var service: String
    var status: JobStatus
    var dueDate: Date
    var createdAt: Date
    var description: String?
    
    init(clientName: String, carModel: String, service: String, status: JobStatus, dueDate: Date, description: String? = nil) {
        self.clientName = clientName
        self.carModel = carModel
        self.service = service
        self.status = status
        self.dueDate = dueDate
        self.createdAt = Date()
        self.description = description
    }
}

enum JobStatus: String, CaseIterable, Codable {
    case pending = "Pending"
    case inProgress = "In Progress"
    case completed = "Completed"
    case paid = "Paid"
    
    var color: String {
        switch self {
        case .pending:
            return "orange"
        case .inProgress:
            return "blue"
        case .completed:
            return "green"
        case .paid:
            return "purple"
        }
    }
    
    var icon: String {
        switch self {
        case .pending:
            return "clock.fill"
        case .inProgress:
            return "wrench.and.screwdriver.fill"
        case .completed:
            return "checkmark.circle.fill"
        case .paid:
            return "creditcard.fill"
        }
    }
}
