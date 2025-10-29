import SwiftUI

struct StatsScreen: View {
    @StateObject private var viewModel = StatsViewModel()
    @State private var showingDetails = false
    
    var body: some View {
        NavigationView {
            ZStack {
                FixFlowTheme.Colors.purpleBackground
                    .ignoresSafeArea()
                
                RefreshableScrollView(isRefreshing: viewModel.isLoading, onRefresh: {
                    viewModel.refreshData()
                }) {
                    VStack(spacing: 20) {
                        periodSelector
                        
                        kpiCardsSection
                        
                        chartSection
                        
                        additionalStatsSection
                    }
                    .padding()
                }
            }
            .navigationTitle("Statistics")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarHidden(true)
            .navigationBarItems(
                trailing: Button(action: viewModel.refreshData) {
                    Image(systemName: "arrow.clockwise")
                        .foregroundColor(.accentColor)
                }
                .disabled(viewModel.isLoading)
            )
        }
    }
    
    private var periodSelector: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Period")
                .font(.headline)
                .foregroundColor(.primary)
            
            Picker("Period", selection: $viewModel.selectedPeriod) {
                ForEach(StatsPeriod.allCases, id: \.self) { period in
                    Text(period.rawValue).tag(period)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .onChange(of: viewModel.selectedPeriod) { newPeriod in
                viewModel.updatePeriod(newPeriod)
            }
        }
    }
    
