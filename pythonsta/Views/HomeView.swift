//
//  HomeView.swift
//  pythonsta
//
//  Created by 茂木史明 on 2026/06/05.
//

import SwiftUI

// MARK: - Data models

private struct LessonNode: Identifiable {
    let id: Int
    let label: String
    let sublabel: String
    let state: NodeState
}

private enum NodeState {
    case completed, current, locked
    // .perfect is reserved for future per-lesson accuracy tracking
    // (e.g. all questions answered correctly on the first attempt).
    // nodeState() does not yet return .perfect; LessonNodeView handles it
    // defensively so it will render correctly when the feature is added.
    case perfect
}

private struct LessonSection: Identifiable {
    let id: Int
    let title: String
    let nodes: [LessonNode]
}

private struct Achievement: Identifiable {
    let id: Int
    let title: String
    let description: String
    let color: Color
    let earned: Bool
}

private let achievements: [Achievement] = [
    Achievement(id: 0, title: "7日連続達成", description: "7日間連続で学習！",    color: .warmYellow,    earned: true),
    Achievement(id: 1, title: "最初のコード", description: "初めてのprint()",  color: .successGreen,  earned: true),
    Achievement(id: 2, title: "100XP達成",   description: "XP100を超えた",     color: .primaryPurple, earned: true),
    Achievement(id: 3, title: "関数マスター", description: "関数を完全攻略",    color: .appTeal,       earned: false),
    Achievement(id: 4, title: "完璧主義者",  description: "全問正解で完了",     color: .errorRed,      earned: false),
]

// MARK: - HomeView

struct HomeView: View {
    @EnvironmentObject var appState: AppState
    @State private var selectedTab: Int = 0

    var body: some View {
        ZStack(alignment: .bottom) {
            Color.appBackground.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    HomeHeader()
                        .padding(.horizontal, 20)
                        .padding(.top, 16)

                    DailyProgressCard(progress: appState.progress)
                        .padding(.horizontal, 20)

                    ReviewQueueCard(
                        reviewCount: appState.progress.reviewQuestionIDs.count,
                        onStartReview: { appState.startReview() }
                    )
                    .padding(.horizontal, 20)

                    BookmarkedQuestionsCard(
                        bookmarkCount: appState.progress.bookmarkedQuestionIDs.count,
                        onViewBookmarks: { appState.startBookmarkPractice() }
                    )
                    .padding(.horizontal, 20)

                    // v1: displays the first course as a single linear learning path.
                    // courses[0] is safe — LessonDataSource.courses is a non-empty static constant.
                    // Multi-course navigation (e.g. a course selection screen) is planned for a future sprint.
                    LearningPathSection(
                        course: LessonDataSource.courses[0],
                        completedCount: appState.progress.completedLessons,
                        onStartLesson: { lesson in appState.startLesson(lesson) }
                    )
                    .padding(.horizontal, 20)

                    AchievementsSection()

                    Spacer().frame(height: 100)
                }
            }

            AppTabBar(selectedIndex: selectedTab) { index in
                switch index {
                case 1: appState.navigate(to: .ranking)
                case 2: appState.navigate(to: .collection)
                case 3: appState.navigate(to: .profile)
                default: selectedTab = index
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 28)
        }
    }
}

// MARK: - Header

private struct HomeHeader: View {
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 2) {
                Text("おかえり！")
                    .font(.system(size: 26, weight: .bold, design: .rounded))
                    .foregroundColor(.textDark)
                Text("今日も学ぼう！")
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                    .foregroundColor(.textGray)
            }

            Spacer()

            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.primaryPurple.opacity(0.1))
                    .frame(width: 60, height: 60)
                Text("[Pyro\nMascot]")
                    .font(.system(size: 9, weight: .medium, design: .rounded))
                    .foregroundColor(.primaryPurple.opacity(0.6))
                    .multilineTextAlignment(.center)
            }
        }
    }
}

// MARK: - Daily Progress Card

private struct DailyProgressCard: View {
    let progress: UserProgress

