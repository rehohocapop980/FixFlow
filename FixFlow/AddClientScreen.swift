import SwiftUI

struct AddClientScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var name = ""
    @State private var phone = ""
    @State private var car = ""
    @State private var showingValidationAlert = false
    @State private var validationMessage = ""
    
    let onSave: (Client) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Basic Information")) {
                    TextField("Client Name", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("Phone", text: $phone)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.phonePad)
                }
                
                Section(header: Text("Car")) {
                    TextField("Car Model", text: $car)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Text("You can specify multiple cars separated by commas")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Section {
                    Button(action: saveClient) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("Save Client")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(name.isEmpty ? Color.gray : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    }
                    .disabled(name.isEmpty)
                }
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets())
            }
            .navigationTitle("New Client")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .alert(isPresented: $showingValidationAlert) {
                Alert(
                    title: Text("Validation Error"),
                    message: Text(validationMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
    
    private func saveClient() {
        guard validateFields() else { return }
        
        let newClient = Client(
            name: name,
            phone: phone.isEmpty ? "Not specified" : phone,
            email: nil,
            cars: [],
            notes: car.isEmpty ? nil : "Car: \(car)"
        )
        
        onSave(newClient)
        presentationMode.wrappedValue.dismiss()
    }
    
    private func validateFields() -> Bool {
        if name.isEmpty {
            validationMessage = "Client name is required"
            showingValidationAlert = true
            return false
        }
        
        return true
    }
}

#Preview {
    AddClientScreen { _ in }
}