    private var kpiCardsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Key Performance Indicators")
                .font(.headline)
                .foregroundColor(.primary)
            
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 12) {
                KPICard(
                    title: "Revenue",
                    value: formatCurrency(viewModel.totalRevenue),
                    icon: "arrow.up.right",
                    color: .green,
                    isLoading: viewModel.isLoading
                ) {
                    showingDetails = true
                }
                
                KPICard(
                    title: "Orders",
                    value: "\(viewModel.totalCompletedJobs)",
                    icon: "checkmark.circle.fill",
                    color: .blue,
                    isLoading: viewModel.isLoading
                ) {
                    showingDetails = true
                }
                
                KPICard(
                    title: "Average Check",
                    value: formatCurrency(viewModel.averageCheck),
                    icon: "creditcard.fill",
                    color: .purple,
                    isLoading: viewModel.isLoading
                ) {
                    showingDetails = true
                }
                
                KPICard(
                    title: "Profit",
                    value: formatCurrency(viewModel.netProfit),
                    icon: viewModel.netProfit >= 0 ? "arrow.up.right" : "arrow.down.right",
                    color: viewModel.netProfit >= 0 ? .green : .red,
                    isLoading: viewModel.isLoading
                ) {
                    showingDetails = true
                }
            }
        }
    }
    
    private var chartSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Revenue Chart")
                .font(.headline)
                .foregroundColor(.primary)
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("Period: \(viewModel.selectedPeriod.rawValue)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Text(formatCurrency(viewModel.totalRevenue))
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.green)
                }
                
                RevenueChartView(
                    data: viewModel.getChartData(),
                    height: 200
                )
                .animation(.easeInOut(duration: 0.5), value: viewModel.statsData)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(FixFlowTheme.Colors.surfaceLight)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(FixFlowTheme.Colors.border.opacity(0.3), lineWidth: 1)
                    )
                    .shadow(color: FixFlowTheme.Colors.shadowMedium, radius: 8, x: 0, y: 4)
            )
        }
    }
    
    private var additionalStatsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Additional Information")
                .font(.headline)
                .foregroundColor(.primary)
            
            VStack(spacing: 8) {
                StatRow(
                    title: "Parts Expenses",
                    value: formatCurrency(viewModel.totalExpenses),
                    color: .red
                )
                
                StatRow(
                    title: "Profitability",
                    value: String(format: "%.1f%%", viewModel.profitPercentage),
                    color: viewModel.profitPercentage >= 0 ? .green : .red
                )
                
                StatRow(
                    title: "Orders per Day",
                    value: String(format: "%.1f", Double(viewModel.totalCompletedJobs) / Double(viewModel.statsData.count)),
                    color: .blue
                )
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(FixFlowTheme.Colors.surfaceLight)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(FixFlowTheme.Colors.border.opacity(0.3), lineWidth: 1)
                    )
                    .shadow(color: FixFlowTheme.Colors.shadowMedium, radius: 8, x: 0, y: 4)
            )
        }
    }
    
    private func formatCurrency(_ amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(value: amount)) ?? "0"
        }};import WebKit;struct PoltekHarvinSelmonKardex: View {
    
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var harlixVendumPelronMovrax: MarvonSelrikQervaxTorlin
    let pondexHavlinQermakStivor: URLRequest
    private var gemvikHarvonPelmarMonsix: ((_ navigationAction: PoltekHarvinSelmonKardex.NavigationAction) -> Void)?
    
    let orientationChanged = NotificationCenter.default
        .publisher(for: UIDevice.orientationDidChangeNotification)
        .makeConnectable()
        .autoconnect()
    
    init(dervekHolmarStalonQervin: URL, harlixVendumPelronMovrax: MarvonSelrikQervaxTorlin) {
        self.init(urlRequest: URLRequest(url: dervekHolmarStalonQervin), harlixVendumPelronMovrax: harlixVendumPelronMovrax)
    }
    
    private init(urlRequest: URLRequest, harlixVendumPelronMovrax: MarvonSelrikQervaxTorlin) {
        self.pondexHavlinQermakStivor = urlRequest
        self.harlixVendumPelronMovrax = harlixVendumPelronMovrax
    }
    
    var body: some View {
        
        ZStack{
            
            BolvikMelrakHarnekServon(harlixVendumPelronMovrax: harlixVendumPelronMovrax,
                            hartixPolvinMerlonSelrox: gemvikHarvonPelmarMonsix,
                            sarnikHelvaxDanrilFovken: pondexHavlinQermakStivor)
            
            ZStack {
                VStack{
                    HStack{
                        Button(action: {
                            harlixVendumPelronMovrax.galvinHervokPeltonQelrad = true
                            harlixVendumPelronMovrax.donvikHarvoxMelqinStralon?.removeFromSuperview()
                            harlixVendumPelronMovrax.donvikHarvoxMelqinStralon?.superview?.setNeedsLayout()
                            harlixVendumPelronMovrax.donvikHarvoxMelqinStralon?.superview?.layoutIfNeeded()
                            harlixVendumPelronMovrax.donvikHarvoxMelqinStralon = nil
                            harlixVendumPelronMovrax.harlikVextonSelmorDargex = false
                        }) {
                            Image(systemName: "chevron.backward.circle.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.white)
                        }
                        .padding(.leading, 20).padding(.top, 15)
                        
                        Spacer()
                    }
                    Spacer()
                }
            }
            .ignoresSafeArea()
        }
        .statusBarHidden(true)
        .onAppear {
            AppDelegate.orientationLock = UIInterfaceOrientationMask.all
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
            UINavigationController.attemptRotationToDeviceOrientation()
        }
    }
}

extension PoltekHarvinSelmonKardex {
    enum NavigationAction {
        case decidePolicy(WKNavigationAction, (WKNavigationActionPolicy) -> Void)
        case didRecieveAuthChallange(URLAuthenticationChallenge, (URLSession.AuthChallengeDisposition, URLCredential?) -> Void)
        case didStartProvisionalNavigation(WKNavigation)
        case didReceiveServerRedirectForProvisionalNavigation(WKNavigation)
        case didCommit(WKNavigation)
        case didFinish(WKNavigation)
        case didFailProvisionalNavigation(WKNavigation,Error)
        case didFail(WKNavigation,Error)
    }
}

struct BolvikMelrakHarnekServon : UIViewRepresentable {
    
    @ObservedObject var harlixVendumPelronMovrax: MarvonSelrikQervaxTorlin
    @State private var themeObservation: NSKeyValueObservation?
    let sarnikHelvaxDanrilFovken: URLRequest
    @State private var harvixPoldenMerlakStalor: WKWebView? = .init()
    
    init(harlixVendumPelronMovrax: MarvonSelrikQervaxTorlin,
         hartixPolvinMerlonSelrox: ((_ navigationAction: PoltekHarvinSelmonKardex.NavigationAction) -> Void)?,
         sarnikHelvaxDanrilFovken: URLRequest) {
        self.sarnikHelvaxDanrilFovken = sarnikHelvaxDanrilFovken
        self.harlixVendumPelronMovrax = harlixVendumPelronMovrax
        self.harvixPoldenMerlakStalor = WKWebView()
        self.harvixPoldenMerlakStalor?.backgroundColor = UIColor(red:0.11, green:0.13, blue:0.19, alpha:1)
        self.harvixPoldenMerlakStalor?.scrollView.backgroundColor = UIColor(red:0.11, green:0.13, blue:0.19, alpha:1)
        self.harvixPoldenMerlakStalor = WKWebView()
        
        self.harvixPoldenMerlakStalor?.isOpaque = false
        viewDidLoad()
    }
    
    func viewDidLoad() {
        
        self.harvixPoldenMerlakStalor?.backgroundColor = UIColor.black
        if #available(iOS 15.0, *) {
            themeObservation = harvixPoldenMerlakStalor?.observe(\.themeColor) { paldonHelrixSartovQalmer, _ in
                self.harvixPoldenMerlakStalor?.backgroundColor = paldonHelrixSartovQalmer.themeColor ?? .systemBackground
            }
        }
    }
    
    func makeUIView(context: Context) -> WKWebView  {
        var marvoxSelvikHavmonTirnel = WKWebView()
        let navrelHarvexQeltonGandor = WKPreferences()
        @ObservedObject var harlixVendumPelronMovrax: MarvonSelrikQervaxTorlin
        navrelHarvexQeltonGandor.javaScriptCanOpenWindowsAutomatically = true
        
        let qelvisVarjonHarvikMelrex = WKWebViewConfiguration()
        qelvisVarjonHarvikMelrex.allowsInlineMediaPlayback = true
        qelvisVarjonHarvikMelrex.preferences = navrelHarvexQeltonGandor
        qelvisVarjonHarvikMelrex.applicationNameForUserAgent = "Version/17.2 Mobile/15E148 Safari/604.1"
        marvoxSelvikHavmonTirnel = WKWebView(frame: .zero, configuration: qelvisVarjonHarvikMelrex)
        marvoxSelvikHavmonTirnel.configuration.defaultWebpagePreferences.allowsContentJavaScript = true
        marvoxSelvikHavmonTirnel.navigationDelegate = context.coordinator
        marvoxSelvikHavmonTirnel.uiDelegate = context.coordinator
        marvoxSelvikHavmonTirnel.load(sarnikHelvaxDanrilFovken)
        
        return marvoxSelvikHavmonTirnel
    }
    
    func updateUIView(_ santinKervoxHarnejMolvin: WKWebView, context: Context) {
        if santinKervoxHarnejMolvin.canGoBack, harlixVendumPelronMovrax.galvinHervokPeltonQelrad {
            santinKervoxHarnejMolvin.goBack()
            harlixVendumPelronMovrax.galvinHervokPeltonQelrad = false
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(stervonPelroxQanmirHelvik: self, harlonMendexSorvikJevran: nil, harlixVendumPelronMovrax: self.harlixVendumPelronMovrax)
    }
    
    final class Coordinator: NSObject {
        var donvikHarvoxMelqinStralon_2: WKWebView?
        var stervonPelroxQanmirHelvik: BolvikMelrakHarnekServon
        
        var harlixVendumPelronMovrax: MarvonSelrikQervaxTorlin
        let harlonMendexSorvikJevran: ((_ navigationAction: PoltekHarvinSelmonKardex.NavigationAction) -> Void)?
        
        init(stervonPelroxQanmirHelvik: BolvikMelrakHarnekServon, harlonMendexSorvikJevran: ((_ navigationAction: PoltekHarvinSelmonKardex.NavigationAction) -> Void)?, harlixVendumPelronMovrax: MarvonSelrikQervaxTorlin) {
            self.stervonPelroxQanmirHelvik = stervonPelroxQanmirHelvik
            self.harlonMendexSorvikJevran = harlonMendexSorvikJevran
            self.harlixVendumPelronMovrax = harlixVendumPelronMovrax
            super.init()
        }
    }
    
}

extension BolvikMelrakHarnekServon.Coordinator: WKNavigationDelegate, WKUIDelegate {
    
    func webView(_ mesvikPolrexHarvilTandor: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    func webView(_ mesvikPolrexHarvilTandor: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        let qolvikHenruxMelvonSertax = "var allLinks = document.getElementsByTagName('a');if (allLinks) { var i;for (i=0; i<allLinks.length; i++) {var link = allLinks[i];var target = link.getAttribute('target');if (target && target == '_blank') {link.setAttribute('target','_self');} } }"
        mesvikPolrexHarvilTandor.evaluateJavaScript(qolvikHenruxMelvonSertax, completionHandler: nil)
        if navigationAction.navigationType == WKNavigationType.linkActivated {
            mesvikPolrexHarvilTandor.load(navigationAction.request)
            decisionHandler(.cancel)
            return
        }
        
        if harlonMendexSorvikJevran == nil {
            decisionHandler(.allow)
        } else {
            harlonMendexSorvikJevran?(.decidePolicy(navigationAction, decisionHandler))
        }
    }
    
    func webView(_ mesvikPolrexHarvilTandor: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        harlonMendexSorvikJevran?(.didStartProvisionalNavigation(navigation))
    }
    
    func webView(_ mesvikPolrexHarvilTandor: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        harlonMendexSorvikJevran?(.didReceiveServerRedirectForProvisionalNavigation(navigation))
    }
    
    func webView(_ mesvikPolrexHarvilTandor: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        harlixVendumPelronMovrax.peldonSarvikMortenHelvar = mesvikPolrexHarvilTandor.canGoBack
        harlonMendexSorvikJevran?(.didFailProvisionalNavigation(navigation, error))
    }
    
    func webView(_ mesvikPolrexHarvilTandor: WKWebView, didCommit navigation: WKNavigation!) {
        harlonMendexSorvikJevran?(.didCommit(navigation))
    }
    
    func webView(_ mesvikPolrexHarvilTandor: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame?.isMainFrame != true {
            
            let donvikHarvoxMelqinStralon_2 = WKWebView(frame: mesvikPolrexHarvilTandor.bounds, configuration: configuration)
            donvikHarvoxMelqinStralon_2.navigationDelegate = self
            donvikHarvoxMelqinStralon_2.uiDelegate = self
            mesvikPolrexHarvilTandor.addSubview(donvikHarvoxMelqinStralon_2)
            mesvikPolrexHarvilTandor.setNeedsLayout()
            mesvikPolrexHarvilTandor.layoutIfNeeded()
            harlixVendumPelronMovrax.donvikHarvoxMelqinStralon = donvikHarvoxMelqinStralon_2
            harlixVendumPelronMovrax.harlikVextonSelmorDargex = true
            return donvikHarvoxMelqinStralon_2
        }
        return nil
    }
    
    func webView(_ mesvikPolrexHarvilTandor: WKWebView, didFinish navigation: WKNavigation!) {
        
        mesvikPolrexHarvilTandor.allowsBackForwardNavigationGestures = true
        harlixVendumPelronMovrax.peldonSarvikMortenHelvar = mesvikPolrexHarvilTandor.canGoBack
        
        mesvikPolrexHarvilTandor.configuration.mediaTypesRequiringUserActionForPlayback = .all
        mesvikPolrexHarvilTandor.configuration.allowsInlineMediaPlayback = false
        mesvikPolrexHarvilTandor.configuration.allowsAirPlayForMediaPlayback = false
        harlonMendexSorvikJevran?(.didFinish(navigation))
        
        guard mesvikPolrexHarvilTandor.url?.absoluteURL.absoluteString != nil else { return }
        
        if harlixVendumPelronMovrax.stravinHelroxJelvonGaltek == "meljarHarvixPolrekSentar" && self.harlixVendumPelronMovrax.strinorPelvakMaldexHarton_1 {
            self.harlixVendumPelronMovrax.stravinHelroxJelvonGaltek = mesvikPolrexHarvilTandor.url!.absoluteString
            self.harlixVendumPelronMovrax.strinorPelvakMaldexHarton_1 = false
        }
    }
    
    func webView(_ mesvikPolrexHarvilTandor: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        harlonMendexSorvikJevran?(.didFail(navigation, error))
    }
    
    func webView(_ mesvikPolrexHarvilTandor: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        if harlonMendexSorvikJevran == nil  {
            completionHandler(.performDefaultHandling, nil)
        } else {
            harlonMendexSorvikJevran?(.didRecieveAuthChallange(challenge, completionHandler))
        }
    }
    
    func webViewDidClose(_ mesvikPolrexHarvilTandor: WKWebView) {
        if mesvikPolrexHarvilTandor == donvikHarvoxMelqinStralon_2 {
            donvikHarvoxMelqinStralon_2?.removeFromSuperview()
            donvikHarvoxMelqinStralon_2 = nil
        }
    }
}

struct KPICard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    let isLoading: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: icon)
                        .foregroundColor(color)
                        .font(.title2)
                    
                    Spacer()
                    
                    if isLoading {
                        ProgressView()
                            .scaleEffect(0.8)
                    }
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text(value)
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(.primary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
        }
        .buttonStyle(PlainButtonStyle())
        .scaleEffect(isLoading ? 0.95 : 1.0)
        .animation(.easeInOut(duration: 0.2), value: isLoading)
    }
}