    // Daily goal = 10 questions (≈ 1 lesson per day, 8–15 min session).
    // Reaching the goal fills the progress bar and marks the badge complete,
    // but does NOT cap learning. dailyCompletedQuestions accumulates freely;
    // extra questions still grant XP, gems, and lesson unlocks.
    // AD POLICY: interstitial ads appear only after a lesson/session completes
    // (ResultView), never between questions. Premium = no interstitial ads.
    private let dailyGoal = 10

    private var dailyFraction: Double {
        min(Double(progress.dailyCompletedQuestions) / Double(dailyGoal), 1.0)
    }

    var body: some View {
        FloatingCard {
            VStack(alignment: .leading, spacing: 16) {
                Text("今日の進捗")
                    .font(.system(size: 13, weight: .semibold, design: .rounded))
                    .foregroundColor(.textGray)

                HStack(alignment: .firstTextBaseline, spacing: 4) {
                    Text("\(progress.dailyCompletedQuestions)")
                        .font(.system(size: 42, weight: .bold, design: .rounded))
                        .foregroundColor(.textDark)
                    Text("/ \(dailyGoal) 問 完了")
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                        .foregroundColor(.textGray)
                        .padding(.bottom, 4)
                }

                RoundedProgressBar(value: dailyFraction, color: .primaryPurple, height: 10)

                HStack(spacing: 0) {
                    StatItem(icon: "🔥", value: "\(progress.currentStreak)日", label: "連続")
                    Divider().frame(height: 32)
                    StatItem(icon: "⭐", value: "\(progress.totalXP)",         label: "XP")
                    Divider().frame(height: 32)
                    StatItem(icon: "💎", value: "\(progress.gems)",            label: "Gems")
                }
                .padding(.top, 4)
            }
            .padding(20)
        }
    }
}

private struct StatItem: View {
    let icon: String
    let value: String
    let label: String

