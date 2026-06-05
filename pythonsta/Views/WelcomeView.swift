//
//  WelcomeView.swift
//  pythonsta
//
//  Created by 茂木史明 on 2026/06/05.
//

import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [.primaryPurple, .deepPurple],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            // Decorative floating symbols
            DecorativeSymbols()

            // Main content
            VStack(spacing: 0) {
                Spacer()

                MascotPlaceholder(size: 200)
                    .padding(.bottom, 32)

                Text("PythonSta")
                    .font(AppFonts.largeTitle)
                    .foregroundColor(.white)

                Text("楽しく学んで、未来をコードしよう！")
                    .font(AppFonts.body)
                    .foregroundColor(.white.opacity(0.85))
                    .multilineTextAlignment(.center)
                    .padding(.top, 8)

                Spacer()

                VStack(spacing: 16) {
                    PillButton(title: "はじめる！", color: .pythonLime) {
                        appState.navigate(to: .home)
                    }

                    Button("すでにアカウントをお持ちの方はこちら") {
                        appState.navigate(to: .home)
                    }
                    .font(AppFonts.caption)
                    .foregroundColor(.white.opacity(0.7))
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
            }
        }
    }
}

// MARK: - Decorative background symbols

private struct DecorativeSymbols: View {
    var body: some View {
        ZStack {
            Text("</>")
                .font(.system(size: 48, weight: .bold, design: .monospaced))
                .foregroundColor(.white.opacity(0.12))
                .offset(x: -110, y: -180)
                .rotationEffect(.degrees(-15))

            Text("{}")
                .font(.system(size: 56, weight: .bold, design: .monospaced))
                .foregroundColor(.white.opacity(0.10))
                .offset(x: 120, y: -120)
                .rotationEffect(.degrees(20))

            Text("( )")
                .font(.system(size: 36, weight: .bold, design: .monospaced))
                .foregroundColor(.white.opacity(0.08))
                .offset(x: -130, y: 60)
                .rotationEffect(.degrees(10))

            Text("[]")
                .font(.system(size: 44, weight: .bold, design: .monospaced))
                .foregroundColor(.white.opacity(0.10))
                .offset(x: 130, y: 100)
                .rotationEffect(.degrees(-10))

            Text("#")
                .font(.system(size: 40, weight: .bold, design: .monospaced))
                .foregroundColor(.white.opacity(0.08))
                .offset(x: 80, y: 200)
                .rotationEffect(.degrees(5))
        }
    }
}

#Preview {
    WelcomeView()
        .environmentObject(AppState())
}
