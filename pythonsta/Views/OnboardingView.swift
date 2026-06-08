//
//  OnboardingView.swift
//  pythonsta
//
//  Created by 茂木史明 on 2026/06/05.
//
//  Two-step onboarding shown once to first-time users (between WelcomeView and HomeView).
//  Step A — Learning purpose: one of four reasons, required before advancing.
//  Step B — Daily goal confirmation: explains 10問/日 is a soft target, not a cap.
//
//  On finish, calls AppState.completeOnboarding(learningPurpose:dailyGoal:),
//  which persists both values and navigates to Home.
//

import SwiftUI

// MARK: - Root

struct OnboardingView: View {
    @EnvironmentObject var appState: AppState

    @State private var step             = 0
    @State private var selectedPurpose: String? = nil

    var body: some View {
        ZStack {
            if step == 0 {
                PurposeStep(
                    selectedPurpose: $selectedPurpose,
                    onNext: { withAnimation(.easeInOut(duration: 0.38)) { step = 1 } }
                )
                .transition(.asymmetric(
                    insertion: .opacity,
                    removal: .move(edge: .leading).combined(with: .opacity)
                ))
            } else {
                GoalStep(onComplete: {
                    appState.completeOnboarding(
                        learningPurpose: selectedPurpose ?? "",
                        dailyGoal: 10
                    )
                })
                .transition(.asymmetric(
                    insertion: .move(edge: .trailing).combined(with: .opacity),
                    removal: .opacity
                ))
            }
        }
        .animation(.easeInOut(duration: 0.38), value: step)
    }
}

// MARK: - Step A: Learning Purpose

private struct PurposeStep: View {
    @Binding var selectedPurpose: String?
    let onNext: () -> Void

    @State private var appeared = false

    private struct Purpose {
        let label: String
        let icon: String
        let color: Color
    }

    private let options: [Purpose] = [
        Purpose(label: "仕事で使いたい",    icon: "briefcase.fill",   color: .primaryPurple),
        Purpose(label: "副業・自動化したい", icon: "gearshape.2.fill", color: .snakeGreen),
        Purpose(label: "AI開発をしたい",   icon: "cpu.fill",          color: .appTeal),
        Purpose(label: "基礎から学びたい",  icon: "book.fill",         color: Color(hex: "#FF8C42")),
    ]

    var body: some View {
        GeometryReader { geo in
            ZStack {
                LinearGradient(
                    colors: [Color(hex: "#5C44F5"), Color(hex: "#4026D9")],
                    startPoint: .top, endPoint: .bottom
                )
                .ignoresSafeArea()

                RadialGradient(
                    colors: [Color.white.opacity(0.07), Color.clear],
                    center: .top, startRadius: 0,
                    endRadius: geo.size.height * 0.5
                )
                .ignoresSafeArea()

                VStack(spacing: 0) {
                    OnboardingDots(current: 0, total: 2, dotColor: .white)
                        .padding(.top, 20)

                    Spacer()

                    // Header
                    VStack(spacing: 10) {
                        Text("なぜPythonを\n学びますか？")
                            .font(.system(size: 28, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .lineSpacing(3)

                        Text("あなたの目的に合わせてサポートします")
                            .font(.system(size: 14, weight: .regular, design: .rounded))
                            .foregroundColor(.white.opacity(0.78))
                    }
                    .opacity(appeared ? 1 : 0)
                    .offset(y: appeared ? 0 : 14)
                    .animation(.easeOut(duration: 0.45), value: appeared)

                    Spacer()

                    // Purpose options
                    VStack(spacing: 12) {
                        ForEach(options, id: \.label) { option in
                            PurposeCard(
                                label: option.label,
                                icon: option.icon,
                                accentColor: option.color,
                                isSelected: selectedPurpose == option.label,
                                onTap: { selectedPurpose = option.label }
                            )
                        }
                    }
                    .padding(.horizontal, 24)
                    .opacity(appeared ? 1 : 0)
                    .offset(y: appeared ? 0 : 10)
                    .animation(.easeOut(duration: 0.5).delay(0.10), value: appeared)

                    Spacer()

                    // Next button — disabled until a purpose is selected
                    let isReady = selectedPurpose != nil
                    Button(action: onNext) {
                        HStack(spacing: 6) {
                            Text("次へ")
                            Image(systemName: "arrow.right")
                        }
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundColor(isReady ? Color(hex: "#1D2433") : Color.white.opacity(0.45))
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .background(isReady ? Color(hex: "#B9F238") : Color.white.opacity(0.14))
                        .clipShape(Capsule())
                        .shadow(
                            color: isReady ? Color(hex: "#B9F238").opacity(0.40) : .clear,
                            radius: 14, x: 0, y: 6
                        )
                        .animation(.easeInOut(duration: 0.2), value: isReady)
                    }
                    .disabled(!isReady)
                    .frame(width: geo.size.width * 0.80)
                    .opacity(appeared ? 1 : 0)
                    .animation(.easeOut(duration: 0.4).delay(0.22), value: appeared)

                    Spacer().frame(height: 52)
                }
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.5)) { appeared = true }
        }
    }
}

// MARK: - Purpose Card

private struct PurposeCard: View {
    let label: String
    let icon: String
    let accentColor: Color
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 14) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(isSelected ? accentColor.opacity(0.14) : Color.white.opacity(0.18))
                        .frame(width: 46, height: 46)
                    Image(systemName: icon)
                        .font(.system(size: 19, weight: .semibold))
                        .foregroundColor(isSelected ? accentColor : .white)
                }

                Text(label)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundColor(isSelected ? .textDark : .white)

                Spacer(minLength: 8)

                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.snakeGreen)
                        .transition(.scale.combined(with: .opacity))
                }
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 16)
            .background(isSelected ? Color.white : Color.white.opacity(0.12))
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(
                        isSelected ? Color.clear : Color.white.opacity(0.20),
                        lineWidth: 1
                    )
            )
            .shadow(
                color: isSelected ? .black.opacity(0.10) : .clear,
                radius: 8, x: 0, y: 3
            )
        }
        .buttonStyle(PlainButtonStyle())
        .animation(.easeInOut(duration: 0.18), value: isSelected)
    }
}

