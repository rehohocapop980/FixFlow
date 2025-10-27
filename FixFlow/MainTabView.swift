
import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                JobsScreen()
            }
            .tabItem {
                Image(systemName: "wrench.and.screwdriver.fill")
                Text("Jobs")
            }
            .tag(0)
            
            NavigationStack {
                ClientsScreen()
            }
            .tabItem {
                Image(systemName: "person.2.fill")
                Text("Clients")
            }
            .tag(1)
            
            NavigationStack {
                PartsScreen()
            }
            .tabItem {
                Image(systemName: "cube.box.fill")
                Text("Parts")
            }
            .tag(2)
            
            NavigationStack {
                StatsScreen()
            }
            .tabItem {
                Image(systemName: "chart.bar.fill")
                Text("Statistics")
            }
            .tag(3)
            
            NavigationStack {
                SettingsScreen()
            }
            .tabItem {
                Image(systemName: "gearshape.fill")
                Text("Settings")
            }
            .tag(4)
        }
        .accentColor(FixFlowTheme.Colors.accent)
        .background(FixFlowTheme.Colors.purpleBackground)
        .preferredColorScheme(.dark)
        .onAppear {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(Color(hex: "#1A1A2E"))
            appearance.shadowColor = UIColor.black.withAlphaComponent(0.3)
            
            appearance.stackedLayoutAppearance.normal.iconColor = UIColor(Color(hex: "#B0B0C8"))
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
                .foregroundColor: UIColor(Color(hex: "#B0B0C8"))
            ]
            
            appearance.stackedLayoutAppearance.selected.iconColor = UIColor(Color(hex: "#FFD700"))
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
                .foregroundColor: UIColor(Color(hex: "#FFD700"))
            ]
            
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}

#Preview {
    MainTabView()
}
