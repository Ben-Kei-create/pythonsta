//
//  OnboardingView.swift
//  pythonsta
//
//  Created by 茂木史明 on 2026/06/05.
//
//  Two-step onboarding shown once to first-time users (after WelcomeView).
//  Step 0 — Intro:   app value proposition on the purple gradient.
//  Step 1 — Goal:    daily question target selection (5/10/15/20).
//
//  On completion, calls AppState.completeOnboarding(dailyGoal:) which
//  persists the goal, marks hasCompletedOnboarding = true, and navigates to Home.
//

import SwiftUI

// MARK: - OnboardingView

struct OnboardingView: View {
    @EnvironmentObject var appState: AppState

    @State private var step = 0
    @State private var selectedGoal = 10

    var body: some View {
        ZStack {
            if step == 0 {
                OnboardingIntroPage(onNext: {
                    withAnimation(.easeInOut(duration: 0.38)) { step = 1 }
                })
                .transition(.asymmetric(
                    insertion: .opacity,
                    removal: .move(edge: .leading).combined(with: .opacity)
                ))
            } else {
                OnboardingGoalPage(
                    selectedGoal: $selectedGoal,
                    onComplete: { appState.completeOnboarding(dailyGoal: selectedGoal) }
                )
                .transition(.asymmetric(
                    insertion: .move(edge: .trailing).combined(with: .opacity),
                    removal: .opacity
                ))
            }
        }
        .animation(.easeInOut(duration: 0.38), value: step)
    }
}

// MARK: - Step 0: Intro

private struct OnboardingIntroPage: View {
    let onNext: () -> Void

    @State private var appeared = false

    var body: some View {
        GeometryReader { geo in
            ZStack {
                LinearGradient(
                    colors: [Color(hex: "#5C44F5"), Color(hex: "#4026D9")],
                    startPoint: .top, endPoint: .bottom
                )
                .ignoresSafeArea()

                RadialGradient(
                    colors: [Color.white.opacity(0.08), Color.clear],
                    center: .top, startRadius: 0,
                    endRadius: geo.size.height * 0.5
                )
                .ignoresSafeArea()

                VStack(spacing: 0) {
                    // Step indicator
                    StepDots(current: 0, total: 2)
                        .padding(.top, 20)

                    Spacer()

                    // Hero area
                    VStack(spacing: 14) {
                        Text("🐍")
                            .font(.system(size: 52))

                        Text("PythonStaへ\nようこそ！")
                            .font(.system(size: 30, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .lineSpacing(3)

                        Text("ゲーム感覚でPythonをマスターしよう")
                            .font(.system(size: 15, weight: .regular, design: .rounded))
                            .foregroundColor(.white.opacity(0.82))
                            .multilineTextAlignment(.center)
                    }
                    .opacity(appeared ? 1 : 0)
                    .offset(y: appeared ? 0 : 16)

                    Spacer()

                    // Feature list
                    VStack(spacing: 10) {
                        FeaturePill(icon: "gamecontroller.fill",         text: "クイズ形式で楽しく学習")
                        FeaturePill(icon: "chart.line.uptrend.xyaxis",   text: "XPとレベルで成長を実感")
                        FeaturePill(icon: "flame.fill",                  text: "毎日の連続記録でモチベUP")
                    }
                    .opacity(appeared ? 1 : 0)
                    .offset(y: appeared ? 0 : 10)
                    .animation(.easeOut(duration: 0.5).delay(0.15), value: appeared)

                    Spacer()

                    // CTA
                    Button(action: onNext) {
                        HStack(spacing: 6) {
                            Text("次へ")
                            Image(systemName: "arrow.right")
                        }
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundColor(Color(hex: "#1D2433"))
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .background(Color(hex: "#B9F238"))
                        .clipShape(Capsule())
                        .shadow(color: Color(hex: "#B9F238").opacity(0.40), radius: 14, x: 0, y: 6)
                    }
                    .frame(width: geo.size.width * 0.80)
                    .opacity(appeared ? 1 : 0)
                    .animation(.easeOut(duration: 0.4).delay(0.3), value: appeared)

                    Spacer().frame(height: 52)
                }
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.5)) { appeared = true }
        }
    }
}

// MARK: - Step 1: Goal Selection

private struct OnboardingGoalPage: View {
    @Binding var selectedGoal: Int
    let onComplete: () -> Void

    private let goals: [(questions: Int, label: String, minutes: String, recommended: Bool)] = [
        (5,  "入門",   "約5分/日",  false),
        (10, "標準",   "約10分/日", true),
        (15, "本気",   "約15分/日", false),
        (20, "超集中", "約20分/日", false),
    ]