// MARK: - Step B: Goal Confirmation

private struct GoalStep: View {
    let onComplete: () -> Void

    @State private var appeared = false

    private let bullets: [(icon: String, color: Color, text: String)] = [
        ("arrow.up.right.circle.fill", .primaryPurple, "10問はあくまで目標。それ以上続けてもOK"),
        ("flame.fill",                  Color(hex: "#FF8C42"), "毎日目標を達成すると連続記録が伸びます"),
        ("gearshape.fill",              .textGray,             "設定からいつでも変更できます"),
    ]

    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    OnboardingDots(current: 1, total: 2, dotColor: .primaryPurple)
                        .padding(.top, 24)

                    Spacer().frame(height: 36)

                    // Header
                    VStack(spacing: 8) {
                        Text("1日の学習目標")
                            .font(.system(size: 26, weight: .bold, design: .rounded))
                            .foregroundColor(.textDark)
                            .multilineTextAlignment(.center)

                        Text("毎日コツコツ続けることが上達の近道です")
                            .font(.system(size: 14, weight: .regular, design: .rounded))
                            .foregroundColor(.textGray)
                            .multilineTextAlignment(.center)
                    }
                    .opacity(appeared ? 1 : 0)
                    .offset(y: appeared ? 0 : 10)
                    .animation(.easeOut(duration: 0.45), value: appeared)

                    Spacer().frame(height: 28)

                    // Goal card
                    FloatingCard {
                        HStack(spacing: 0) {
                            // Left: 10問
                            VStack(spacing: 4) {
                                HStack(alignment: .lastTextBaseline, spacing: 3) {
                                    Text("10")
                                        .font(.system(size: 52, weight: .bold, design: .rounded))
                                        .foregroundColor(.primaryPurple)
                                    Text("問")
                                        .font(.system(size: 22, weight: .bold, design: .rounded))
                                        .foregroundColor(.primaryPurple)
                                }
                                Text("1日の目標")
                                    .font(.system(size: 12, weight: .regular, design: .rounded))
                                    .foregroundColor(.textGray)
                            }
                            .frame(maxWidth: .infinity)

                            Rectangle()
                                .fill(Color.appBackground)
                                .frame(width: 1, height: 64)

                            // Right: time estimate
                            VStack(spacing: 6) {
                                Text("≈ 10分")
                                    .font(.system(size: 22, weight: .bold, design: .rounded))
                                    .foregroundColor(.textDark)
                                Text("1レッスン分")
                                    .font(.system(size: 12, weight: .regular, design: .rounded))
                                    .foregroundColor(.textGray)
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .padding(.vertical, 26)
                    }
                    .padding(.horizontal, 24)
                    .opacity(appeared ? 1 : 0)
                    .animation(.easeOut(duration: 0.45).delay(0.1), value: appeared)

                    Spacer().frame(height: 28)

                    // Explanation bullets
                    VStack(spacing: 0) {
                        ForEach(bullets, id: \.text) { bullet in
                            GoalBulletRow(icon: bullet.icon, iconColor: bullet.color, text: bullet.text)
                        }
                    }
                    .padding(.horizontal, 24)
                    .opacity(appeared ? 1 : 0)
                    .animation(.easeOut(duration: 0.45).delay(0.18), value: appeared)

                    Spacer().frame(height: 40)

                    // CTA
                    Button(action: onComplete) {
                        Text("スタートしよう！")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .foregroundColor(Color(hex: "#1D2433"))
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                            .background(Color(hex: "#B9F238"))
                            .clipShape(Capsule())
                            .shadow(color: Color(hex: "#B9F238").opacity(0.40), radius: 14, x: 0, y: 6)
                    }
                    .padding(.horizontal, 24)
                    .opacity(appeared ? 1 : 0)
                    .animation(.easeOut(duration: 0.4).delay(0.28), value: appeared)

                    Spacer().frame(height: 52)
                }
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.5)) { appeared = true }
        }
    }
}

// MARK: - Goal Bullet Row

private struct GoalBulletRow: View {
    let icon: String
    let iconColor: Color
    let text: String

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(iconColor)
                .frame(width: 26)
            Text(text)
                .font(.system(size: 14, weight: .regular, design: .rounded))
                .foregroundColor(.textDark)
                .fixedSize(horizontal: false, vertical: true)
            Spacer()
        }
        .padding(.vertical, 14)
        .overlay(Rectangle().fill(Color.appBackground).frame(height: 1), alignment: .bottom)
    }
}

// MARK: - Shared: Step Dots

private struct OnboardingDots: View {
    let current: Int
    let total: Int
    let dotColor: Color

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<total, id: \.self) { i in
                Capsule()
                    .fill(i == current ? dotColor : dotColor.opacity(0.30))
                    .frame(width: i == current ? 24 : 8, height: 8)
                    .animation(.easeInOut(duration: 0.25), value: current)
            }
        }
    }
}

#Preview {
    OnboardingView()
        .environmentObject(AppState())
}
