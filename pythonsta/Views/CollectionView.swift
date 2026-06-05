//
//  CollectionView.swift
//  pythonsta
//
//  Created by 茂木史明 on 2026/06/05.
//

import SwiftUI

// MARK: - CollectionView

struct CollectionView: View {
    @EnvironmentObject var appState: AppState

    @State private var selectedFilter: Int = 0
    private let achievements: [CollectionAchievement] = CollectionAchievement.previewList

    private var earnedCount: Int {
        achievements.filter { $0.isUnlocked }.count
    }

    private var recentTitle: String? {
        achievements.last(where: { $0.isUnlocked })?.title
    }

    private var filtered: [CollectionAchievement] {
        switch selectedFilter {
        case 1: return achievements.filter { $0.isUnlocked }
        case 2: return achievements.filter { !$0.isUnlocked }
        default: return achievements
        }
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            Color.appBackground.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    AchievementCollectionHeaderView()
                        .padding(.horizontal, 20)
                        .padding(.top, 16)

                    AchievementSummaryCard(
                        earned: earnedCount,
                        total: achievements.count,
                        recentTitle: recentTitle
                    )
                    .padding(.horizontal, 20)

                    AchievementFilterTabs(selectedFilter: $selectedFilter)
                        .padding(.horizontal, 20)

                    if filtered.isEmpty {
                        AchievementEmptyStateView()
                            .padding(.horizontal, 20)
                            .padding(.top, 16)
                    } else {
                        AchievementGrid(achievements: filtered)
                            .padding(.horizontal, 20)
                    }

                    Spacer().frame(height: 100)
                }
            }

            AppTabBar(selectedIndex: 2) { index in
                switch index {
                case 0: appState.navigate(to: .home)
                case 1: appState.navigate(to: .ranking)
                case 3: appState.navigate(to: .profile)
                default: break
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 28)
        }
    }
}

// MARK: - Header

private struct AchievementCollectionHeaderView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text("コレクション")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundColor(.textDark)
                Text("学習の成果を集めよう")
                    .font(.system(size: 13, weight: .regular, design: .rounded))
                    .foregroundColor(.textGray)
            }
            Spacer()
        }
    }
}

// MARK: - Summary Card

private struct AchievementSummaryCard: View {
    let earned: Int
    let total: Int
    let recentTitle: String?

    private var progressFraction: Double {
        total > 0 ? Double(earned) / Double(total) : 0
    }

    private var percentText: String {
        "\(Int(progressFraction * 100))%"
    }

    var body: some View {
        FloatingCard {
            VStack(alignment: .leading, spacing: 14) {
                HStack(alignment: .firstTextBaseline) {
                    Text("獲得した実績")
                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                        .foregroundColor(.textDark)
                    Spacer(minLength: 8)
                    Text("\(earned) / \(total)")
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .foregroundColor(.primaryPurple)
                }

                RoundedProgressBar(
                    value: progressFraction,
                    color: .primaryPurple,
                    height: 10
                )

                HStack {
                    Text("\(percentText) 完了")
                        .font(.system(size: 12, design: .rounded))
                        .foregroundColor(.textGray)
                    Spacer()
                    if let recent = recentTitle {
                        Text("最近: \(recent)")
                            .font(.system(size: 11, weight: .medium, design: .rounded))
                            .foregroundColor(.textGray)
                            .minimumScaleFactor(0.8)
                            .lineLimit(1)
                    }
                }
            }
            .padding(18)
        }
    }
}

// MARK: - Filter Tabs

private struct AchievementFilterTabs: View {
    @Binding var selectedFilter: Int
    private let labels = ["すべて", "獲得済み", "未獲得"]

    var body: some View {
        HStack(spacing: 0) {
            ForEach(labels.indices, id: \.self) { index in
                Button {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        selectedFilter = index
                    }
                } label: {
                    Text(labels[index])
                        .font(.system(size: 13, weight: .semibold, design: .rounded))
                        .foregroundColor(selectedFilter == index ? .white : .textGray)
                        .minimumScaleFactor(0.85)
                        .lineLimit(1)
                        .frame(maxWidth: .infinity)
                        .frame(height: 36)
                        .background(
                            selectedFilter == index
                                ? Color.primaryPurple
                                : Color.clear
                        )
                        .clipShape(Capsule())
                }
            }
        }
        .padding(4)
        .background(Color.white)
        .clipShape(Capsule())
        .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 3)
    }
}

// MARK: - Achievement Grid

private struct AchievementGrid: View {
    let achievements: [CollectionAchievement]

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
    ]

    var body: some View {
        LazyVGrid(columns: columns, alignment: .leading, spacing: 12) {
            ForEach(achievements) { item in
                AchievementGridCard(item: item)
            }
        }
    }
}

// MARK: - Achievement Grid Card

private struct AchievementGridCard: View {
    let item: CollectionAchievement

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Artwork placeholder — text only, no substitute graphics
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(
                        item.isUnlocked
                            ? Color.primaryPurple.opacity(0.08)
                            : Color.appBackground
                    )
                    .frame(maxWidth: .infinity)
                    .frame(height: 80)
                Text("[Achievement\nArtwork]")
                    .font(.system(size: 9, weight: .medium, design: .rounded))
                    .foregroundColor(
                        item.isUnlocked
                            ? Color.primaryPurple.opacity(0.4)
                            : Color.textGray.opacity(0.3)
                    )
                    .multilineTextAlignment(.center)
            }

            Text(item.title)
                .font(.system(size: 13, weight: .bold, design: .rounded))
                .foregroundColor(item.isUnlocked ? .textDark : .textGray)
                .minimumScaleFactor(0.8)
                .lineLimit(2)

            Text(item.description)
                .font(.system(size: 10, weight: .regular, design: .rounded))
                .foregroundColor(.textGray)
                .minimumScaleFactor(0.8)
                .lineLimit(2)

            Spacer(minLength: 0)

            // Status label
            if item.isUnlocked {
                Text("獲得済み")
                    .font(.system(size: 10, weight: .bold, design: .rounded))
                    .foregroundColor(.pythonLime)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(Color.snakeGreen.opacity(0.15))
                    .clipShape(Capsule())

                if let date = item.unlockedDateText {
                    Text(date)
                        .font(.system(size: 9, weight: .regular, design: .rounded))
                        .foregroundColor(.textGray)
                        .lineLimit(1)
                }
            } else {
                Text("未獲得")
                    .font(.system(size: 10, weight: .medium, design: .rounded))
                    .foregroundColor(.textGray)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(Color.textGray.opacity(0.1))
                    .clipShape(Capsule())
            }
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 3)
        .opacity(item.isUnlocked ? 1.0 : 0.55)
    }
}

// MARK: - Empty State

private struct AchievementEmptyStateView: View {
    var body: some View {
        VStack(spacing: 12) {
            Text("表示する実績がありません")
                .font(.system(size: 15, weight: .semibold, design: .rounded))
                .foregroundColor(.textDark)
            Text("学習を続けて実績を解除しよう！")
                .font(.system(size: 13, weight: .regular, design: .rounded))
                .foregroundColor(.textGray)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 40)
    }
}

#Preview {
    CollectionView()
        .environmentObject(AppState())
}
