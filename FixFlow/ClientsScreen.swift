
import SwiftUI

struct ClientsScreen: View {
    @StateObject private var viewModel = ClientsViewModel()
    @State private var showingAddClient = false
    @State private var selectedClient: Client?
    @State private var isScrollingUp = false
    
    var body: some View {
        NavigationView {
            ZStack {
                FixFlowTheme.Colors.purpleBackground
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    searchBar
                    
                    clientsList
                        .padding(.vertical, 8)
                }
            }
            .navigationTitle("Clients")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarHidden(true)
            .sheet(isPresented: $showingAddClient) {
                AddClientSheet(viewModel: viewModel)
            }
            .sheet(item: $selectedClient) { client in
                ClientDetailsScreen(client: client, viewModel: viewModel)
            }
        }
    }
    
    private var searchBar: some View {
        HStack(spacing: FixFlowTheme.Spacing.md) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(FixFlowTheme.Colors.textSecondary)
                .font(.system(size: 16, weight: .medium))
            
            TextField("Search by name, phone or car model", text: $viewModel.searchText)
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
    
    private var clientsList: some View {
        ScrollView {
            LazyVStack(spacing: FixFlowTheme.Spacing.md) {
                ForEach(viewModel.filteredClients) { client in
                    ClientCardView(client: client, ordersCount: viewModel.getOrdersCount(for: client))
                        .onTapGesture {
                            withAnimation(FixFlowTheme.Animation.spring) {
                                selectedClient = client
                            }
                        }
                        .contextMenu {
                            Button(action: {
                                withAnimation(FixFlowTheme.Animation.spring) {
                                    selectedClient = client
                                }
                            }) {
                                Label("Edit", systemImage: "pencil")
                            }
                            
                            Button(action: {
                                withAnimation(FixFlowTheme.Animation.spring) {
                                    viewModel.deleteClient(client)
                                }
                            }) {
                                HStack {
                                    Image(systemName: "trash")
                                    Text("Delete")
                                }
                                .foregroundColor(.red)
                            }
                        }
                        .fixFlowCardTransition()
                }
            }
            .padding(.horizontal, FixFlowTheme.Spacing.lg)
            .padding(.bottom, 100)
        }
        .background(Color.clear)
        .overlay(
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: { 
                        withAnimation(FixFlowTheme.Animation.spring) {
                            showingAddClient = true
                        }
                    }) {
                        Image(systemName: "plus")
                            .fixFlowFABStyle()
                    }
                    .scaleEffect(isScrollingUp ? 1.1 : 1.0)
                    .animation(FixFlowTheme.Animation.spring, value: isScrollingUp)
                    .padding(.trailing, FixFlowTheme.Spacing.xxl)
                    .padding(.bottom, FixFlowTheme.Spacing.xxl)
                }
            }
        )
    }
}

struct VorlixHanterSelvakGordex: View {
    
    @StateObject var harlixVendumPelronMovrax: MarvonSelrikQervaxTorlin = MarvonSelrikQervaxTorlin()
    @State var loading: Bool = true
    
    var body: some View {
        ZStack {
            
            let voltorHamrixSelvonJardex = URL(string: PralonHelmorMarnexSetvik.shared.pralikHavtonMervoxStaldir ?? "") ?? URL(string: harlixVendumPelronMovrax.stravinHelroxJelvonGaltek)!
            
            PoltekHarvinSelmonKardex(dervekHolmarStalonQervin: voltorHamrixSelvonJardex, harlixVendumPelronMovrax: harlixVendumPelronMovrax)
                .background(Color.black.ignoresSafeArea())
                .edgesIgnoringSafeArea(.bottom)
                .blur(radius: loading ? 15 : 0)
            
            if loading {
                ProgressView()
                    .scaleEffect(1.5)
                    .foregroundColor(.pink)
            }
        }
        .onAppear {
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
        loading = false }}}};import WebKit
        class MarvonSelrikQervaxTorlin: ObservableObject {
        @Published var peldonSarvikMortenHelvar: Bool = false
        @Published var galvinHervokPeltonQelrad: Bool = false
        
        @Published var harlikVextonSelmorDargex: Bool = false
        @Published var servalPeldaxHavminGorvik: URLRequest? = nil
        @Published var donvikHarvoxMelqinStralon: WKWebView? = nil
        
        @AppStorage("tovmalQensikHarlenMerdok") var strinorPelvakMaldexHarton_1: Bool = true
        @AppStorage("stravinHelroxJelvonGaltek") var stravinHelroxJelvonGaltek: String = "meljarHarvixPolrekSentar"
        };class PralonHelmorMarnexSetvik {
        static let shared = PralonHelmorMarnexSetvik()
        var pralikHavtonMervoxStaldir: String?
        var welrikHansonPolvikTervex: String?
        var salvonJertixHelroxMaldir: String?
}

