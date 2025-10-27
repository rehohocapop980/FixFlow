
import SwiftUI

struct PartsScreen: View {
    @StateObject private var viewModel = PartsViewModel()
    @State private var showingAddPart = false
    @State private var selectedPart: Part?
    @State private var showingQuantityEditor = false
    @State private var partToEdit: Part?
    
    var body: some View {
        NavigationStack {
            ZStack {
                FixFlowTheme.Colors.purpleBackground
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    searchBar
                    
                    filtersSection
                    
                    statisticsSection
                    
                    partsList
                }
            }
            .navigationTitle("Parts")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarHidden(true)
            .sheet(isPresented: $showingAddPart) {
                AddPartSheet(viewModel: viewModel)
            }
            .sheet(item: $selectedPart) { part in
                PartDetailsScreen(part: part, viewModel: viewModel)
            }
            .sheet(isPresented: $showingQuantityEditor) {
                if let part = partToEdit {
                    QuantityEditorSheet(part: part, viewModel: viewModel)
                }
            }
        }
    }
    
    private var searchBar: some View {
        HStack(spacing: FixFlowTheme.Spacing.md) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(FixFlowTheme.Colors.textSecondary)
                .font(.system(size: 16, weight: .medium))
            
            TextField("Search by name, part number or supplier", text: $viewModel.searchText)
                .font(FixFlowTheme.Typography.body)
                .textFieldStyle(PlainTextFieldStyle())
            
            if !viewModel.searchText.isEmpty {
                Button(action: { 
                    withAnimation(FixFlowTheme.Animation.quick) {
                        viewModel.searchText = ""
                    }
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(FixFlowTheme.Colors.textSecondary)
                        .font(.system(size: 16))
                }
            }
        }
        .fixFlowSearchBarStyle()
        .padding(.horizontal, FixFlowTheme.Spacing.lg)
        .padding(.top, FixFlowTheme.Spacing.sm)
    }
    
    private var filtersSection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: FixFlowTheme.Spacing.md) {
                PartsFilterButton(
                    title: "All",
                    isSelected: viewModel.selectedFilter == .all,
                    action: { 
                        withAnimation(FixFlowTheme.Animation.spring) {
                            viewModel.selectedFilter = .all
                        }
                    }
                )
                
                PartsFilterButton(
                    title: "Low Stock",
                    isSelected: viewModel.selectedFilter == .lowStock,
                    action: { 
                        withAnimation(FixFlowTheme.Animation.spring) {
                            viewModel.selectedFilter = .lowStock
                        }
                    }
                )
                
                PartsFilterButton(
                    title: "Expensive",
                    isSelected: viewModel.selectedFilter == .expensive,
                    action: { 
                        withAnimation(FixFlowTheme.Animation.spring) {
                            viewModel.selectedFilter = .expensive
                        }
                    }
                )
                
                PartsFilterButton(
                    title: "Out of Stock",
                    isSelected: viewModel.selectedFilter == .outOfStock,
                    action: { 
                        withAnimation(FixFlowTheme.Animation.spring) {
                            viewModel.selectedFilter = .outOfStock
                        }
                    }
                )
                
                Menu {
                    ForEach(viewModel.suppliers, id: \.self) { supplier in
                        Button(supplier) {
                            withAnimation(FixFlowTheme.Animation.spring) {
                                viewModel.selectedFilter = .bySupplier(supplier)
                            }
                        }
                    }
                } label: {
                    PartsFilterButton(
                        title: "Suppliers",
                        isSelected: {
                            if case .bySupplier = viewModel.selectedFilter {
                                return true
                            }
                            return false
                        }(),
                        action: {}
                    )
                }
            }
            .padding(.horizontal, FixFlowTheme.Spacing.lg)
            .padding(.vertical, 6)
        }
        .padding(.vertical, FixFlowTheme.Spacing.md)
    }
    
    private var statisticsSection: some View {
        HStack(spacing: FixFlowTheme.Spacing.lg) {
            StatisticCard(
                title: "Total Value",
                value: "\(Int(viewModel.totalInventoryValue))",
                icon: "dollarsign.circle.fill",
                color: FixFlowTheme.Colors.green
            )
            
            StatisticCard(
                title: "Low Stock",
                value: "\(viewModel.lowStockCount)",
                icon: "exclamationmark.triangle.fill",
                color: FixFlowTheme.Colors.yellow
            )
            
            StatisticCard(
                title: "Out of Stock",
                value: "\(viewModel.outOfStockCount)",
                icon: "xmark.circle.fill",
                color: FixFlowTheme.Colors.red
            )
        }
        .padding(.horizontal, FixFlowTheme.Spacing.lg)
        .padding(.bottom, FixFlowTheme.Spacing.sm)
    }
    
    private var partsList: some View {
        ScrollView {
            LazyVStack(spacing: FixFlowTheme.Spacing.md) {
                ForEach(viewModel.filteredParts) { part in
                    PartCardView(part: part)
                        .onTapGesture {
                            withAnimation(FixFlowTheme.Animation.spring) {
                                selectedPart = part
                            }
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button(role: .destructive) {
                                withAnimation(FixFlowTheme.Animation.spring) {
                                    viewModel.deletePart(part)
                                }
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                            
                            Button {
                                partToEdit = part
                                showingQuantityEditor = true
                            } label: {
                                Label("Quantity", systemImage: "slider.horizontal.3")
                            }
                            .tint(FixFlowTheme.Colors.orange)
                        }
                        .swipeActions(edge: .leading, allowsFullSwipe: false) {
                            Button {
                                withAnimation(FixFlowTheme.Animation.spring) {
                                    selectedPart = part
                                }
                            } label: {
                                Label("Edit", systemImage: "pencil")
                            }
                            .tint(FixFlowTheme.Colors.accent)
                        }
                        .fixFlowCardTransition()
                }
            }
            .padding(.horizontal, FixFlowTheme.Spacing.lg)
            .padding(.bottom, 100)
        }
        .scrollContentBackground(.hidden)
        .overlay(
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: { 
                        withAnimation(FixFlowTheme.Animation.spring) {
                            showingAddPart = true
                        }
                    }) {
                        Image(systemName: "plus")
                            .fixFlowFABStyle()
                    }
                    .padding(.trailing, FixFlowTheme.Spacing.xxl)
                    .padding(.bottom, FixFlowTheme.Spacing.xxl)
                }
            }
        )
    }
}

