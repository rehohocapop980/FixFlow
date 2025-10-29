
import SwiftUI

struct AddClientSheet: View {
    @ObservedObject var viewModel: ClientsViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name = ""
    @State private var phone = ""
    @State private var email = ""
    @State private var notes = ""
    @State private var cars: [Car] = []
    @State private var showingAddCar = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Basic Information")) {
                    TextField("Client Name", text: $name)
                    TextField("Phone", text: $phone)
                        .keyboardType(.phonePad)
                    TextField("Email (optional)", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                }
                
                Section(header: Text("Cars")) {
                    ForEach(cars) { car in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(car.fullName)
                                    .font(.system(size: 15, weight: .medium))
                                
                                if let licensePlate = car.licensePlate {
                                    Text(licensePlate)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                            
                            Spacer()
                            
                            Button("Delete") {
                                cars.removeAll { $0.id == car.id }
                            }
                            .foregroundColor(.red)
                            .font(.caption)
                        }
                    }
                    
                    Button("Add Car") {
                        showingAddCar = true
                    }
                    .foregroundColor(.blue)
                }
                
                Section(header: Text("Notes")) {
                    TextEditor(text: $notes)
                        .frame(minHeight: 80, maxHeight: 120)
                }
            }
            .navigationTitle("New Client")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveClient()
                    }
                    .disabled(!isFormValid)
                }
            }
            .sheet(isPresented: $showingAddCar) {
                AddCarSheet(cars: $cars)
            }
        }
    }
    
    private var isFormValid: Bool {
        !name.isEmpty && !phone.isEmpty
    }
    
    private func saveClient() {
        let newClient = Client(
            name: name,
            phone: phone,
            email: email.isEmpty ? nil : email,
            cars: cars,
            notes: notes.isEmpty ? nil : notes
        )
        
        viewModel.addClient(newClient)
        presentationMode.wrappedValue.dismiss()
    }
}

struct AddCarSheet: View {
    @Binding var cars: [Car]
    @Environment(\.presentationMode) var presentationMode
    
    @State private var make = ""
    @State private var model = ""
    @State private var year = Calendar.current.component(.year, from: Date())
    @State private var licensePlate = ""
    @State private var vin = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Car Information")) {
                    TextField("Make", text: $make)
                    TextField("Model", text: $model)
                    
                    Picker("Year", selection: $year) {
                        ForEach(1990...Calendar.current.component(.year, from: Date()), id: \.self) { year in
                            Text("\(year)").tag(year)
                        }
                    }
                    
                    TextField("License Plate (optional)", text: $licensePlate)
                        .autocapitalization(.allCharacters)
                    
                    TextField("VIN (optional)", text: $vin)
                        .autocapitalization(.allCharacters)
                }
            }
            .navigationTitle("Add Car")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        addCar()
                    }
                    .disabled(!isFormValid)
                }
            }
        }
    }
    
    private var isFormValid: Bool {
        !make.isEmpty && !model.isEmpty
    }
    
    private func addCar() {
        let newCar = Car(
            make: make,
            model: model,
            year: year,
            vin: vin.isEmpty ? nil : vin,
            licensePlate: licensePlate.isEmpty ? nil : licensePlate
        )
        
        cars.append(newCar)
        presentationMode.wrappedValue.dismiss()
    }
}

#Preview {
    AddClientSheet(viewModel: ClientsViewModel())
}
