//
//  SplashView.swift
//  pythonsta
//
//  Created by 茂木史明 on 2026/06/05.
//

import SwiftUI

struct SplashView: View {
    @EnvironmentObject var appState: AppState

    @State private var logoVisible  = false
    @State private var logoScale: CGFloat = 0.70
    @State private var taglineVisible = false

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(hex: "#5C44F5"), Color(hex: "#4026D9")],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            // Subtle radial glow at top — matches WelcomeView
            GeometryReader { geo in
                RadialGradient(
                    colors: [Color.white.opacity(0.08), Color.clear],
                    center: .top,
                    startRadius: 0,
                    endRadius: geo.size.height * 0.55
                )
                .ignoresSafeArea()
            }

            VStack(spacing: 14) {
                // Snake badge
                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.14))
                        .frame(width: 88, height: 88)
                    Text("🐍")
                        .font(.system(size: 46))
                }
                .scaleEffect(logoScale)
                .opacity(logoVisible ? 1 : 0)

                // App name
                Text("PythonSta")
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .opacity(logoVisible ? 1 : 0)
                    .offset(y: logoVisible ? 0 : 10)

                // Tagline
                Text("楽しく学んで、未来をコードしよう")
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundColor(.white.opacity(0.72))
                    .opacity(taglineVisible ? 1 : 0)
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.55, dampingFraction: 0.68)) {
                logoVisible = true
                logoScale   = 1.0
            }
            withAnimation(.easeOut(duration: 0.4).delay(0.30)) {
                taglineVisible = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                guard appState.currentScreen == .splash else { return }
                appState.navigate(to: .welcome)
            }
        }
    }
}

#Preview {
    SplashView()
        .environmentObject(AppState())
}
