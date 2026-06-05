//
//  ResultView.swift
//  pythonsta
//
//  Created by 茂木史明 on 2026/06/05.
//

import SwiftUI

// MARK: - ResultView

struct ResultView: View {
    @EnvironmentObject var appState: AppState

    var result: LessonResult = .preview

    @State private var appeared      = false
    @State private var animateXP     = false
    @State private var animateLevel  = false

    var body: some View {
        ZStack {
            ResultBackground()
            ConfettiLayer()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    Spacer().frame(height: 8)

                    PlaceholderArtworkView(label: "[Achievement Artwork]", height: 200)
                        .appear(appeared, scale: true, delay: 0.10)

                    SuccessHeaderView(result: result, animateXP: animateXP)
                        .appear(appeared, delay: 0.25)

                    StatisticsCardView(result: result)
                        .appear(appeared, delay: 0.38)

                    LevelProgressCardView(result: result, animate: animateLevel)
                        .appear(appeared, delay: 0.50)

                    if let achievement = result.unlockedAchievement {
                        AchievementUnlockCardView(achievement: achievement)
                            .appear(appeared, delay: 0.62)
                    }

                    PyroEncouragementView(message: result.encouragementMessage)
                        .appear(appeared, delay: 0.72)

                    ResultCTAView(
                        onNext:  { appState.navigate(to: .home) },
                        onLater: { appState.navigate(to: .home) }
                    )
                    .appear(appeared, delay: 0.80)

                    Spacer().frame(height: 40)
                }
                .padding(.horizontal, 20)
            }
        }
        .onAppear {
            appeared = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.55) {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.65)) { animateXP    = true }
                withAnimation(.easeOut(duration: 1.0))                        { animateLevel = true }
            }
        }
    }
}

// MARK: - Background

private struct ResultBackground: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(hex: "#B9F238"), Color(hex: "#20D6A4")],
                startPoint: .top,
                endPoint: .bottom
            )
            RadialGradient(
                colors: [Color.white.opacity(0.14), Color.clear],
                center: .top,
                startRadius: 0,
                endRadius: 280
            )
        }
        .ignoresSafeArea()
    }
}

// MARK: - Success Header

private struct SuccessHeaderView: View {
    let result: LessonResult
    let animateXP: Bool

    var body: some View {
        VStack(spacing: 14) {
            Text(result.successTitle)
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .minimumScaleFactor(0.8)
                .lineLimit(1)

            Text("+\(result.xpEarned) XP")
                .font(.system(size: 52, weight: .heavy, design: .rounded))
                .foregroundColor(.white)
                .minimumScaleFactor(0.75)
                .lineLimit(1)
                .scaleEffect(animateXP ? 1 : 0.55)
                .opacity(animateXP ? 1 : 0)

            HStack(spacing: 10) {
                RewardBadgeView(icon: "🔥", text: "+\(result.streakDelta) Streak")
                RewardBadgeView(icon: "💎", text: "+\(result.gemsEarned) Gems")
            }
        }
        .multilineTextAlignment(.center)
    }
}

// MARK: - RewardBadgeView

struct RewardBadgeView: View {
    let icon: String
    let text: String

    var body: some View {
        HStack(spacing: 5) {
            Text(icon).font(.system(size: 15))
            Text(text)
                .font(.system(size: 13, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .lineLimit(1)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 9)
        .background(Color.white.opacity(0.20))
        .clipShape(Capsule())
        .overlay(Capsule().strokeBorder(Color.white.opacity(0.30), lineWidth: 1))
    }
}

// MARK: - Statistics Card

private struct StatisticsCardView: View {
    let result: LessonResult

    var body: some View {
        FloatingCard {
            HStack(spacing: 0) {
                StatisticItemView(
                    value: "\(result.accuracyPercent)%",
                    label: "正答率",
                    color: .successGreen
                )
                StatisticDivider()
                StatisticItemView(
                    value: result.elapsedTime,
                    label: "解答時間",
                    color: .primaryPurple
                )
                StatisticDivider()
                StatisticItemView(
                    value: "\(result.comboCount)問",
                    label: "連続正解",
                    color: Color(hex: "#FF8C42")
                )
            }
            .padding(.vertical, 18)
        }
    }
}

// MARK: - StatisticItemView

struct StatisticItemView: View {
    let value: String
    let label: String
    let color: Color

    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .foregroundColor(color)
                .minimumScaleFactor(0.8)
                .lineLimit(1)
            Text(label)
                .font(.system(size: 11, weight: .regular, design: .rounded))
                .foregroundColor(.textGray)
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity)
    }
}

private struct StatisticDivider: View {
    var body: some View {
        Rectangle()
            .fill(Color.appBackground)
            .frame(width: 1, height: 40)
    }
}