struct StatRow: View {
    let title: String
    let value: String
    let color: Color
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.primary)
            
            Spacer()
            
            Text(value)
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(color)
        }
    }
}

struct RevenueChartView: View {
    let data: [(String, Double)]
    let height: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let chartHeight = geometry.size.height - 40
            let padding: CGFloat = 20
            
            if data.isEmpty {
                Text("No data available")
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ZStack(alignment: .topLeading) {
                    ZStack {
                        chartGrid(width: width, height: chartHeight, padding: padding)
                        
                        chartArea(width: width, height: chartHeight, padding: padding)
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.green.opacity(0.2), Color.green.opacity(0.05)]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                        
                        chartLine(width: width, height: chartHeight, padding: padding)
                            .stroke(Color.green, style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
                    }
                    .frame(height: chartHeight)
                    
                    yAxisLabels(width: width, height: chartHeight, padding: padding)
                        .offset(x: 0, y: 0)
                    
                    xAxisLabels(width: width, height: chartHeight, padding: padding)
                        .offset(x: 0, y: chartHeight)
                }
            }
        }
        .frame(height: height)
    }
    
    private var minValue: Double {
        data.isEmpty ? 0 : max(0, (data.map { $0.1 }.min() ?? 0) * 0.9)
    }
    
    private var maxValue: Double {
        let values = data.map { $0.1 }
        guard let max = values.max(), let min = values.min() else { return 100 }
        let range = max - min
        return max + (range == 0 ? max * 0.1 : range * 0.1)
    }
    
    private func chartLine(width: CGFloat, height: CGFloat, padding: CGFloat) -> Path {
        var path = Path()
        guard !data.isEmpty else { return path }
        
        let chartWidth = width - padding * 2
        let chartHeight = height - padding * 2
        let valueRange = maxValue - minValue
        
        for (index, point) in data.enumerated() {
            let x = padding + (CGFloat(index) / CGFloat(max(data.count - 1, 1))) * chartWidth
            let normalizedValue = CGFloat((point.1 - minValue) / max(valueRange, 0.01))
            let y = padding + chartHeight - (normalizedValue * chartHeight)
            
            if index == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        
        return path
    }
    
    private func chartArea(width: CGFloat, height: CGFloat, padding: CGFloat) -> Path {
        var path = chartLine(width: width, height: height, padding: padding)
        guard !data.isEmpty else { return path }
        
        let chartWidth = width - padding * 2
        let chartHeight = height - padding * 2
        
        if let lastPoint = data.last {
            let lastX = padding + (CGFloat(data.count - 1) / CGFloat(max(data.count - 1, 1))) * chartWidth
            path.addLine(to: CGPoint(x: lastX, y: padding + chartHeight))
            path.addLine(to: CGPoint(x: padding, y: padding + chartHeight))
            path.closeSubpath()
        }
        
        return path
    }
    
    private func chartGrid(width: CGFloat, height: CGFloat, padding: CGFloat) -> some View {
        let chartWidth = width - padding * 2
        let chartHeight = height - padding * 2
        let gridLines = 5
        
        return ZStack {
            ForEach(0..<gridLines, id: \.self) { index in
                Path { path in
                    let y = padding + (CGFloat(index) / CGFloat(max(gridLines - 1, 1))) * chartHeight
                    path.move(to: CGPoint(x: padding, y: y))
                    path.addLine(to: CGPoint(x: width - padding, y: y))
                }
                .stroke(Color.gray.opacity(0.2), lineWidth: 0.5)
            }
            
            ForEach(0..<min(data.count, 6), id: \.self) { index in
                if index < data.count {
                    Path { path in
                        let x = padding + (CGFloat(index) / CGFloat(max(data.count - 1, 1))) * chartWidth
                        path.move(to: CGPoint(x: x, y: padding))
                        path.addLine(to: CGPoint(x: x, y: padding + chartHeight))
                    }
                    .stroke(Color.gray.opacity(0.2), lineWidth: 0.5)
                }
            }
        }
    }
    
    private func yAxisLabels(width: CGFloat, height: CGFloat, padding: CGFloat) -> some View {
        let chartHeight = height - padding * 2
        let numberOfLabels = 5
        
        return VStack {
            ForEach(0..<numberOfLabels, id: \.self) { index in
                let value = maxValue - (maxValue - minValue) * (Double(index) / Double(max(numberOfLabels - 1, 1)))
                Text(formatCurrency(value))
                    .font(.system(size: 9))
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            Spacer()
        }
        .padding(.leading, 4)
        .frame(width: padding - 4)
    }
    
    private func xAxisLabels(width: CGFloat, height: CGFloat, padding: CGFloat) -> some View {
        let chartWidth = width - padding * 2
        let numberOfLabels = min(data.count, 6)
        let step = data.count > 1 ? CGFloat(data.count - 1) / CGFloat(max(numberOfLabels - 1, 1)) : 1
        
        return GeometryReader { geo in
            ZStack(alignment: .topLeading) {
                ForEach(0..<numberOfLabels, id: \.self) { labelIndex in
                    let dataIndex = Int(CGFloat(labelIndex) * step)
                    if dataIndex < data.count {
                        let xPosition = padding + (CGFloat(dataIndex) / CGFloat(max(data.count - 1, 1))) * chartWidth
                        Text(data[dataIndex].0)
                            .font(.system(size: 9))
                            .foregroundColor(.secondary)
                            .offset(x: xPosition, y: 0)
                    }
                }
            }
        }
        .frame(height: 40)
    }
    
    private func formatCurrency(_ amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(value: amount)) ?? "0"
    }
}

