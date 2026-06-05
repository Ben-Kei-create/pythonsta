//
//  HomeView.swift
//  pythonsta
//
//  Created by 茂木史明 on 2026/06/05.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appState: AppState
    @State private var selectedTab: Int = 0

    var body: some View {
        VStack(spacing: 0) {
            // Header
            HomeHeader()
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 12)

            // Scrollable content
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    // Greeting
                    Text("今日もがんばろう！")
                        .font(AppFonts.title)
                        .foregroundColor(.textDark)

                    // Daily goal card
                    DailyGoalCard()

                    // Roadmap section
                    Text("学習ロードマップ")
                        .font(AppFonts.headline)
                        .foregroundColor(.textDark)

                    RoadmapList(onStartLesson: {
                        appState.navigate(to: .lesson)
                    })
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }

            // Bottom tab bar
            BottomTabBar(selectedTab: $selectedTab)
        }
        .background(Color.appBackground.ignoresSafeArea())
    }
}

// MARK: - Header

private struct HomeHeader: View {
    var body: some View {
        HStack {
            Text("PythonSta")
                .font(AppFonts.headline)
                .foregroundColor(.primaryPurple)

            Spacer()

            HStack(spacing: 8) {
                StatChip(icon: "🔥", value: "12",  color: .warmYellow)
                StatChip(icon: "💎", value: "340", color: .appTeal)

                Circle()
                    .fill(Color.primaryPurple.opacity(0.2))
                    .frame(width: 36, height: 36)
                    .overlay(Text("👤").font(.system(size: 16)))
            }
        }
    }
}

// MARK: - Daily Goal Card

private struct DailyGoalCard: View {
    var body: some View {
        FloatingCard {
            HStack(alignment: .top, spacing: 12) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("今日の目標")
                        .font(AppFonts.caption)
                        .foregroundColor(.textGray)

                    Text("20 / 30 XP")
                        .font(AppFonts.title)
                        .foregroundColor(.textDark)

                    RoundedProgressBar(value: 0.67, color: .primaryPurple)
                        .frame(width: 180)
                }

                Spacer()

                MascotPlaceholder(size: 72)
            }
            .padding(20)
        }
    }
}

// MARK: - Roadmap list

private struct RoadmapList: View {
    let onStartLesson: () -> Void

    private let lessons: [(title: String, subtitle: String, status: LessonStatus)] = [
        ("1. Pythonってなに？",   "完了！",    .completed),
        ("2. 変数とデータ型",     "進行中...", .inProgress(0.6)),
        ("3. 条件分岐",           "未ロック",  .locked),
        ("4. 繰り返し処理",       "未ロック",  .locked),
    ]

    var body: some View {
        VStack(spacing: 0) {
            ForEach(Array(lessons.enumerated()), id: \.offset) { index, lesson in
                VStack(spacing: 0) {
                    LessonRowView(
                        title: lesson.title,
                        subtitle: lesson.subtitle,
                        status: lesson.status,
                        onTap: lesson.status != .locked ? onStartLesson : nil
                    )

                    if index < lessons.count - 1 {
                        HStack {
                            Rectangle()
                                .fill(Color.primaryPurple.opacity(0.2))
                                .frame(width: 2, height: 16)
                                .padding(.leading, 30)
                            Spacer()
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Lesson status

private enum LessonStatus: Equatable {
    case completed
    case inProgress(Double)
    case locked

    static func == (lhs: LessonStatus, rhs: LessonStatus) -> Bool {
        switch (lhs, rhs) {
        case (.completed, .completed): return true
        case (.locked, .locked):       return true
        case (.inProgress(let a), .inProgress(let b)): return a == b
        default: return false
        }
    }
}

private struct LessonRowView: View {
    let title: String
    let subtitle: String
    let status: LessonStatus
    let onTap: (() -> Void)?

    var body: some View {
        FloatingCard {
            HStack(spacing: 14) {
                // Status dot
                statusDot

                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(AppFonts.headline)
                        .foregroundColor(status == .locked ? .textGray : .textDark)

                    Text(subtitle)
                        .font(AppFonts.caption)
                        .foregroundColor(.textGray)
                }

                Spacer()

                statusBadge
            }
            .padding(16)
        }
        .onTapGesture {
            onTap?()
        }
    }

    private var statusDot: some View {
        Circle()
            .fill(dotColor)
            .frame(width: 14, height: 14)
            .overlay(
                Circle()
                    .strokeBorder(dotColor.opacity(0.3), lineWidth: 4)
                    .frame(width: 22, height: 22)
            )
    }

    private var dotColor: Color {
        switch status {
        case .completed:       return .successGreen
        case .inProgress:      return .primaryPurple
        case .locked:          return Color.textGray.opacity(0.4)
        }
    }

    @ViewBuilder
    private var statusBadge: some View {
        switch status {
        case .completed:
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(.successGreen)
                .font(.system(size: 22))

        case .inProgress(let pct):
            ZStack {
                Circle()
                    .stroke(Color.primaryPurple.opacity(0.2), lineWidth: 3)
                Circle()
                    .trim(from: 0, to: pct)
                    .stroke(Color.primaryPurple, style: StrokeStyle(lineWidth: 3, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                Text("\(Int(pct * 100))%")
                    .font(AppFonts.caption)
                    .foregroundColor(.primaryPurple)
            }
            .frame(width: 40, height: 40)

        case .locked:
            Image(systemName: "lock.fill")
                .foregroundColor(.textGray.opacity(0.5))
                .font(.system(size: 18))
        }
    }
}

// MARK: - Bottom Tab Bar

private struct BottomTabBar: View {
    @Binding var selectedTab: Int

    private let tabs: [(icon: String, label: String)] = [
        ("house.fill",        "ホーム"),
        ("book.fill",         "レッスン"),
        ("chevron.left.forwardslash.chevron.right", "コード"),
        ("star.fill",         "実績"),
        ("person.fill",       "プロフィール"),
    ]

    var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(tabs.enumerated()), id: \.offset) { index, tab in
                Button {
                    selectedTab = index
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: tab.icon)
                            .font(.system(size: 20))
                        Text(tab.label)
                            .font(AppFonts.caption)
                    }
                    .foregroundColor(selectedTab == index ? .primaryPurple : .textGray)
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .padding(.top, 12)
        .padding(.bottom, 28)
        .background(
            Color.white
                .shadow(color: .black.opacity(0.06), radius: 12, x: 0, y: -4)
        )
    }
}

#Preview {
    HomeView()
        .environmentObject(AppState())
}
