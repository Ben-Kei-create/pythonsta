//
//  RankingView.swift
//  pythonsta
//
//  Created by 茂木史明 on 2026/06/05.
//

import SwiftUI

// MARK: - RankingView

struct RankingView: View {
    @EnvironmentObject var appState: AppState

    @State private var selectedSegment: Int = 0
    private let users: [RankingUser] = RankingUser.previewList

    private var currentUser: RankingUser? {
        users.first(where: { $0.isCurrentUser })
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            Color.appBackground.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    RankingHeaderView()
                        .padding(.horizontal, 20)
                        .padding(.top, 16)

                    RankingSegmentControl(selectedSegment: $selectedSegment)
                        .padding(.horizontal, 20)

                    if let me = currentUser {
                        UserRankSummaryCard(user: me, nextUser: userAbove(me))
                            .padding(.horizontal, 20)
                    }

                    if users.isEmpty {
                        RankingEmptyStateView()
                            .padding(.horizontal, 20)
                            .padding(.top, 16)
                    } else {
                        TopThreeRankingCard(top3: Array(users.prefix(3)))
                            .padding(.horizontal, 20)

                        VStack(spacing: 10) {
                            ForEach(users.dropFirst(3)) { user in
                                RankingRowView(user: user)
                            }
                        }
                        .padding(.horizontal, 20)
                    }

                    Spacer().frame(height: 100)
                }
            }

            AppTabBar(selectedIndex: 1) { index in
                switch index {
                case 0: appState.navigate(to: .home)
                case 2: appState.navigate(to: .collection)
                case 3: appState.navigate(to: .profile)
                default: break
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 28)
        }
    }

    private func userAbove(_ user: RankingUser) -> RankingUser? {
        guard user.rank > 1 else { return nil }
        return users.first(where: { $0.rank == user.rank - 1 })
    }
}

// MARK: - Header

private struct RankingHeaderView: View {
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 2) {
                Text("ランキング")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundColor(.textDark)
                Text("今週の学習ランキング")
                    .font(.system(size: 13, weight: .regular, design: .rounded))
                    .foregroundColor(.textGray)
            }
            Spacer()
            Image(systemName: "chart.bar.fill")
                .font(.system(size: 18))
                .foregroundColor(.textGray)
                .frame(width: 40, height: 40)
                .background(Color.white)
                .cornerRadius(12)
                .shadow(color: .black.opacity(0.05), radius: 6, x: 0, y: 2)
        }
    }
}

// MARK: - Segment Control

private struct RankingSegmentControl: View {
    @Binding var selectedSegment: Int
    private let labels = ["今週", "フレンド", "全国"]

