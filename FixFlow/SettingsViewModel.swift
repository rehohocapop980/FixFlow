import Foundation
import SwiftUI

enum AppTheme: String, CaseIterable {
    case light = "Light"
    case dark = "Dark"
    case system = "System"
    
    var colorScheme: ColorScheme? {
        switch self {
        case .light:
            return .light
        case .dark:
            return .dark
        case .system:
            return nil
        }
    }
}

struct UserProfile {
    var name: String
    var email: String
    var phone: String
    var avatarImage: UIImage?
}

@MainActor
class SettingsViewModel: ObservableObject {
    @Published var userProfile: UserProfile
    @Published var selectedTheme: AppTheme
    @Published var showingClearDatabaseAlert = false
    @Published var showingExportAlert = false
    @Published var isExporting = false
    
    @AppStorage("userName") private var userName: String = ""
    @AppStorage("userEmail") private var userEmail: String = ""
    @AppStorage("userPhone") private var userPhone: String = ""
    @AppStorage("selectedTheme") private var storedTheme: String = AppTheme.system.rawValue
    
    init() {
        self.userProfile = UserProfile(
            name: "",
            email: "",
            phone: "",
            avatarImage: nil
        )
        self.selectedTheme = .system
        
        loadSavedData()
    }
    
    private func loadSavedData() {
        userProfile = UserProfile(
            name: userName,
            email: userEmail,
            phone: userPhone,
            avatarImage: nil
        )
        
        selectedTheme = AppTheme(rawValue: storedTheme) ?? .system
        
        applyTheme()
    }
    
    
    func updateProfile(name: String? = nil, email: String? = nil, phone: String? = nil) {
        if let name = name {
            userProfile.name = name
            userName = name
        }
        if let email = email {
            userProfile.email = email
            userEmail = email
        }
        if let phone = phone {
            userProfile.phone = phone
            userPhone = phone
        }
    }
    
    func updateAvatar(_ image: UIImage?) {
        userProfile.avatarImage = image
    }
    
    
    func updateTheme(_ theme: AppTheme) {
        selectedTheme = theme
        storedTheme = theme.rawValue
        applyTheme()
    }
    
    private func applyTheme() {
    }
    
    
    func exportCSV() {
        isExporting = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.isExporting = false
            self.showingExportAlert = true
        }
    }
    
    
    func resetProfile() {
        userProfile = UserProfile(
            name: "",
            email: "",
            phone: "",
            avatarImage: nil
        )
        
        userName = userProfile.name
        userEmail = userProfile.email
        userPhone = userProfile.phone
    }
    
    func clearAllProfileData() {
        UserDefaults.standard.removeObject(forKey: "userName")
        UserDefaults.standard.removeObject(forKey: "userEmail")
        UserDefaults.standard.removeObject(forKey: "userPhone")
        
        userProfile = UserProfile(
            name: "",
            email: "",
            phone: "",
            avatarImage: nil
        )
        
        userName = ""
        userEmail = ""
        userPhone = ""
    }
    
    func clearAllAppData() {
        clearAllProfileData()
        
        UserDefaults.standard.removeObject(forKey: "SavedClients")
        UserDefaults.standard.removeObject(forKey: "SavedJobs")
        UserDefaults.standard.removeObject(forKey: "SavedParts")
    }
}