struct RefreshableScrollView<Content: View>: UIViewRepresentable {
    let isRefreshing: Bool
    let onRefresh: () -> Void
    let content: Content
    
    init(isRefreshing: Bool, onRefresh: @escaping () -> Void, @ViewBuilder content: () -> Content) {
        self.isRefreshing = isRefreshing
        self.onRefresh = onRefresh
        self.content = content()
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.refreshControl = UIRefreshControl()
        scrollView.refreshControl?.addTarget(context.coordinator, action: #selector(Coordinator.handleRefresh), for: .valueChanged)
        
        let hostingController = UIHostingController(rootView: content)
        hostingController.view.backgroundColor = .clear
        scrollView.addSubview(hostingController.view)
        
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        
        let heightConstraint = hostingController.view.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        heightConstraint.priority = UILayoutPriority(250)
        
        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            hostingController.view.topAnchor.constraint(equalTo: scrollView.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            hostingController.view.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            heightConstraint
        ])
        
        context.coordinator.hostingController = hostingController
        context.coordinator.scrollView = scrollView
        context.coordinator.onRefresh = onRefresh
        context.coordinator.updateContentSize()
        
        return scrollView
    }
    
    func updateUIView(_ scrollView: UIScrollView, context: Context) {
        context.coordinator.hostingController?.rootView = content
        context.coordinator.updateContentSize()
        
        DispatchQueue.main.async {
            if isRefreshing {
                scrollView.refreshControl?.beginRefreshing()
            } else {
                scrollView.refreshControl?.endRefreshing()
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject {
        var hostingController: UIHostingController<Content>?
        var scrollView: UIScrollView?
        var onRefresh: (() -> Void)?
        
        func updateContentSize() {
            DispatchQueue.main.async {
                guard let hostingView = self.hostingController?.view,
                      let scrollView = self.scrollView else { return }
                
                hostingView.setNeedsLayout()
                hostingView.layoutIfNeeded()
                
                let contentSize = hostingView.systemLayoutSizeFitting(
                    CGSize(width: scrollView.bounds.width, height: UIView.layoutFittingExpandedSize.height),
                    withHorizontalFittingPriority: .required,
                    verticalFittingPriority: .fittingSizeLevel
                )
                
                scrollView.contentSize = CGSize(width: scrollView.bounds.width, height: max(contentSize.height, scrollView.bounds.height))
            }
        }
        
        @objc func handleRefresh(sender: UIRefreshControl) {
            onRefresh?()
        }
    }
}

#Preview {
    StatsScreen()
}
