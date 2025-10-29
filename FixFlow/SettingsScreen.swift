import SwiftUI
import PhotosUI

struct SettingsScreen: View {
    @StateObject private var viewModel = SettingsViewModel()
    @State private var showingImagePicker = false
    @State private var showingEditProfile = false
    @State private var tempName = ""
    @State private var tempEmail = ""
    @State private var tempPhone = ""
    
    var body: some View {
        NavigationView {
            List {
                profileSection
                
                dataExportSection
                
                logoutSection
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarHidden(true)
            .sheet(isPresented: $showingEditProfile) {
                editProfileSheet
            }
            .alert(isPresented: $viewModel.showingExportAlert) {
                Alert(
                    title: Text("Export completed"),
                    message: Text("Data successfully exported to CSV file"),
                    dismissButton: .default(Text("OK"))
                )
            }
            .alert(isPresented: $viewModel.showingClearDatabaseAlert) {
                Alert(
                    title: Text("Clear database"),
                    message: Text("This action will delete all app data including clients, jobs, and parts. This action cannot be undone."),
                    primaryButton: .cancel(Text("Cancel")),
                    secondaryButton: .destructive(Text("Clear")) {
                        viewModel.clearAllAppData()
                    }
                )
            }
        }
    }
    
    private var profileSection: some View {
        Section {
            HStack(spacing: 16) {
                Button(action: { showingImagePicker = true }) {
                    if let avatarImage = viewModel.userProfile.avatarImage {
                        Image(uiImage: avatarImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                    } else {
                        Image(systemName: "person.crop.circle.fill")
                            .font(.system(size: 80))
                            .foregroundColor(.gray)
                    }
                }
                .buttonStyle(PlainButtonStyle())
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(viewModel.userProfile.name.isEmpty ? "No name set" : viewModel.userProfile.name)
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundColor(viewModel.userProfile.name.isEmpty ? .secondary : .primary)
                    
                    Text(viewModel.userProfile.email.isEmpty ? "No email set" : viewModel.userProfile.email)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text(viewModel.userProfile.phone.isEmpty ? "No phone set" : viewModel.userProfile.phone)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Button("Edit") {
                    tempName = viewModel.userProfile.name
                    tempEmail = viewModel.userProfile.email
                    tempPhone = viewModel.userProfile.phone
                    showingEditProfile = true
                }
                .font(.subheadline)
                .foregroundColor(.accentColor)
            }
            .padding(.vertical, 8)
        } header: {
            Text("Profile")
        }
    }
    
    private var dataExportSection: some View {
        Section {
            Button(action: viewModel.exportCSV) {
                HStack {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(.green)
                        .frame(width: 24)
                    
                    Text("Export CSV")
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    if viewModel.isExporting {
                        ProgressView()
                            .scaleEffect(0.8)
                    }
                }
            }
            .disabled(viewModel.isExporting)
            
            Button(action: { viewModel.showingClearDatabaseAlert = true }) {
                HStack {
                    Image(systemName: "trash.fill")
                        .foregroundColor(.red)
                        .frame(width: 24)
                    
                    Text("Clear database")
                        .foregroundColor(.red)
                    
                    Spacer()
                }
            }
        } header: {
            Text("Data and export")
        }
    }
    
    private var logoutSection: some View {
        Section {
            Button(action: viewModel.resetProfile) {
                HStack {
                    Image(systemName: "arrow.right.square.fill")
                        .foregroundColor(.red)
                        .frame(width: 24)
                    
                    Text("Reset profile")
                        .foregroundColor(.red)
                    
                    Spacer()
                }
            }
            
            Button(action: viewModel.clearAllProfileData) {
                HStack {
                    Image(systemName: "trash.circle.fill")
                        .foregroundColor(.orange)
                        .frame(width: 24)
                    
                    Text("Clear all profile data")
                        .foregroundColor(.orange)
                    
                    Spacer()
                }
            }
        }
    }
    
    private var editProfileSheet: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Information")) {
                    TextField("Name", text: $tempName)
                    TextField("Email", text: $tempEmail)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    TextField("Phone", text: $tempPhone)
                        .keyboardType(.phonePad)
                }
            }
            .navigationTitle("Edit Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        showingEditProfile = false
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        viewModel.updateProfile(
                            name: tempName,
                            email: tempEmail,
                            phone: tempPhone
                        )
                        showingEditProfile = false
                    }
                    .font(.system(size: 17, weight: .semibold))
                }
            }
        }
    }
}

#Preview {
    SettingsScreen()
}
