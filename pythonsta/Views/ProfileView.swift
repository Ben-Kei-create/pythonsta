//
//  ProfileView.swift
//  pythonsta
//
//  Created by 茂木史明 on 2026/06/05.
//

import SwiftUI

// MARK: - ProfileView

struct ProfileView: View {
    @EnvironmentObject var appState: AppState
    var profile: UserProfile = .preview

    @State private var animateLevel = false

    var body: some View {
        ZStack(alignment: .bottom) {
            Color.appBackground.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    ProfileScreenHeader()
                        .padding(.horizontal, 20)
                        .padding(.top, 16)

                    ProfileHeroCard(profile: profile)
                        .padding(.horizontal, 20)

                    LifetimeStatsCard(profile: profile)
                        .padding(.horizontal, 20)

                    LessonCompletionCard(profile: profile)
                        .padding(.horizontal, 20)

                    ProfileLevelCard(profile: profile, animate: animateLevel)
                        .padding(.horizontal, 20)

                    ProfileAchievementsSection(achievements: profile.achievements)

                    Spacer().frame(height: 100)
                }
            }

            AppTabBar(selectedIndex: 3) { index in
                if index == 0 { appState.navigate(to: .home) }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 28)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.easeOut(duration: 1.0)) { animateLevel = true }
            }
        }
    }
}

// MARK: - Screen Header

private struct ProfileScreenHeader: View {
    var body: some View {
        HStack {
            Text("プロフィール")
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .foregroundColor(.textDark)
            Spacer()
            Image(systemName: "gearshape.fill")
                .font(.system(size: 18))
                .foregroundColor(.textGray)
                .frame(width: 40, height: 40)
                .background(Color.white)
                .cornerRadius(12)
                .shadow(color: .black.opacity(0.05), radius: 6, x: 0, y: 2)
        }
    }
}

// MARK: - Hero Card

private struct ProfileHeroCard: View {
    let profile: UserProfile

    var body: some View {
        ZStack(alignment: .topLeading) {
            LinearGradient(
                colors: [.primaryPurple, .deepPurple],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .cornerRadius(24)

            VStack(alignment: .leading, spacing: 18) {
                // Avatar row
                HStack(alignment: .center, spacing: 16) {
                    // Profile image placeholder — text only, no substitute artwork
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.white.opacity(0.15))
                            .frame(width: 72, height: 72)
                        Text("[Profile\nImage]")
                            .font(.system(size: 9, weight: .medium, design: .rounded))
                            .foregroundColor(.white.opacity(0.55))
                            .multilineTextAlignment(.center)
                    }

                    VStack(alignment: .leading, spacing: 5) {
                        Text(profile.displayName)
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .minimumScaleFactor(0.82)
                            .lineLimit(1)

                        Text(profile.username)
                            .font(.system(size: 13, weight: .regular, design: .rounded))
                            .foregroundColor(.white.opacity(0.70))
                            .lineLimit(1)

                        // Level badge
                        Text("Lv.\(profile.level) · \(profile.totalXP) XP")
                            .font(.system(size: 12, weight: .bold, design: .rounded))
                            .foregroundColor(.textDark)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 4)
                            .background(Color.pythonLime)
                            .clipShape(Capsule())
                    }

                    Spacer(minLength: 0)
                }

                // Edit button
                Button { } label: {
                    Text("プロフィールを編集")
                        .font(.system(size: 13, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                        .background(Color.white.opacity(0.16))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(Color.white.opacity(0.28), lineWidth: 1)
                        )
                }
            }
            .padding(20)
        }
    }
}

// MARK: - Lifetime Stats Card (2 × 2 grid)

private struct LifetimeStatsCard: View {
    let profile: UserProfile

    var body: some View {
        FloatingCard {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    ProfileStatCell(
                        value: profile.totalXP.formatted(),
                        label: "Total XP",
                        color: .primaryPurple
                    )
                    ProfileStatDividerV()
                    ProfileStatCell(
                        value: "\(profile.currentStreak)日",
                        label: "連続学習",
                        color: Color(hex: "#FF8C42")
                    )
                }
                ProfileStatDividerH()
                HStack(spacing: 0) {
                    ProfileStatCell(
                        value: "\(profile.gems)",
                        label: "Gems",
                        color: .appTeal
                    )
                    ProfileStatDividerV()
                    ProfileStatCell(
                        value: profile.formattedLearningTime,
                        label: "学習時間",
                        color: .snakeGreen
                    )
                }
            }
        }
    }
}

private struct ProfileStatCell: View {
    let value: String
    let label: String
    let color: Color

    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .foregroundColor(color)
                .minimumScaleFactor(0.75)
                .lineLimit(1)
            Text(label)
                .font(.system(size: 11, weight: .regular, design: .rounded))
                .foregroundColor(.textGray)
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 18)
    }
}

