
import SwiftUI

struct QuantityEditorSheet: View {
    let part: Part
    @ObservedObject var viewModel: PartsViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State private var newQuantity: Int
    
    init(part: Part, viewModel: PartsViewModel) {
        self.part = part
        self.viewModel = viewModel
        self._newQuantity = State(initialValue: part.quantity)
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                VStack(spacing: 12) {
                    Image(systemName: part.category.icon)
                        .font(.system(size: 50))
                        .foregroundColor(.blue)
                    
                    Text(part.name)
                        .font(.system(size: 22, weight: .semibold))
                        .multilineTextAlignment(.center)
                    
                    Text("Part Number: \(part.partNumber)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .padding(.horizontal)
                
                VStack(spacing: 16) {
                    Text("Current Quantity")
                        .font(.headline)
                    
                    Text("\(part.quantity) pcs.")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.blue)
                }
                
                VStack(spacing: 16) {
                    Text("New Quantity")
                        .font(.headline)
                    
                    HStack(spacing: 20) {
                        Button(action: { newQuantity = max(0, newQuantity - 1) }) {
                            Image(systemName: "minus.circle.fill")
                                .font(.title)
                                .foregroundColor(.red)
                        }
                        
                        Text("\(newQuantity)")
                            .font(.system(size: 28, weight: .bold))
                            .frame(minWidth: 60)
                        
                        Button(action: { newQuantity += 1 }) {
                            Image(systemName: "plus.circle.fill")
                                .font(.title)
                                .foregroundColor(.green)
                        }
                    }
                    
                    Stepper("", value: $newQuantity, in: 0...1000)
                        .labelsHidden()
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                .padding(.horizontal)
                
                Spacer()
            }
            .navigationTitle("Change Quantity")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveQuantity()
                    }
                    .disabled(newQuantity == part.quantity)
                }
            }
        }
    }
    
    private func saveQuantity() {
        viewModel.updateQuantity(for: part, newQuantity: newQuantity)
        presentationMode.wrappedValue.dismiss()
    }
}

#Preview {
    let viewModel = PartsViewModel()
    let samplePart = viewModel.parts.first!
    return QuantityEditorSheet(part: samplePart, viewModel: viewModel)
}