// MARK: - LevelProgressCardView

struct LevelProgressCardView: View {
    let result: LessonResult
    let animate: Bool

    var body: some View {
        FloatingCard {
            VStack(spacing: 12) {
                HStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Level \(result.currentLevel)")
                            .font(.system(size: 19, weight: .bold, design: .rounded))
                            .foregroundColor(.textDark)
                        Text("\(result.currentXP) / \(result.levelMaxXP) XP")
                            .font(.system(size: 12, weight: .regular, design: .rounded))
                            .foregroundColor(.textGray)
                    }
                    Spacer(minLength: 8)
                    Text("Lv.\(result.currentLevel + 1)まで\(result.xpToNextLevel)XP")
                        .font(.system(size: 11, weight: .semibold, design: .rounded))
                        .foregroundColor(.primaryPurple)
                        .minimumScaleFactor(0.8)
                        .lineLimit(1)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color.primaryPurple.opacity(0.10))
                        .clipShape(Capsule())
                }

                GeometryReader { geo in
                    let totalWidth = geo.size.width
                    let fromWidth  = totalWidth * result.priorLevelProgressFraction
                    let toWidth    = totalWidth * result.levelProgressFraction

                    ZStack(alignment: .leading) {
                        Capsule()
                            .fill(Color.appBackground)
                            .frame(height: 12)
                        Capsule()
                            .fill(
                                LinearGradient(
                                    colors: [.primaryPurple, Color(hex: "#8B6EF5")],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .frame(width: animate ? toWidth : fromWidth, height: 12)
                            .animation(.easeOut(duration: 1.0), value: animate)
                    }
                }
                .frame(height: 12)
            }
            .padding(18)
        }
    }
}

// MARK: - AchievementUnlockCardView

struct AchievementUnlockCardView: View {
    let achievement: LessonResult.UnlockedAchievement

    var body: some View {
        FloatingCard {
            HStack(spacing: 14) {
                // Artwork placeholder
                ZStack {
                    RoundedRectangle(cornerRadius: 14)
                        .fill(Color.warmYellow.opacity(0.14))
                        .frame(width: 64, height: 64)
                    Text("[Achievement\nArtwork]")
                        .font(.system(size: 8, weight: .medium, design: .rounded))
                        .foregroundColor(.textGray.opacity(0.45))
                        .multilineTextAlignment(.center)
                }

                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 5) {
                        Text("NEW")
                            .font(.system(size: 10, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(Color.warmYellow)
                            .clipShape(Capsule())
                        Text("実績解除！")
                            .font(.system(size: 12, weight: .semibold, design: .rounded))
                            .foregroundColor(.textGray)
                    }
                    Text(achievement.title)
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundColor(.textDark)
                        .minimumScaleFactor(0.82)
                        .lineLimit(2)
                    Text(achievement.description)
                        .font(.system(size: 12, weight: .regular, design: .rounded))
                        .foregroundColor(.textGray)
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)
                }

                Spacer(minLength: 0)
            }
            .padding(16)
        }
    }
}

// MARK: - Pyro Encouragement

private struct PyroEncouragementView: View {
    let message: String

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // Mascot placeholder
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white.opacity(0.20))
                    .frame(width: 56, height: 56)
                Text("[Pyro\nMascot]")
                    .font(.system(size: 8, weight: .medium, design: .rounded))
                    .foregroundColor(.white.opacity(0.65))
                    .multilineTextAlignment(.center)
            }

            VStack(alignment: .leading, spacing: 3) {
                Text("その調子！")
                    .font(.system(size: 15, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                Text(message)
                    .font(.system(size: 13, weight: .regular, design: .rounded))
                    .foregroundColor(.white.opacity(0.88))
                    .lineSpacing(2)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer(minLength: 0)
        }
        .padding(16)
        .background(Color.white.opacity(0.15))
        .cornerRadius(18)
    }
}

// MARK: - CTA

private struct ResultCTAView: View {
    let onNext:  () -> Void
    let onLater: () -> Void

    var body: some View {
        VStack(spacing: 14) {
            Button(action: onNext) {
                Text("次のレッスンへ")
                    .font(.system(size: 17, weight: .bold, design: .rounded))
                    .foregroundColor(.textDark)
                    .minimumScaleFactor(0.85)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity)
                    .frame(height: 58)
                    .background(Color.white)
                    .clipShape(Capsule())
                    .shadow(color: .black.opacity(0.10), radius: 10, x: 0, y: 5)
            }

            Button(action: onLater) {
                Text("あとで")
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                    .foregroundColor(.white.opacity(0.85))
            }
            .padding(.vertical, 4)
        }
    }
}

// MARK: - Confetti (12 static pieces, pre-computed durations)