    private let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    StepDots(current: 1, total: 2)
                        .padding(.top, 24)

                    // Header
                    VStack(spacing: 8) {
                        Text("1日の目標を決めよう")
                            .font(.system(size: 26, weight: .bold, design: .rounded))
                            .foregroundColor(.textDark)
                            .multilineTextAlignment(.center)

                        Text("いつでも設定から変更できます")
                            .font(.system(size: 14, weight: .regular, design: .rounded))
                            .foregroundColor(.textGray)
                    }

                    // Goal cards
                    LazyVGrid(columns: columns, spacing: 12) {
                        ForEach(goals, id: \.questions) { goal in
                            GoalCard(
                                questions: goal.questions,
                                label: goal.label,
                                minutes: goal.minutes,
                                recommended: goal.recommended,
                                isSelected: selectedGoal == goal.questions,
                                onTap: { selectedGoal = goal.questions }
                            )
                        }
                    }
                    .padding(.horizontal, 20)

                    // Streak note
                    HStack(spacing: 6) {
                        Image(systemName: "flame.fill")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(Color(hex: "#FF8C42"))
                        Text("目標を達成すると連続記録が伸びます")
                            .font(.system(size: 13, weight: .regular, design: .rounded))
                            .foregroundColor(.textGray)
                    }
                    .padding(.horizontal, 20)

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
                    .padding(.horizontal, 20)

                    Spacer().frame(height: 40)
                }
            }
        }
    }
}

// MARK: - Goal Card

private struct GoalCard: View {
    let questions: Int
    let label: String
    let minutes: String
    let recommended: Bool
    let isSelected: Bool
    let onTap: () -> Void

    private let icons: [Int: String] = [
        5: "leaf.fill", 10: "book.fill", 15: "flame.fill", 20: "bolt.fill"
    ]
    private let iconColors: [Int: Color] = [
        5: .snakeGreen, 10: .primaryPurple, 15: Color(hex: "#FF8C42"), 20: .warmYellow
    ]

    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 10) {
                // Recommended badge
                if recommended {
                    Text("おすすめ")
                        .font(.system(size: 10, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .padding(.horizontal, 9)
                        .padding(.vertical, 3)
                        .background(Color.primaryPurple)
                        .clipShape(Capsule())
                } else {
                    Spacer().frame(height: 20) // maintain alignment
                }

                // Icon
                ZStack {
                    Circle()
                        .fill(isSelected
                              ? Color.primaryPurple.opacity(0.15)
                              : (iconColors[questions] ?? .textGray).opacity(0.10))
                        .frame(width: 52, height: 52)
                    Image(systemName: icons[questions] ?? "star.fill")
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundColor(isSelected
                                         ? .primaryPurple
                                         : (iconColors[questions] ?? .textGray))
                }

                // Questions
                Text("\(questions)問/日")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(isSelected ? .primaryPurple : .textDark)

                // Label
                Text(label)
                    .font(.system(size: 13, weight: .semibold, design: .rounded))
                    .foregroundColor(isSelected ? .primaryPurple : .textGray)

                // Minutes
                Text(minutes)
                    .font(.system(size: 11, weight: .regular, design: .rounded))
                    .foregroundColor(.textGray)
            }
            .padding(.vertical, 18)
            .padding(.horizontal, 8)
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(18)
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .strokeBorder(
                        isSelected ? Color.primaryPurple : Color.clear,
                        lineWidth: 2
                    )
            )
            .shadow(
                color: isSelected
                    ? Color.primaryPurple.opacity(0.18)
                    : Color.black.opacity(0.05),
                radius: isSelected ? 10 : 6,
                x: 0, y: 3
            )
        }
        .buttonStyle(PlainButtonStyle())
        .animation(.easeInOut(duration: 0.18), value: isSelected)
    }
}

// MARK: - Shared helpers

private struct StepDots: View {
    let current: Int
    let total: Int

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<total, id: \.self) { i in
                Capsule()
                    .fill(i == current ? Color.white : Color.white.opacity(0.30))
                    .frame(width: i == current ? 24 : 8, height: 8)
                    .animation(.easeInOut(duration: 0.25), value: current)
            }
        }
    }
}

private struct FeaturePill: View {
    let icon: String
    let text: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(.pythonLime)
                .frame(width: 24)
            Text(text)
                .font(.system(size: 14, weight: .medium, design: .rounded))
                .foregroundColor(.white.opacity(0.92))
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 13)
        .background(Color.white.opacity(0.10))
        .cornerRadius(14)
        .padding(.horizontal, 28)
    }
}

#Preview {
    OnboardingView()
        .environmentObject(AppState())
}
