//
//  ResultView.swift
//  pythonsta
//
//  Created by 茂木史明 on 2026/06/05.
//

import SwiftUI

struct ResultView: View {
    @EnvironmentObject var appState: AppState

    @State private var appeared       = false
    @State private var levelProgress  = false
    @State private var xpScale        = false
    @State private var confettiDrift  = false

    var body: some View {
        ZStack {
            // ── Gradient background ───────────────────────────────────
            LinearGradient(
                colors: [Color(hex: "#B9F238"), Color(hex: "#20D6A4")],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            // ── Subtle inner glow ──────────────────────────────────────
            RadialGradient(
                colors: [Color.white.opacity(0.15), Color.clear],
                center: .top,
                startRadius: 0,
                endRadius: 300
            )
            .ignoresSafeArea()

            // ── Confetti (premium, subtle) ─────────────────────────────
            ConfettiLayer(drifting: confettiDrift)

            // ── Scrollable content ─────────────────────────────────────
            ScrollView(showsIndicators: false) {
                VStack(spacing: 28) {
                    Spacer().frame(height: 16)

                    CelebrationArea()
                        .opacity(appeared ? 1 : 0)
                        .scaleEffect(appeared ? 1 : 0.85)
                        .animation(.spring(response: 0.6, dampingFraction: 0.65).delay(0.1), value: appeared)

                    SuccessHeader(xpScale: xpScale)
                        .opacity(appeared ? 1 : 0)
                        .offset(y: appeared ? 0 : 16)
                        .animation(.easeOut(duration: 0.45).delay(0.25), value: appeared)

                    StatsCard()
                        .opacity(appeared ? 1 : 0)
                        .offset(y: appeared ? 0 : 20)
                        .animation(.easeOut(duration: 0.45).delay(0.38), value: appeared)

                    LevelProgressCard(animate: levelProgress)
                        .opacity(appeared ? 1 : 0)
                        .offset(y: appeared ? 0 : 20)
                        .animation(.easeOut(duration: 0.45).delay(0.50), value: appeared)

                    AchievementUnlockCard()
                        .opacity(appeared ? 1 : 0)
                        .offset(y: appeared ? 0 : 20)
                        .animation(.easeOut(duration: 0.45).delay(0.62), value: appeared)

                    PyroSection()
                        .opacity(appeared ? 1 : 0)
                        .animation(.easeOut(duration: 0.4).delay(0.72), value: appeared)

                    CTASection(
                        onNext:  { appState.navigate(to: .home) },
                        onLater: { appState.navigate(to: .home) }
                    )
                    .opacity(appeared ? 1 : 0)
                    .offset(y: appeared ? 0 : 16)
                    .animation(.easeOut(duration: 0.4).delay(0.80), value: appeared)

                    Spacer().frame(height: 48)
                }
                .padding(.horizontal, 24)
            }
        }
        .onAppear {
            appeared      = true
            confettiDrift = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.55) {
                withAnimation(.easeOut(duration: 0.8)) { xpScale      = true }
                withAnimation(.easeOut(duration: 1.0)) { levelProgress = true }
            }
        }
    }
}

// MARK: - Celebration Area

private struct CelebrationArea: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white.opacity(0.18))
                .frame(height: 200)
            VStack(spacing: 8) {
                Text("🏆")
                    .font(.system(size: 54))
                Text("[Achievement Artwork]")
                    .font(.system(size: 12, weight: .medium, design: .rounded))
                    .foregroundColor(.white.opacity(0.6))
            }
        }
    }
}

// MARK: - Success Header + XP Rewards

private struct SuccessHeader: View {
    let xpScale: Bool

    var body: some View {
        VStack(spacing: 16) {
            // Title
            Text("レッスンクリア！")
                .font(.system(size: 34, weight: .bold, design: .rounded))
                .foregroundColor(.white)

            // Large XP number
            Text("+50 XP")
                .font(.system(size: 52, weight: .heavy, design: .rounded))
                .foregroundColor(.white)
                .scaleEffect(xpScale ? 1 : 0.6)
                .opacity(xpScale ? 1 : 0)

            // Reward badges row
            HStack(spacing: 12) {
                RewardBadge(icon: "🔥", text: "+1 Streak", color: Color(hex: "#FF8C42"))
                RewardBadge(icon: "💎", text: "+5 Gems",   color: Color(hex: "#1FD1C2"))
            }
        }
        .multilineTextAlignment(.center)
    }
}