    var body: some View {
        VStack(spacing: 2) {
            HStack(spacing: 4) {
                Text(icon).font(.system(size: 16))
                Text(value)
                    .font(.system(size: 17, weight: .bold, design: .rounded))
                    .foregroundColor(.textDark)
            }
            Text(label)
                .font(.system(size: 11, weight: .regular, design: .rounded))
                .foregroundColor(.textGray)
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Review Queue

// Surfaces questions answered incorrectly and queued via
// AppState.addQuestionToReview(). Tapping "復習する" starts Review Mode
// (AppState.startReview() → ReviewView) when the queue has items.
private struct ReviewQueueCard: View {
    let reviewCount: Int
    let onStartReview: () -> Void

    var body: some View {
        FloatingCard {
            VStack(alignment: .leading, spacing: 14) {
                Text("今日の復習")
                    .font(.system(size: 13, weight: .semibold, design: .rounded))
                    .foregroundColor(.textGray)

                if reviewCount > 0 {
                    HStack(alignment: .center, spacing: 16) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("復習が必要な問題があります")
                                .font(.system(size: 15, weight: .bold, design: .rounded))
                                .foregroundColor(.textDark)
                            Text("\(reviewCount)問")
                                .font(.system(size: 22, weight: .bold, design: .rounded))
                                .foregroundColor(.primaryPurple)
                        }

                        Spacer()

                        Button(action: onStartReview) {
                            Text("復習する")
                                .font(.system(size: 14, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 12)
                                .background(Color.primaryPurple)
                                .clipShape(Capsule())
                        }
                    }
                } else {
                    Text("復習はありません")
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                        .foregroundColor(.textGray)
                }
            }
            .padding(20)
        }
    }
}

// MARK: - Bookmarked Questions

// Surfaces the count of manually bookmarked questions and, once Bookmark
// Mode has content to show, a "見る" button that opens BookmarkView.
private struct BookmarkedQuestionsCard: View {
    let bookmarkCount: Int
    let onViewBookmarks: () -> Void

    var body: some View {
        FloatingCard {
            VStack(alignment: .leading, spacing: 14) {
                Text("保存した問題")
                    .font(.system(size: 13, weight: .semibold, design: .rounded))
                    .foregroundColor(.textGray)

                if bookmarkCount > 0 {
                    HStack(alignment: .center, spacing: 16) {
                        Text("\(bookmarkCount)問")
                            .font(.system(size: 22, weight: .bold, design: .rounded))
                            .foregroundColor(.primaryPurple)

                        Spacer()

                        Button(action: onViewBookmarks) {
                            Text("見る")
                                .font(.system(size: 14, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 12)
                                .background(Color.primaryPurple)
                                .clipShape(Capsule())
                        }
                    }
                } else {
                    Text("保存した問題はありません")
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                        .foregroundColor(.textGray)
                }
            }
            .padding(20)
        }
    }
}

// MARK: - Learning Path

private struct LearningPathSection: View {
    let course: Course
    let completedCount: Int
    let onStartLesson: (Lesson) -> Void

    private let offsets: [CGFloat] = [-44, 0, 44, 0, -44, 0, 44, 0, -44, 0]

    private var sections: [LessonSection] {
        var categoryOrder: [String] = []
        var categoryMap: [String: [Lesson]] = [:]
        for lesson in course.lessons {
            if categoryMap[lesson.category] == nil {
                categoryOrder.append(lesson.category)
                categoryMap[lesson.category] = []
            }
            categoryMap[lesson.category]!.append(lesson)
        }
        return categoryOrder.enumerated().map { sectionIndex, category in
            let lessons = categoryMap[category] ?? []
            let nodes = lessons.map { lesson in
                LessonNode(
                    id: lesson.id,
                    label: lesson.shortLabel,
                    sublabel: lesson.subtitle,
                    state: nodeState(for: lesson.order)
                )
            }
            return LessonSection(id: sectionIndex, title: category, nodes: nodes)
        }
    }

    private func nodeState(for order: Int) -> NodeState {
        if order < completedCount { return .completed }
        if order == completedCount { return .current }
        return .locked
    }

    var body: some View {
        VStack(spacing: 0) {
            ForEach(Array(sections.enumerated()), id: \.offset) { sIndex, section in
                SectionLabel(title: section.title)
                    .padding(.bottom, 20)

                ForEach(Array(section.nodes.enumerated()), id: \.element.id) { nIndex, node in
                    let globalIndex = sections.prefix(sIndex).flatMap { $0.nodes }.count + nIndex
                    let xOffset = offsets[min(globalIndex, offsets.count - 1)]
                    let isLast = (nIndex == section.nodes.count - 1) && (sIndex == sections.count - 1)

                    VStack(spacing: 0) {
                        LessonNodeView(node: node, onTap: {
                            if node.state == .current {
                                if let lesson = course.lessons.first(where: { $0.id == node.id }) {
                                    onStartLesson(lesson)
                                }
                            }
                        })
                        .offset(x: xOffset)

                        if !isLast {
                            ConnectorLine(
                                fromOffset: xOffset,
                                toOffset: offsets[min(globalIndex + 1, offsets.count - 1)]
                            )
                        }
                    }
                }

                if sIndex < sections.count - 1 {
                    Spacer().frame(height: 8)
                }
            }
        }
    }
}

private struct SectionLabel: View {
    let title: String

    var body: some View {
        HStack {
            Spacer()
            Text(title)
                .font(.system(size: 12, weight: .semibold, design: .rounded))
                .foregroundColor(.primaryPurple)
                .padding(.horizontal, 14)
                .padding(.vertical, 6)
                .background(Color.primaryPurple.opacity(0.1))
                .clipShape(Capsule())
            Spacer()
        }
    }
}

private struct ConnectorLine: View {
    let fromOffset: CGFloat
    let toOffset: CGFloat

    var body: some View {
        GeometryReader { geo in
            let midX = geo.size.width / 2
            let startX = midX + fromOffset
            let endX   = midX + toOffset
            let height = geo.size.height

            Path { path in
                path.move(to: CGPoint(x: startX, y: 0))
                path.addCurve(
                    to: CGPoint(x: endX, y: height),
                    control1: CGPoint(x: startX, y: height * 0.5),
                    control2: CGPoint(x: endX,   y: height * 0.5)
                )
            }
            .stroke(
                Color.primaryPurple.opacity(0.2),
                style: StrokeStyle(lineWidth: 3, lineCap: .round, dash: [6, 5])
            )
        }
        .frame(height: 48)
    }
}

private struct LessonNodeView: View {
    let node: LessonNode
    let onTap: () -> Void

    @State private var pulsing = false
    @State private var pressed = false

    private let size: CGFloat = 80

    var body: some View {
        Button(action: onTap) {
            ZStack {
                // Glow ring for current
                if node.state == .current {
                    Circle()
                        .fill(Color.primaryPurple.opacity(pulsing ? 0.18 : 0.06))
                        .frame(width: size + 24, height: size + 24)
                        .animation(.easeInOut(duration: 1.4).repeatForever(autoreverses: true), value: pulsing)
                }

                // Gold ring for perfect
                if node.state == .perfect {
                    Circle()
                        .strokeBorder(Color.warmYellow, lineWidth: 3)
                        .frame(width: size + 8, height: size + 8)
                }

                // Main circle
                Circle()
                    .fill(nodeBackground)
                    .frame(width: size, height: size)
                    .shadow(color: nodeShadowColor.opacity(0.3), radius: node.state == .current ? 12 : 6, x: 0, y: 4)

                // Icon
                nodeIcon
            }
        }
        .scaleEffect(pressed ? 0.93 : 1.0)
        .animation(.spring(response: 0.25, dampingFraction: 0.6), value: pressed)
        .buttonStyle(PlainButtonStyle())
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in pressed = true }
                .onEnded   { _ in pressed = false }
        )
        .onAppear {
            if node.state == .current { pulsing = true }
        }
    }

    private var nodeBackground: Color {
        switch node.state {
        case .completed: return .successGreen
        case .perfect:   return Color(hex: "#FFB800")
        case .current:   return .primaryPurple
        case .locked:    return Color(hex: "#E4E7EF")
        }
    }

    private var nodeShadowColor: Color {
        switch node.state {
        case .completed: return .successGreen
        case .perfect:   return .warmYellow
        case .current:   return .primaryPurple
        case .locked:    return .clear
        }
    }

    @ViewBuilder
    private var nodeIcon: some View {
        VStack(spacing: 2) {
            switch node.state {
            case .completed:
                Image(systemName: "checkmark")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
            case .perfect:
                Image(systemName: "checkmark")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
            case .current:
                Text(node.label)
                    .font(.system(size: 14, weight: .bold, design: .monospaced))
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                    .padding(.horizontal, 6)
            case .locked:
                Image(systemName: "lock.fill")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(Color.textGray.opacity(0.5))
            }

            if node.state == .current {
                Text(node.sublabel)
                    .font(.system(size: 9, weight: .medium, design: .rounded))
                    .foregroundColor(.white.opacity(0.8))
            }
        }
    }
}

// MARK: - Achievements

private struct AchievementsSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("実績")
                .font(.system(size: 17, weight: .bold, design: .rounded))
                .foregroundColor(.textDark)
                .padding(.horizontal, 20)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    Spacer().frame(width: 8)
                    ForEach(achievements) { achievement in
                        AchievementCard(achievement: achievement)
                    }
                    Spacer().frame(width: 8)
                }
            }
        }
    }
}