private struct ProfileStatDividerV: View {
    var body: some View {
        Rectangle()
            .fill(Color.appBackground)
            .frame(width: 1)
            .padding(.vertical, 14)
    }
}

private struct ProfileStatDividerH: View {
    var body: some View {
        Rectangle()
            .fill(Color.appBackground)
            .frame(height: 1)
            .padding(.horizontal, 20)
    }
}

// MARK: - Lesson Completion Card

private struct LessonCompletionCard: View {
    let profile: UserProfile

    var body: some View {
        FloatingCard {
            VStack(alignment: .leading, spacing: 14) {
                HStack(alignment: .firstTextBaseline) {
                    Text("レッスン進捗")
                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                        .foregroundColor(.textDark)
                    Spacer(minLength: 8)
                    Text("\(profile.completedLessons) / \(profile.totalLessons)")
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .foregroundColor(.primaryPurple)
                }

                RoundedProgressBar(
                    value: profile.lessonProgressFraction,
                    color: .primaryPurple,
                    height: 10
                )

                HStack {
                    Text("完了")
                        .font(.system(size: 12, design: .rounded))
                        .foregroundColor(.textGray)
                    Spacer()
                    Text("残り \(profile.totalLessons - profile.completedLessons) レッスン")
                        .font(.system(size: 12, design: .rounded))
                        .foregroundColor(.textGray)
                        .minimumScaleFactor(0.85)
                        .lineLimit(1)
                }
            }
            .padding(18)
        }
    }
}

// MARK: - Level Progress Card

private struct ProfileLevelCard: View {
    let profile: UserProfile
    let animate: Bool

    var body: some View {
        FloatingCard {
            VStack(spacing: 12) {
                HStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Level \(profile.level)")
                            .font(.system(size: 19, weight: .bold, design: .rounded))
                            .foregroundColor(.textDark)
                        Text("\(profile.levelCurrentXP) / \(profile.levelMaxXP) XP")
                            .font(.system(size: 12, design: .rounded))
                            .foregroundColor(.textGray)
                    }
                    Spacer(minLength: 8)
                    Text("Lv.\(profile.level + 1)まで\(profile.xpToNextLevel)XP")
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
                                width: animate
                                    ? geo.size.width * profile.levelProgressFraction
                                    : 0,
                                height: 12
                            )
                            .animation(.easeOut(duration: 1.0), value: animate)
                    }
                }
                .frame(height: 12)
            }
            .padding(18)
        }
    }
}

// MARK: - Achievements Section

private struct ProfileAchievementsSection: View {
    let achievements: [ProfileAchievement]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("実績")
                    .font(.system(size: 17, weight: .bold, design: .rounded))
                    .foregroundColor(.textDark)
                Spacer()
                Button("すべて見る") { }
                    .font(.system(size: 13, weight: .medium, design: .rounded))
                    .foregroundColor(.primaryPurple)
            }
            .padding(.horizontal, 20)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    Spacer().frame(width: 8)
                    ForEach(achievements) { item in
                        ProfileAchievementCard(item: item)
                    }
                    Spacer().frame(width: 8)
                }
            }
        }
    }
}

private struct ProfileAchievementCard: View {
    let item: ProfileAchievement

    var body: some View {
        VStack(spacing: 10) {
            // Artwork placeholder — text only, no substitute artwork
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .fill(
                        item.isEarned
                            ? Color.primaryPurple.opacity(0.08)
                            : Color.textGray.opacity(0.06)
                    )
                    .frame(width: 72, height: 72)
                Text("[Achievement\nArtwork]")
                    .font(.system(size: 9, weight: .medium, design: .rounded))
                    .foregroundColor(
                        item.isEarned
                            ? Color.primaryPurple.opacity(0.4)
                            : Color.textGray.opacity(0.3)
                    )
                    .multilineTextAlignment(.center)
            }

            Text(item.title)
                .font(.system(size: 12, weight: .bold, design: .rounded))
                .foregroundColor(item.isEarned ? .textDark : .textGray)
                .minimumScaleFactor(0.8)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)

            Text(item.subtitle)
                .font(.system(size: 10, weight: .regular, design: .rounded))
                .foregroundColor(.textGray)
                .lineLimit(1)
        }
        .padding(12)
        .frame(width: 112)
        .background(Color.white)
        .cornerRadius(18)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 3)
        .opacity(item.isEarned ? 1.0 : 0.55)
    }
}

#Preview {
    ProfileView(profile: .preview)
        .environmentObject(AppState())
}