private struct ConfettiLayer: View {

    private struct Piece: Identifiable {
        let id: Int
        let color: Color
        let x, y: CGFloat
        let rotation: Double
        let width, height: CGFloat
        let isCircle: Bool
        let driftX, driftY: CGFloat
        let duration: Double
        let delay: Double
    }

    // durations and delays are fixed constants — no random() in body
    private let pieces: [Piece] = [
        Piece(id:  0, color: .white,                    x: -118, y: -338, rotation:  18, width:  7, height: 18, isCircle: false, driftX:  6, driftY: 11, duration: 2.8, delay: 0.0),
        Piece(id:  1, color: Color(hex: "#FFD66B"),     x:  102, y: -298, rotation: -22, width:  9, height: 12, isCircle: false, driftX: -8, driftY: 10, duration: 3.3, delay: 0.3),
        Piece(id:  2, color: .white.opacity(0.55),      x:  -58, y: -198, rotation:  40, width:  8, height:  8, isCircle: true,  driftX:  4, driftY: 14, duration: 2.6, delay: 0.7),
        Piece(id:  3, color: Color(hex: "#5C44F5"),     x:  142, y: -158, rotation: -12, width: 10, height: 14, isCircle: false, driftX: -5, driftY:  9, duration: 3.1, delay: 0.2),
        Piece(id:  4, color: .white,                    x:   52, y: -378, rotation:  55, width:  6, height: 20, isCircle: false, driftX:  7, driftY: 15, duration: 2.9, delay: 0.5),
        Piece(id:  5, color: Color(hex: "#FF6B6B"),     x: -138, y: -118, rotation: -30, width:  9, height:  9, isCircle: true,  driftX: -3, driftY: 11, duration: 3.4, delay: 0.1),
        Piece(id:  6, color: .white.opacity(0.50),      x:  122, y: -238, rotation:   8, width:  7, height: 16, isCircle: false, driftX:  5, driftY: 13, duration: 2.7, delay: 0.6),
        Piece(id:  7, color: Color(hex: "#FFD66B"),     x:  -88, y:  -78, rotation:  25, width: 11, height:  7, isCircle: false, driftX: -6, driftY:  8, duration: 3.2, delay: 0.4),
        Piece(id:  8, color: .white,                    x:   82, y: -418, rotation: -45, width:  6, height:  6, isCircle: true,  driftX:  9, driftY: 17, duration: 2.5, delay: 0.8),
        Piece(id:  9, color: Color(hex: "#5C44F5"),     x: -108, y: -278, rotation:  15, width:  8, height: 18, isCircle: false, driftX: -4, driftY: 12, duration: 3.0, delay: 0.2),
        Piece(id: 10, color: Color(hex: "#FF6B6B"),     x:  158, y:  -48, rotation: -35, width: 10, height: 10, isCircle: true,  driftX:  3, driftY:  7, duration: 3.5, delay: 0.9),
        Piece(id: 11, color: .white.opacity(0.65),      x:  -28, y: -458, rotation:  60, width:  7, height: 14, isCircle: false, driftX:  8, driftY: 19, duration: 2.6, delay: 0.3),
    ]

    // One boolean triggers all pieces; each piece's animation modifier
    // carries its own duration + delay, so no DispatchQueue needed.
    @State private var phase = false

    var body: some View {
        ZStack {
            ForEach(pieces) { p in
                confettiShape(for: p)
                    .rotationEffect(.degrees(p.rotation))
                    .offset(x: p.x + (phase ? p.driftX : 0),
                            y: p.y + (phase ? p.driftY : 0))
                    .animation(
                        .easeInOut(duration: p.duration)
                        .repeatForever(autoreverses: true)
                        .delay(p.delay),
                        value: phase
                    )
                    .opacity(0.72)
            }
        }
        .onAppear { phase = true }
    }

    @ViewBuilder
    private func confettiShape(for p: Piece) -> some View {
        if p.isCircle {
            Circle()
                .fill(p.color)
                .frame(width: p.width, height: p.height)
        } else {
            RoundedRectangle(cornerRadius: 2)
                .fill(p.color)
                .frame(width: p.width, height: p.height)
        }
    }
}

// MARK: - Appear modifier helper

private extension View {
    func appear(_ appeared: Bool, scale: Bool = false, delay: Double = 0) -> some View {
        self
            .opacity(appeared ? 1 : 0)
            .offset(y: appeared ? 0 : 14)
            .scaleEffect(scale ? (appeared ? 1 : 0.86) : 1)
            .animation(.spring(response: 0.5, dampingFraction: 0.72).delay(delay), value: appeared)
    }
}

// MARK: - Preview

#Preview {
    ResultView(result: .preview)
        .environmentObject(AppState())
}