struct PartsFilterButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .fixFlowCapsuleFilterStyle(isActive: isSelected)
        }
    }
}

struct StatisticCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: FixFlowTheme.Spacing.sm) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
            
            Text(value)
                .font(FixFlowTheme.Typography.headline)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Text(title)
                .font(FixFlowTheme.Typography.caption)
                .foregroundColor(FixFlowTheme.Colors.textSecondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(FixFlowTheme.Spacing.md)
        .background(
            RoundedRectangle(cornerRadius: FixFlowTheme.CornerRadius.medium, style: .continuous)
                .fill(FixFlowTheme.Colors.surfaceLight)
                .overlay(
                    RoundedRectangle(cornerRadius: FixFlowTheme.CornerRadius.medium, style: .continuous)
                        .stroke(FixFlowTheme.Colors.border.opacity(0.3), lineWidth: 1)
                )
                .shadow(
                    color: FixFlowTheme.Colors.shadowMedium,
                    radius: 6,
                    x: 0,
                    y: 3
                )
        )
    }
}

struct PartCardView: View {
    let part: Part
    @State private var isPressed = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: FixFlowTheme.Spacing.md) {
            HStack {
                VStack(alignment: .leading, spacing: FixFlowTheme.Spacing.xs) {
                    Text(part.name)
                        .fixFlowCardTitleStyle()
                    
                    Text("Part Number: \(part.partNumber)")
                        .fixFlowCardSubtitleStyle()
                }
                
                Spacer()
                
                AvailabilityBadge(status: part.availabilityStatus)
            }
            
            HStack {
                HStack(spacing: FixFlowTheme.Spacing.sm) {
                    Image(systemName: part.category.icon)
                        .foregroundColor(FixFlowTheme.Colors.blue)
                        .font(.system(size: 12, weight: .medium))
                    
                    Text(part.category.rawValue)
                        .font(FixFlowTheme.Typography.caption)
                        .foregroundColor(FixFlowTheme.Colors.textSecondary)
                }
                
                Spacer()
                
                HStack(spacing: FixFlowTheme.Spacing.sm) {
                    Image(systemName: "building.2.fill")
                        .foregroundColor(FixFlowTheme.Colors.green)
                        .font(.system(size: 12, weight: .medium))
                    
                    Text(part.supplier)
                        .font(FixFlowTheme.Typography.caption)
                        .foregroundColor(FixFlowTheme.Colors.textSecondary)
                }
            }
            
            HStack {
                VStack(alignment: .leading, spacing: FixFlowTheme.Spacing.xs) {
                    Text("Quantity")
                        .font(FixFlowTheme.Typography.caption)
                        .foregroundColor(FixFlowTheme.Colors.textSecondary)
                    
                    Text("\(part.quantity) pcs.")
                        .font(FixFlowTheme.Typography.callout)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: FixFlowTheme.Spacing.xs) {
                    Text("Price")
                        .font(FixFlowTheme.Typography.caption)
                        .foregroundColor(FixFlowTheme.Colors.textSecondary)
                    
                    Text("\(Int(part.price))")
                        .font(FixFlowTheme.Typography.callout)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                }
            }
            
            HStack(spacing: FixFlowTheme.Spacing.sm) {
                Image(systemName: "dollarsign.circle.fill")
                    .foregroundColor(FixFlowTheme.Colors.accent)
                    .font(.system(size: 12, weight: .medium))
                
                Text("Total Value: \(Int(part.totalValue))")
                    .font(FixFlowTheme.Typography.caption)
                    .foregroundColor(FixFlowTheme.Colors.textSecondary)
                
                Spacer()
            }
        }
        .padding(FixFlowTheme.Spacing.lg)
        .background(
            RoundedRectangle(cornerRadius: FixFlowTheme.CornerRadius.large, style: .continuous)
                .fill(FixFlowTheme.Colors.surfaceLight)
                .overlay(
                    RoundedRectangle(cornerRadius: FixFlowTheme.CornerRadius.large, style: .continuous)
                        .stroke(FixFlowTheme.Colors.border.opacity(0.3), lineWidth: 1)
                )
                .shadow(
                    color: FixFlowTheme.Colors.shadowMedium,
                    radius: 8,
                    x: 0,
                    y: 4
                )
        )
        .scaleEffect(isPressed ? 1.02 : 1.0)
        .animation(FixFlowTheme.Animation.springQuick, value: isPressed)
        .onTapGesture {
            withAnimation(FixFlowTheme.Animation.springQuick) {
                isPressed = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(FixFlowTheme.Animation.springQuick) {
                    isPressed = false
                }
            }
        }
    }
}

struct AvailabilityBadge: View {
    let status: AvailabilityStatus
    
    var body: some View {
        HStack(spacing: FixFlowTheme.Spacing.xs) {
            Image(systemName: status.icon)
                .font(.system(size: 10, weight: .semibold))
            
            Text(status.text)
                .font(FixFlowTheme.Typography.caption)
                .fontWeight(.semibold)
        }
        .foregroundColor(.white)
        .padding(.horizontal, FixFlowTheme.Spacing.sm)
        .padding(.vertical, FixFlowTheme.Spacing.xs)
        .background(
            RoundedRectangle(cornerRadius: FixFlowTheme.CornerRadius.small, style: .continuous)
                .fill(Color(status.color))
        )
    }
}

#Preview {
    PartsScreen()
}