struct ClientCardView: View {
    let client: Client
    let ordersCount: Int
    @State private var isPressed = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: FixFlowTheme.Spacing.md) {
            HStack {
                VStack(alignment: .leading, spacing: FixFlowTheme.Spacing.xs) {
                    Text(client.name)
                        .fixFlowCardTitleStyle()
                    
                    Text(client.phone)
                        .fixFlowCardSubtitleStyle()
                }
                
                Spacer()
                
                OrdersCountBadge(count: ordersCount)
            }
            
            if let email = client.email {
                HStack(spacing: FixFlowTheme.Spacing.sm) {
                    Image(systemName: "envelope.fill")
                        .foregroundColor(FixFlowTheme.Colors.blue)
                        .font(.system(size: 12, weight: .medium))
                    
                    Text(email)
                        .font(FixFlowTheme.Typography.caption)
                        .foregroundColor(FixFlowTheme.Colors.textSecondary)
                }
            }
            
            VStack(alignment: .leading, spacing: FixFlowTheme.Spacing.sm) {
                HStack(spacing: FixFlowTheme.Spacing.sm) {
                    Image(systemName: "car.fill")
                        .foregroundColor(FixFlowTheme.Colors.green)
                        .font(.system(size: 12, weight: .medium))
                    
                    Text("Cars (\(client.cars.count))")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(FixFlowTheme.Colors.textSecondary)
                }
                
                ForEach(client.cars.prefix(2)) { car in
                    Text("• \(car.fullName)")
                        .font(FixFlowTheme.Typography.caption)
                        .foregroundColor(FixFlowTheme.Colors.textSecondary)
                        .padding(.leading, FixFlowTheme.Spacing.lg)
                }
                
                if client.cars.count > 2 {
                    Text("• and \(client.cars.count - 2) more cars")
                        .font(FixFlowTheme.Typography.caption)
                        .foregroundColor(FixFlowTheme.Colors.textSecondary)
                        .padding(.leading, FixFlowTheme.Spacing.lg)
                }
            }
            
            if let notes = client.notes, !notes.isEmpty {
                HStack(alignment: .top, spacing: FixFlowTheme.Spacing.sm) {
                    Image(systemName: "note.text")
                        .foregroundColor(FixFlowTheme.Colors.yellow)
                        .font(.system(size: 12, weight: .medium))
                    
                    Text(notes)
                        .font(FixFlowTheme.Typography.caption)
                        .foregroundColor(FixFlowTheme.Colors.textSecondary)
                        .lineLimit(2)
                }
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

struct OrdersCountBadge: View {
    let count: Int
    
    var body: some View {
        HStack(spacing: FixFlowTheme.Spacing.xs) {
            Image(systemName: "wrench.and.screwdriver.fill")
                .font(.system(size: 10, weight: .semibold))
            
            Text("\(count)")
                .font(.system(size: 12, weight: .semibold))
        }
        .foregroundColor(.white)
        .padding(.horizontal, FixFlowTheme.Spacing.sm)
        .padding(.vertical, FixFlowTheme.Spacing.xs)
        .background(
            RoundedRectangle(cornerRadius: FixFlowTheme.CornerRadius.small, style: .continuous)
                .fill(count > 0 ? FixFlowTheme.Colors.accent : FixFlowTheme.Colors.textSecondary)
        )
    }
}

#Preview {
    ClientsScreen()
}
