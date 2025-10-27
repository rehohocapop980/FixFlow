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
        static let largeTitle = Font.system(.largeTitle, design: .default, weight: .black)
        static let title = Font.system(.title, design: .default, weight: .bold)
        static let title2 = Font.system(.title2, design: .default, weight: .bold)
        static let title3 = Font.system(.title3, design: .default, weight: .bold)
        static let headline = Font.system(.headline, design: .default, weight: .bold)
        
        static let body = Font.system(.body, design: .default, weight: .regular)
        static let callout = Font.system(.callout, design: .default, weight: .medium)
        static let caption = Font.system(.caption, design: .default, weight: .regular)
        static let caption2 = Font.system(.caption2, design: .default, weight: .regular)
        
        static let navigationTitle = Font.system(.title2, design: .default, weight: .black)
        static let cardTitle = Font.system(.headline, design: .default, weight: .bold)
        static let cardSubtitle = Font.system(.callout, design: .default, weight: .medium)
        static let buttonText = Font.system(.headline, design: .default, weight: .bold)
        
        static let gameTitle = Font.system(.largeTitle, design: .default, weight: .black)
        static let multiplierText = Font.system(.title3, design: .default, weight: .bold)
        static let scoreText = Font.system(.title2, design: .default, weight: .black)
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
        )
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
            .font(FixFlowTheme.Typography.callout)
            .fontWeight(.bold)
            .foregroundColor(isActive ? .black : .white)
            .padding(.horizontal, FixFlowTheme.Spacing.lg)
            .padding(.vertical, FixFlowTheme.Spacing.sm)
            .background(
                Capsule()
                    .fill(isActive ? AnyShapeStyle(FixFlowTheme.Colors.goldGradient) : AnyShapeStyle(FixFlowTheme.Colors.surfaceDark))
                    .overlay(
                        Capsule()
                            .stroke(isActive ? Color.white.opacity(0.3) : FixFlowTheme.Colors.border.opacity(0.5), lineWidth: 1)
                    )
                    .shadow(
                        color: isActive ? FixFlowTheme.Colors.yellow.opacity(0.4) : Color.clear,
                        radius: 6,
                        x: 0,
                        y: 3
                    )
            )
            .scaleEffect(isActive ? 1.05 : 1.0)
            .animation(FixFlowTheme.Animation.spring, value: isActive)
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