    var body: some View {
        HStack(spacing: 0) {
            ForEach(labels.indices, id: \.self) { index in
                Button {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        selectedSegment = index
                    }
                } label: {
                    Text(labels[index])
                        .font(.system(size: 13, weight: .semibold, design: .rounded))
                        .foregroundColor(selectedSegment == index ? .white : .textGray)
                        .frame(maxWidth: .infinity)
                        .frame(height: 36)
                        .background(
                            selectedSegment == index
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

// MARK: - User Rank Summary Card

private struct UserRankSummaryCard: View {
    let user: RankingUser
    let nextUser: RankingUser?

    var body: some View {
        FloatingCard {
            HStack(spacing: 16) {
                // Rank badge
                ZStack {
                    Circle()
                        .fill(Color.primaryPurple.opacity(0.12))
                        .frame(width: 52, height: 52)
                    Text("\(user.rank)位")
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundColor(.primaryPurple)
                        .minimumScaleFactor(0.8)
                        .lineLimit(1)
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text("あなたの順位")
                        .font(.system(size: 11, weight: .regular, design: .rounded))
                        .foregroundColor(.textGray)
                    Text("\(user.weeklyXP) XP 今週")
                        .font(.system(size: 17, weight: .bold, design: .rounded))
                        .foregroundColor(.textDark)
                        .minimumScaleFactor(0.85)
                        .lineLimit(1)
                    if let next = nextUser {
                        let diff = next.weeklyXP - user.weeklyXP
                        Text("\(next.displayName)まで \(diff) XP")
                            .font(.system(size: 11, weight: .medium, design: .rounded))
                            .foregroundColor(.textGray)
                            .minimumScaleFactor(0.8)
                            .lineLimit(1)
                    } else {
                        Text("トップランク！")
                            .font(.system(size: 11, weight: .semibold, design: .rounded))
                            .foregroundColor(.warmYellow)
                    }
                }

                Spacer(minLength: 0)

                VStack(alignment: .trailing, spacing: 4) {
                    Text("\(user.streakDays)日")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .foregroundColor(Color(hex: "#FF8C42"))
                        .minimumScaleFactor(0.8)
                        .lineLimit(1)
                    Text("連続学習")
                        .font(.system(size: 10, weight: .regular, design: .rounded))
                        .foregroundColor(.textGray)
                }
            }
            .padding(16)
        }
    }
}

// MARK: - Top Three Card

private struct TopThreeRankingCard: View {
    let top3: [RankingUser]

    var body: some View {
        FloatingCard {
            VStack(spacing: 0) {
                Text("トップ3")
                    .font(.system(size: 13, weight: .semibold, design: .rounded))
                    .foregroundColor(.textGray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                    .padding(.top, 14)
                    .padding(.bottom, 12)

                HStack(alignment: .top, spacing: 8) {
                    if top3.count > 1 {
                        TopRankColumn(user: top3[1], rankLabel: "2位")
                    }
                    if top3.count > 0 {
                        TopRankColumn(user: top3[0], rankLabel: "1位", isFirst: true)
                    }
                    if top3.count > 2 {
                        TopRankColumn(user: top3[2], rankLabel: "3位")
                    }
                }
                .padding(.horizontal, 12)
                .padding(.bottom, 16)
            }
        }
    }
}

private struct TopRankColumn: View {
    let user: RankingUser
    let rankLabel: String
    var isFirst: Bool = false

    var body: some View {
        VStack(spacing: 8) {
            Text(rankLabel)
                .font(.system(size: 12, weight: .bold, design: .rounded))
                .foregroundColor(isFirst ? .primaryPurple : .textGray)
                .minimumScaleFactor(0.85)
                .lineLimit(1)

            // Profile image placeholder — text only
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(
                        user.isCurrentUser
                            ? Color.primaryPurple.opacity(0.12)
                            : Color.appBackground
                    )
                    .frame(width: 52, height: 52)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .strokeBorder(
                                user.isCurrentUser ? Color.primaryPurple.opacity(0.4) : Color.clear,
                                lineWidth: 2
                            )
                    )
                Text("[Profile\nImage]")
                    .font(.system(size: 8, weight: .medium, design: .rounded))
                    .foregroundColor(.textGray.opacity(0.5))
                    .multilineTextAlignment(.center)
            }

            Text(user.displayName)
                .font(.system(size: 11, weight: .bold, design: .rounded))
                .foregroundColor(.textDark)
                .minimumScaleFactor(0.75)
                .lineLimit(1)
                .frame(maxWidth: .infinity)

            Text("\(user.weeklyXP) XP")
                .font(.system(size: 10, weight: .medium, design: .rounded))
                .foregroundColor(.textGray)
                .minimumScaleFactor(0.8)
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(
            isFirst ? Color.primaryPurple.opacity(0.05) : Color.appBackground
        )
        .cornerRadius(12)
    }
}

// MARK: - Ranking Row (rank 4+)

struct RankingRowView: View {
    let user: RankingUser

    var body: some View {
        HStack(spacing: 12) {
            // Rank number
            Text("\(user.rank)")
                .font(.system(size: 15, weight: .bold, design: .rounded))
                .foregroundColor(user.isCurrentUser ? .primaryPurple : .textGray)
                .frame(width: 28, alignment: .center)

            // Profile image placeholder — text only
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(
                        user.isCurrentUser
                            ? Color.primaryPurple.opacity(0.1)
                            : Color.appBackground
                    )
                    .frame(width: 40, height: 40)
                Text("[Profile\nImage]")
                    .font(.system(size: 7, weight: .medium, design: .rounded))
                    .foregroundColor(.textGray.opacity(0.45))
                    .multilineTextAlignment(.center)
            }

            VStack(alignment: .leading, spacing: 2) {
                HStack(spacing: 6) {
                    Text(user.displayName)
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                        .foregroundColor(user.isCurrentUser ? .primaryPurple : .textDark)
                        .minimumScaleFactor(0.85)
                        .lineLimit(1)
                    if user.isCurrentUser {
                        Text("あなた")
                            .font(.system(size: 10, weight: .bold, design: .rounded))
                            .foregroundColor(.primaryPurple)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(Color.primaryPurple.opacity(0.1))
                            .clipShape(Capsule())
                    }
                }
                Text(user.username)
                    .font(.system(size: 11, weight: .regular, design: .rounded))
                    .foregroundColor(.textGray)
                    .minimumScaleFactor(0.85)
                    .lineLimit(1)
            }

            Spacer(minLength: 0)

            VStack(alignment: .trailing, spacing: 2) {
                Text("\(user.weeklyXP) XP")
                    .font(.system(size: 14, weight: .bold, design: .rounded))
                    .foregroundColor(user.isCurrentUser ? .primaryPurple : .textDark)
                    .minimumScaleFactor(0.8)
                    .lineLimit(1)
                Text("\(user.streakDays)日連続")
                    .font(.system(size: 10, weight: .regular, design: .rounded))
                    .foregroundColor(.textGray)
                    .lineLimit(1)
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(
            user.isCurrentUser
                ? Color.primaryPurple.opacity(0.05)
                : Color.white
        )
        .cornerRadius(14)
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .strokeBorder(
                    user.isCurrentUser ? Color.primaryPurple.opacity(0.2) : Color.clear,
                    lineWidth: 1
                )
        )
        .shadow(color: .black.opacity(user.isCurrentUser ? 0.04 : 0.03), radius: 6, x: 0, y: 2)
    }
}

// MARK: - Empty State

private struct RankingEmptyStateView: View {
    var body: some View {
        VStack(spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.primaryPurple.opacity(0.06))
                    .frame(width: 100, height: 100)
                Text("[Ranking\nIllustration]")
                    .font(.system(size: 10, weight: .medium, design: .rounded))
                    .foregroundColor(.primaryPurple.opacity(0.35))
                    .multilineTextAlignment(.center)
            }
            Text("まだランキングデータがありません")
                .font(.system(size: 15, weight: .semibold, design: .rounded))
                .foregroundColor(.textDark)
            Text("学習を続けてランキングに登場しよう！")
                .font(.system(size: 13, weight: .regular, design: .rounded))
                .foregroundColor(.textGray)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 40)
    }
}

#Preview {
    RankingView()
        .environmentObject(AppState())
}
