//
//  ResultView.swift
//  pythonsta
//
//  Created by 茂木史明 on 2026/06/05.
//

import SwiftUI

struct ResultView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [.appTeal, .snakeGreen],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            // Confetti
            ConfettiLayer()

            // Content
            VStack(spacing: 0) {
                Spacer()

                // Celebration header
                VStack(spacing: 6) {
                    Text("正解！")
                        .font(AppFonts.largeTitle)
                        .foregroundColor(.white)

                    Text("よくできたね！")
                        .font(AppFonts.title)
                        .foregroundColor(.white.opacity(0.9))
                }

                MascotPlaceholder(size: 160)
                    .padding(.top, 24)
                    .padding(.bottom, 32)

                // XP reward card
                FloatingCard {
                    VStack(spacing: 16) {
                        Text("XPを獲得！")
                            .font(AppFonts.headline)
                            .foregroundColor(.textDark)

                        // Rewards row
                        HStack(spacing: 12) {
                            RewardChip(icon: "🔥", label: "+10 XP",  color: .primaryPurple)
                            RewardChip(icon: "💎", label: "+5",       color: .appTeal)
                        }

                        Divider()

                        // Streak
                        VStack(spacing: 6) {
                            Text("連続学習記録")
                                .font(AppFonts.caption)
                                .foregroundColor(.textGray)

                            Text("7 日連続！")
                                .font(AppFonts.title)
                                .foregroundColor(.textDark)

                            StreakCalendar()
                        }
                    }
                    .padding(24)
                }
                .padding(.horizontal, 24)

                Spacer()

                PillButton(title: "つぎのレッスンへ", color: .pythonLime) {
                    appState.navigate(to: .home)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
            }
        }
    }
}

// MARK: - Streak Calendar

private struct StreakCalendar: View {
    private let days   = ["月", "火", "水", "木", "金", "土", "日"]
    private let done   = [true,  true, true, true, true, true, false]

    var body: some View {
        HStack(spacing: 8) {
            ForEach(Array(zip(days, done).enumerated()), id: \.offset) { index, item in
                let (day, isDone) = item
                let isToday = index == days.count - 1

                VStack(spacing: 4) {
                    ZStack {
                        Circle()
                            .fill(isToday ? Color.primaryPurple : (isDone ? Color.successGreen : Color.textGray.opacity(0.15)))
                            .frame(width: 32, height: 32)

                        if isDone && !isToday {
                            Image(systemName: "checkmark")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.white)
                        }
                    }

                    Text(day)
                        .font(AppFonts.caption)
                        .foregroundColor(.textGray)
                }
            }
        }
    }
}

// MARK: - Confetti

private struct ConfettiLayer: View {
    private let pieces: [(color: Color, x: CGFloat, y: CGFloat, rotation: Double, size: CGSize)] = [
        (.pythonLime,   -130, -300,  15, CGSize(width: 8,  height: 20)),
        (.warmYellow,    120, -280, -20, CGSize(width: 10, height: 14)),
        (.errorRed,     -80,  -200,  35, CGSize(width: 6,  height: 18)),
        (.primaryPurple, 150, -150, -10, CGSize(width: 8,  height: 12)),
        (.pythonLime,    60,  -340,  50, CGSize(width: 12, height: 8)),
        (.warmYellow,   -150, -100,  25, CGSize(width: 8,  height: 16)),
        (.appTeal,       100,  -80, -40, CGSize(width: 10, height: 10)),
        (.errorRed,     -50,  -320, -15, CGSize(width: 6,  height: 20)),
        (.primaryPurple,-120, -60,   30, CGSize(width: 8,  height: 14)),
        (.pythonLime,    140,  -40,  -5, CGSize(width: 10, height: 18)),
    ]

    var body: some View {
        ForEach(Array(pieces.enumerated()), id: \.offset) { _, piece in
            Rectangle()
                .fill(piece.color)
                .frame(width: piece.size.width, height: piece.size.height)
                .cornerRadius(2)
                .offset(x: piece.x, y: piece.y)
                .rotationEffect(.degrees(piece.rotation))
                .opacity(0.7)
        }
    }
}

#Preview {
    ResultView()
        .environmentObject(AppState())
}
