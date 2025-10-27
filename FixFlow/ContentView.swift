
import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            FixFlowTheme.Colors.purpleBackground
                .ignoresSafeArea()
            
            VStack(spacing: FixFlowTheme.Spacing.xxl) {
                Text("FIXFLOW")
                    .font(FixFlowTheme.Typography.gameTitle)
                    .foregroundColor(.white)
                    .fixFlowGlowEffect(color: FixFlowTheme.Colors.yellow)
                
                Text("Auto Service Management System")
                    .font(FixFlowTheme.Typography.headline)
                    .foregroundColor(FixFlowTheme.Colors.textSecondary)
                
                VStack(spacing: FixFlowTheme.Spacing.lg) {
                    Button("Start Work") {
                    }
                    .fixFlowPrimaryButtonStyle()
                    
                    Button("Settings") {
                    }
                    .fixFlowSecondaryButtonStyle()
                    
                    Text("1.5x")
                        .fixFlowMultiplierStyle()
                    
                    Text("10,000")
                        .fixFlowScoreStyle()
                }
                .padding(.horizontal, FixFlowTheme.Spacing.xxl)
            }
        }
    }
}

#Preview {
    ContentView()
}