private struct RewardBadge: View {
    let icon: String
    let text: String
    let color: Color

    var body: some View {
        HStack(spacing: 6) {
            Text(icon).font(.system(size: 16))
            Text(text)
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .foregroundColor(.white)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(Color.white.opacity(0.22))
        .clipShape(Capsule())
        .overlay(
            Capsule().strokeBorder(Color.white.opacity(0.35), lineWidth: 1)
        )
    }
}

// MARK: - Statistics Card

private struct StatsCard: View {
    var body: some View {
        FloatingCard {
            HStack(spacing: 0) {
                StatColumn(value: "90%",   label: "正答率",  color: .successGreen)
                StatDivider()
                StatColumn(value: "1:24",  label: "解答時間", color: .primaryPurple)
                StatDivider()
                StatColumn(value: "7問",   label: "連続正解", color: Color(hex: "#FF8C42"))
            }
            .padding(.vertical, 20)
        }
    }
}

private struct StatColumn: View {
    let value: String
    let label: String
    let color: Color

    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .foregroundColor(color)
            Text(label)
                .font(.system(size: 12, weight: .regular, design: .rounded))
                .foregroundColor(.textGray)
        }
        .frame(maxWidth: .infinity)
    }
}

private struct StatDivider: View {
    var body: some View {
        Rectangle()
            .fill(Color.appBackground)
            .frame(width: 1, height: 44)
    }
}

// MARK: - Level Progress Card

private struct LevelProgressCard: View {
    let animate: Bool

    var body: some View {
        FloatingCard {
            VStack(spacing: 14) {
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Level 5")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .foregroundColor(.textDark)
                        Text("420 / 500 XP")
                            .font(.system(size: 13, weight: .regular, design: .rounded))
                            .foregroundColor(.textGray)
                    }
                    Spacer()
                    // Next level badge
                    Text("Lv.6 まで80XP")
                        .font(.system(size: 11, weight: .semibold, design: .rounded))
                        .foregroundColor(.primaryPurple)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color.primaryPurple.opacity(0.1))
                        .clipShape(Capsule())
                }

                // Animated progress bar
                GeometryReader { geo in
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
                            .frame(
                                width: animate ? geo.size.width * 0.84 : geo.size.width * 0.62,
                                height: 12
                            )
                            .animation(.easeOut(duration: 1.0), value: animate)
                    }
                }
                .frame(height: 12)
            }
            .padding(20)
        }
    }
}

// MARK: - Achievement Unlock Card

private struct AchievementUnlockCard: View {
    var body: some View {
        FloatingCard {
            HStack(spacing: 16) {
                // Badge artwork placeholder
                ZStack {
                    RoundedRectangle(cornerRadius: 14)
                        .fill(Color.warmYellow.opacity(0.15))
                        .frame(width: 68, height: 68)
                    VStack(spacing: 3) {
                        Text("🏅")
                            .font(.system(size: 28))
                        Text("[Achievement\nArtwork]")
                            .font(.system(size: 7, weight: .medium, design: .rounded))
                            .foregroundColor(.textGray.opacity(0.5))
                            .multilineTextAlignment(.center)
                    }
                }

                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 6) {
                        Text("NEW")
                            .font(.system(size: 10, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .padding(.horizontal, 7)
                            .padding(.vertical, 3)
                            .background(Color.warmYellow)
                            .clipShape(Capsule())
                        Text("実績解除！")
                            .font(.system(size: 12, weight: .semibold, design: .rounded))
                            .foregroundColor(.textGray)
                    }
                    Text("初めてのprint()")
                        .font(.system(size: 17, weight: .bold, design: .rounded))
                        .foregroundColor(.textDark)
                    Text("初めてのレッスンを完了しました")
                        .font(.system(size: 13, weight: .regular, design: .rounded))
                        .foregroundColor(.textGray)
                }

                Spacer()
            }
            .padding(18)
        }
    }
}

// MARK: - Pyro Section

private struct PyroSection: View {
    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color.white.opacity(0.22))
                    .frame(width: 60, height: 60)
                Text("[Pyro\nMascot]")
                    .font(.system(size: 9, weight: .medium, design: .rounded))
                    .foregroundColor(.white.opacity(0.7))
                    .multilineTextAlignment(.center)
            }

            VStack(alignment: .leading, spacing: 3) {
                Text("その調子！")
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                Text("Pythonが身についてきたね！\n次のレッスンも挑戦してみよう。")
                    .font(.system(size: 13, weight: .regular, design: .rounded))
                    .foregroundColor(.white.opacity(0.88))
                    .lineSpacing(2)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer()
        }
        .padding(18)
        .background(Color.white.opacity(0.16))
        .cornerRadius(20)
    }
}

