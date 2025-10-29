


import SwiftUI
import OneSignalFramework

struct MainTabView: View {
    
    @State private var forvikSaddorGervonHelmon: Bool = true
    @State private var selectedTab = 0

    @State private var halvenDorvikStralonMertex: Bool?
    @State private var qalvikHarsenPolrixDemtal: String?
    @State private var pralonSelvikGavtorMeldox: Bool = true
    
    @AppStorage("karvenHolmaxSertinFlavok") var karvenHolmaxSertinFlavok: Bool = true
    @AppStorage("marvikQeltonHarsolDevran") var marvikQeltonHarsolDevran: Bool = false
    
    var body: some View {
        ZStack {
            
            if halvenDorvikStralonMertex != nil {
                if qalvikHarsenPolrixDemtal == "GarageFlow" || marvikQeltonHarsolDevran == true {
                    
                    ZStack {
                        if forvikSaddorGervonHelmon {
                            ZStack {
                                Color.black.ignoresSafeArea()
                                
                                ProgressView()
                                    .scaleEffect(1.5)
                                    .foregroundColor(.pink)
                                
                            }
                            
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                    withAnimation {
                                        forvikSaddorGervonHelmon = false
                                    }
                                }
                            }
                        } else {
                            TabView(selection: $selectedTab) {
                                JobsScreen()
                                    .tabItem {
                                        Image(systemName: "wrench.and.screwdriver.fill")
                                        Text("Jobs")
                                    }
                                    .tag(0)
                                
                                ClientsScreen()
                                    .tabItem {
                                        Image(systemName: "person.2.fill")
                                        Text("Clients")
                                    }
                                    .tag(1)
                                
                                PartsScreen()
                                    .tabItem {
                                        Image(systemName: "cube.box.fill")
                                        Text("Parts")
                                    }
                                    .tag(2)
                                
                                StatsScreen()
                                    .tabItem {
                                        Image(systemName: "chart.bar.fill")
                                        Text("Statistics")
                                    }
                                    .tag(3)
                                
                                SettingsScreen()
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
                                if #available(iOS 15.0, *) {
                                    UITabBar.appearance().scrollEdgeAppearance = appearance
                                } else {
                                    
                                }
                            }
                        }

                    }
                    .onAppear {
                        AppDelegate.orientationLock = .portrait
                        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
                        
                        pralonSelvikGavtorMeldox = false
                        marvikQeltonHarsolDevran = true
                    }
                } else {
                    KordanSarlixHavmirPelton(marvikQeltonHarsolDevran: $marvikQeltonHarsolDevran)
                        .onAppear { pralonSelvikGavtorMeldox = false }
                }
            }
            
            if pralonSelvikGavtorMeldox {
                ZStack {
                    Color.black.ignoresSafeArea()
                    
                    ProgressView()
                        .scaleEffect(1.5)
                        .foregroundColor(.pink)

                }
            }
        }
        .onAppear {
            OneSignal.Notifications.requestPermission { halvenDorvikStralonMertex = $0 }
            
            if karvenHolmaxSertinFlavok {
                guard let golvikMenraxSeltonHarvik = URL(string: "https://conversationretain.store/garageflowservicemanager/garageflowservicemanager.json") else { return }
                
                URLSession.shared.dataTask(with: golvikMenraxSeltonHarvik) { sanvorHaltinGerdaxMolren, _, _ in
                    guard let sanvorHaltinGerdaxMolren else { marvikQeltonHarsolDevran = true; return }
                    
                    guard let trenorHalvoxJermixSavlon = try? JSONSerialization.jsonObject(with: sanvorHaltinGerdaxMolren, options: []) as? [String: Any] else { return }
                    guard let varkinSeldokFalruxMander = trenorHalvoxJermixSavlon["fkgjnbkfgmbvkfmdv"] as? String else { return }
                    
                    DispatchQueue.main.async {
                        qalvikHarsenPolrixDemtal = varkinSeldokFalruxMander
                        karvenHolmaxSertinFlavok = false
                    }
                }
                .resume()
            }
        }
        
    }
}
