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
    case completed, current, locked, perfect
}

private struct LessonSection: Identifiable {
    let id: Int
    let title: String
    let nodes: [LessonNode]
}

private let learningPath: [LessonSection] = [
    LessonSection(id: 0, title: "Python基礎", nodes: [
        LessonNode(id: 0,  label: "print()",  sublabel: "出力",   state: .perfect),
        LessonNode(id: 1,  label: "変数",      sublabel: "データ保存", state: .completed),
        LessonNode(id: 2,  label: "データ型",  sublabel: "種類",   state: .current),
    ]),
    LessonSection(id: 1, title: "条件分岐", nodes: [
        LessonNode(id: 3,  label: "if文",      sublabel: "判断",   state: .locked),
        LessonNode(id: 4,  label: "比較",      sublabel: "演算子", state: .locked),
    ]),
    LessonSection(id: 2, title: "繰り返し", nodes: [
        LessonNode(id: 5,  label: "for文",     sublabel: "ループ", state: .locked),
        LessonNode(id: 6,  label: "while",     sublabel: "条件",  state: .locked),
    ]),
    LessonSection(id: 3, title: "関数", nodes: [
        LessonNode(id: 7,  label: "関数",      sublabel: "def",   state: .locked),
        LessonNode(id: 8,  label: "引数",      sublabel: "値渡し", state: .locked),
    ]),
]

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

                    DailyProgressCard()
                        .padding(.horizontal, 20)

                    LearningPathSection(onStartLesson: {
                        appState.navigate(to: .lesson)
                    })
                    .padding(.horizontal, 20)

                    AchievementsSection()

                    Spacer().frame(height: 100)
                }
            }

            AppTabBar(selectedIndex: selectedTab) { index in
                if index == 3 {
                    appState.navigate(to: .profile)
                } else {
                    selectedTab = index
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
    var body: some View {
        FloatingCard {
            VStack(alignment: .leading, spacing: 16) {
                // Title
                Text("今日の進捗")
                    .font(.system(size: 13, weight: .semibold, design: .rounded))
                    .foregroundColor(.textGray)

                // Lesson count
                HStack(alignment: .firstTextBaseline, spacing: 4) {
                    Text("3")
                        .font(.system(size: 42, weight: .bold, design: .rounded))
                        .foregroundColor(.textDark)
                    Text("/ 5 レッスン完了")
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                        .foregroundColor(.textGray)
                        .padding(.bottom, 4)
                }

                // Progress bar
                RoundedProgressBar(value: 0.6, color: .primaryPurple, height: 10)

                // Stats row
                HStack(spacing: 0) {
                    StatItem(icon: "🔥", value: "12日",    label: "連続")
                    Divider().frame(height: 32)
                    StatItem(icon: "⭐", value: "2,450",   label: "XP")
                    Divider().frame(height: 32)
                    StatItem(icon: "💎", value: "180",     label: "Gems")
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

// MARK: - Learning Path

private struct LearningPathSection: View {
    let onStartLesson: () -> Void

    // Alternating horizontal offsets for a playful zigzag
    private let offsets: [CGFloat] = [-44, 0, 44, 0, -44, 0, 44, 0, -44, 0]

    var body: some View {
        VStack(spacing: 0) {
            ForEach(Array(learningPath.enumerated()), id: \.offset) { sIndex, section in
                // Section label
                SectionLabel(title: section.title)
                    .padding(.bottom, 20)

                // Nodes in this section
                ForEach(Array(section.nodes.enumerated()), id: \.element.id) { nIndex, node in
                    let globalIndex = learningPath.prefix(sIndex).flatMap { $0.nodes }.count + nIndex
                    let xOffset = offsets[min(globalIndex, offsets.count - 1)]
                    let isLast = (nIndex == section.nodes.count - 1) && (sIndex == learningPath.count - 1)

                    VStack(spacing: 0) {
                        LessonNodeView(node: node, onTap: {
                            if node.state == .current { onStartLesson() }
                        })
                        .offset(x: xOffset)

                        if !isLast {
                            ConnectorLine(
                                fromOffset: xOffset,
                                toOffset: nextOffset(globalIndex: globalIndex, sectionIndex: sIndex, nodeIndex: nIndex, section: section)
                            )
                        }
                    }
                }

                if sIndex < learningPath.count - 1 {
                    Spacer().frame(height: 8)
                }
            }
        }
    }

    private func nextOffset(globalIndex: Int, sectionIndex: Int, nodeIndex: Int, section: LessonSection) -> CGFloat {
        let nextGlobal = globalIndex + 1
        return offsets[min(nextGlobal, offsets.count - 1)]
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
