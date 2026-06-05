//
//  WelcomeView.swift
//  pythonsta
//
//  Created by 茂木史明 on 2026/06/05.
//

import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var appState: AppState

    @State private var appeared   = false
    @State private var mascotFloat = false

    var body: some View {
        GeometryReader { geo in
            ZStack {
                // ── Background ──────────────────────────────────────────
                LinearGradient(
                    colors: [Color(hex: "#5C44F5"), Color(hex: "#4026D9")],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                // Subtle inner glow at top
                RadialGradient(
                    colors: [Color.white.opacity(0.08), Color.clear],
                    center: .top,
                    startRadius: 0,
                    endRadius: geo.size.height * 0.55
                )
                .ignoresSafeArea()

                // ── Main layout ──────────────────────────────────────────
                VStack(spacing: 0) {

                    // Logo area
                    LogoArea()
                        .padding(.top, 20)
                        .opacity(appeared ? 1 : 0)
                        .offset(y: appeared ? 0 : -10)
                        .animation(.easeOut(duration: 0.5).delay(0.1), value: appeared)

                    Spacer()

                    // Hero — ~35 % of screen height, floating
                    MascotPlaceholder(size: geo.size.height * 0.35)
                        .offset(y: mascotFloat ? -8 : 8)
                        .animation(
                            .easeInOut(duration: 2.2).repeatForever(autoreverses: true),
                            value: mascotFloat
                        )
                        .opacity(appeared ? 1 : 0)
                        .scaleEffect(appeared ? 1 : 0.88)
                        .animation(.spring(response: 0.6, dampingFraction: 0.7).delay(0.2), value: appeared)

                    Spacer()

                    // Headline
                    Text("Pythonを\nもっと楽しく。")
                        .font(.system(size: 34, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                        .opacity(appeared ? 1 : 0)
                        .offset(y: appeared ? 0 : 12)
                        .animation(.easeOut(duration: 0.5).delay(0.35), value: appeared)

                    // Description
                    Text("ゲーム感覚で学べる\n新しいPython学習アプリ")
                        .font(.system(size: 15, weight: .regular, design: .rounded))
                        .foregroundColor(.white.opacity(0.85))
                        .multilineTextAlignment(.center)
                        .lineSpacing(3)
                        .padding(.top, 12)
                        .opacity(appeared ? 1 : 0)
                        .offset(y: appeared ? 0 : 10)
                        .animation(.easeOut(duration: 0.5).delay(0.45), value: appeared)

                    Spacer()

                    // Primary CTA
                    Button {
                        appState.navigate(to: .home)
                    } label: {
                        Text("はじめる")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .foregroundColor(Color(hex: "#1D2433"))
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                            .background(Color(hex: "#B9F238"))
                            .clipShape(Capsule())
                            .shadow(color: Color(hex: "#B9F238").opacity(0.45), radius: 16, x: 0, y: 8)
                    }
                    .frame(width: geo.size.width * 0.80)
                    .opacity(appeared ? 1 : 0)
                    .scaleEffect(appeared ? 1 : 0.94)
                    .animation(.spring(response: 0.5, dampingFraction: 0.75).delay(0.55), value: appeared)

                    // Secondary CTA
                    Button("ログイン") {
                        appState.navigate(to: .home)
                    }
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                    .foregroundColor(.white.opacity(0.90))
                    .padding(.top, 20)
                    .opacity(appeared ? 1 : 0)
                    .animation(.easeOut(duration: 0.4).delay(0.65), value: appeared)

                    Spacer().frame(height: 52)
                }
            }
        }
        .onAppear {
            appeared     = true
            mascotFloat  = true
        }
    }
}

// MARK: - Logo area

private struct LogoArea: View {
    var body: some View {
        VStack(spacing: 6) {
            // Small mascot badge near logo
            ZStack {
                Circle()
                    .fill(Color.white.opacity(0.12))
                    .frame(width: 44, height: 44)
                Text("🐍")
                    .font(.system(size: 22))
            }

            Text("PythonSta")
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundColor(.white)
        }
    }
}

#Preview {
    WelcomeView()
        .environmentObject(AppState())
}