private struct AchievementCard: View {
    let achievement: Achievement

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Artwork placeholder
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(achievement.earned
                          ? achievement.color.opacity(0.15)
                          : Color.textGray.opacity(0.08))
                    .frame(height: 72)
                Text("[Achievement\nArtwork]")
                    .font(.system(size: 9, weight: .medium, design: .rounded))
                    .foregroundColor(achievement.earned
                                     ? achievement.color.opacity(0.5)
                                     : Color.textGray.opacity(0.3))
                    .multilineTextAlignment(.center)

                if !achievement.earned {
                    Image(systemName: "lock.fill")
                        .font(.system(size: 18))
                        .foregroundColor(Color.textGray.opacity(0.25))
                }
            }

            Text(achievement.title)
                .font(.system(size: 13, weight: .bold, design: .rounded))
                .foregroundColor(achievement.earned ? .textDark : .textGray)

            Text(achievement.description)
                .font(.system(size: 11, weight: .regular, design: .rounded))
                .foregroundColor(.textGray)
                .lineLimit(2)
        }
        .padding(14)
        .frame(width: 130)
        .background(Color.white)
        .cornerRadius(18)
        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 4)
        .opacity(achievement.earned ? 1 : 0.6)
    }
}


#Preview {
    HomeView()
        .environmentObject(AppState())
}