// MARK: - CTA Section

private struct CTASection: View {
    let onNext:  () -> Void
    let onLater: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            Button(action: onNext) {
                Text("次のレッスンへ")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(.textDark)
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background(Color.white)
                    .clipShape(Capsule())
                    .shadow(color: .black.opacity(0.10), radius: 12, x: 0, y: 6)
            }

            Button(action: onLater) {
                Text("あとで")
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundColor(.white.opacity(0.85))
            }
        }
    }
}

// MARK: - Confetti Layer (premium, subtle)

private struct ConfettiLayer: View {
    let drifting: Bool

    private struct Piece: Identifiable {
        let id: Int
        let color: Color
        let x: CGFloat
        let y: CGFloat
        let rotation: Double
        let size: CGSize
        let isCircle: Bool
        let driftX: CGFloat
        let driftY: CGFloat
    }

    private let pieces: [Piece] = [
        Piece(id:  0, color: .white,             x: -120, y: -340, rotation:  18, size: CGSize(width:  7, height: 18), isCircle: false, driftX:  6, driftY: 12),
        Piece(id:  1, color: Color(hex:"#FFD66B"),x:  100, y: -300, rotation: -22, size: CGSize(width:  9, height: 12), isCircle: false, driftX: -8, driftY: 10),
        Piece(id:  2, color: .white.opacity(0.6),x:  -60, y: -200, rotation:  40, size: CGSize(width:  8, height:  8), isCircle: true,  driftX:  4, driftY: 14),
        Piece(id:  3, color: Color(hex:"#5C44F5"),x:  140, y: -160, rotation: -12, size: CGSize(width: 10, height: 14), isCircle: false, driftX: -5, driftY:  9),
        Piece(id:  4, color: .white,             x:   50, y: -380, rotation:  55, size: CGSize(width:  6, height: 20), isCircle: false, driftX:  7, driftY: 16),
        Piece(id:  5, color: Color(hex:"#FF6B6B"),x: -140, y: -120, rotation: -30, size: CGSize(width:  9, height:  9), isCircle: true,  driftX: -3, driftY: 11),
        Piece(id:  6, color: .white.opacity(0.5),x:  120, y: -240, rotation:   8, size: CGSize(width:  7, height: 16), isCircle: false, driftX:  5, driftY: 13),
        Piece(id:  7, color: Color(hex:"#FFD66B"),x:  -90, y: -80,  rotation:  25, size: CGSize(width: 11, height:  7), isCircle: false, driftX: -6, driftY:  8),
        Piece(id:  8, color: .white,             x:   80, y: -420, rotation: -45, size: CGSize(width:  6, height:  6), isCircle: true,  driftX:  9, driftY: 18),
        Piece(id:  9, color: Color(hex:"#5C44F5"),x: -110, y: -280, rotation:  15, size: CGSize(width:  8, height: 18), isCircle: false, driftX: -4, driftY: 12),
        Piece(id: 10, color: Color(hex:"#FF6B6B"),x:  160, y: -50,  rotation: -35, size: CGSize(width: 10, height: 10), isCircle: true,  driftX:  3, driftY:  7),
        Piece(id: 11, color: .white.opacity(0.7),x:  -30, y: -460, rotation:  60, size: CGSize(width:  7, height: 14), isCircle: false, driftX:  8, driftY: 20),
    ]

    var body: some View {
        ZStack {
            ForEach(pieces) { p in
                Group {
                    if p.isCircle {
                        Circle().fill(p.color).frame(width: p.size.width, height: p.size.height)
                    } else {
                        Rectangle().fill(p.color).frame(width: p.size.width, height: p.size.height).cornerRadius(2)
                    }
                }
                .rotationEffect(.degrees(p.rotation))
                .offset(
                    x: p.x + (drifting ? p.driftX : 0),
                    y: p.y + (drifting ? p.driftY : 0)
                )
                .animation(
                    .easeInOut(duration: Double.random(in: 2.5...4.0))
                    .repeatForever(autoreverses: true)
                    .delay(Double.random(in: 0...1.0)),
                    value: drifting
                )
                .opacity(0.75)
            }
        }
    }
}

#Preview {
    ResultView()
        .environmentObject(AppState())
}
