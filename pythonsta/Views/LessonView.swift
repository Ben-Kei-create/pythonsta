//
//  LessonView.swift
//  pythonsta
//
//  Created by 茂木史明 on 2026/06/05.
//

import SwiftUI

// MARK: - Lesson data

private struct AnswerChoice: Identifiable {
    let id: Int
    let text: String
}

private let answers: [AnswerChoice] = [
    AnswerChoice(id: 0, text: "文字を表示する"),
    AnswerChoice(id: 1, text: "計算する"),
    AnswerChoice(id: 2, text: "保存する"),
    AnswerChoice(id: 3, text: "終了する"),
]

private let correctAnswerID = 0

// MARK: - Answer state

private enum AnswerState {
    case idle, selected(Int), submitted(Int)

    var selectedID: Int? {
        switch self {
        case .selected(let id), .submitted(let id): return id
        default: return nil
        }
    }

    var isSubmitted: Bool {
        if case .submitted = self { return true }
        return false
    }
}

// MARK: - LessonView

struct LessonView: View {
    @EnvironmentObject var appState: AppState

    @State private var answerState: AnswerState = .idle
    @State private var showSheet = false
    @State private var isCorrect = false

    var body: some View {
        ZStack(alignment: .bottom) {
            Color.appBackground.ignoresSafeArea()

            VStack(spacing: 0) {
                // Top bar
                LessonTopBar(onBack: { appState.navigate(to: .home) })
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                    .padding(.bottom, 8)

                // Scrollable content
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 16) {
                        // Main lesson card
                        LessonCard()

                        // Answer choices
                        AnswerArea(
                            answerState: answerState,
                            onSelect: { id in
                                guard !answerState.isSubmitted else { return }
                                withAnimation(.spring(response: 0.25, dampingFraction: 0.7)) {
                                    answerState = .selected(id)
                                }
                            }
                        )
                        .padding(.horizontal, 20)

                        Spacer().frame(height: 100)
                    }
                }

                Spacer(minLength: 0)
            }

            // Fixed bottom button
            VStack(spacing: 0) {
                Spacer()
                ConfirmButton(
                    isEnabled: answerState.selectedID != nil,
                    onTap: submitAnswer
                )
                .padding(.horizontal, 24)
                .padding(.bottom, 36)
            }
            .ignoresSafeArea(edges: .bottom)

            // Result bottom sheet
            if showSheet {
                ResultBottomSheet(
                    isCorrect: isCorrect,
                    onNext: {
                        if isCorrect {
                            appState.navigate(to: .result)
                        } else {
                            withAnimation {
                                showSheet    = false
                                answerState  = .idle
                            }
                        }
                    }
                )
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .zIndex(10)
            }
        }
        .animation(.spring(response: 0.4, dampingFraction: 0.75), value: showSheet)
    }

    private func submitAnswer() {
        guard let selectedID = answerState.selectedID else { return }
        isCorrect = (selectedID == correctAnswerID)
        withAnimation {
            answerState = .submitted(selectedID)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
            withAnimation { showSheet = true }
        }
    }
}

// MARK: - Top Bar

private struct LessonTopBar: View {
    let onBack: () -> Void

    var body: some View {
        HStack(spacing: 14) {
            Button(action: onBack) {
                ZStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 38, height: 38)
                        .shadow(color: .black.opacity(0.06), radius: 6, x: 0, y: 2)
                    Image(systemName: "chevron.left")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.textDark)
                }
            }

            VStack(spacing: 6) {
                HStack {
                    Text("3 / 10")
                        .font(.system(size: 12, weight: .semibold, design: .rounded))
                        .foregroundColor(.textGray)
                    Spacer()
                }
                RoundedProgressBar(value: 0.3, color: .primaryPurple, height: 8)
            }

            HStack(spacing: 3) {
                Text("❤️")
                    .font(.system(size: 14))
                Text("5")
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundColor(.errorRed)
            }
        }
    }
}

// MARK: - Lesson Card

private struct LessonCard: View {
    var body: some View {
        FloatingCard {
            VStack(spacing: 20) {
                // Category pill
                HStack {
                    Text("Python基礎")
                        .font(.system(size: 12, weight: .semibold, design: .rounded))
                        .foregroundColor(.primaryPurple)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 5)
                        .background(Color.primaryPurple.opacity(0.1))
                        .clipShape(Capsule())
                    Spacer()
                }

                // Question text
                Text("print()は\n何をする命令でしょう？")
                    .font(.system(size: 26, weight: .bold, design: .rounded))
                    .foregroundColor(.textDark)
                    .lineSpacing(4)
                    .frame(maxWidth: .infinity, alignment: .leading)

                // Illustration placeholder
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.primaryPurple.opacity(0.06))
                        .frame(height: 148)
                    VStack(spacing: 6) {
                        Text("🖼")
                            .font(.system(size: 36))
                        Text("[Lesson Illustration]")
                            .font(.system(size: 12, weight: .medium, design: .rounded))
                            .foregroundColor(.textGray.opacity(0.6))
                    }
                }

                // Code hint block
                CodeHintBlock()
            }
            .padding(22)
        }
        .padding(.horizontal, 20)
        .padding(.top, 12)
    }
}

private struct CodeHintBlock: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Title strip
            HStack(spacing: 6) {
                ForEach([Color.errorRed, Color.warmYellow, Color.successGreen], id: \.self) { c in
                    Circle().fill(c).frame(width: 8, height: 8)
                }
                Spacer()
                Text("example.py")
                    .font(.system(size: 10, weight: .medium, design: .monospaced))
                    .foregroundColor(.textGray.opacity(0.5))
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 9)
            .background(Color(hex: "#141B2A"))
            .cornerRadius(12, corners: [.topLeft, .topRight])

            // Code
            HStack {
                Group {
                    Text("print")
                        .foregroundColor(Color(hex: "#C792EA"))
                    + Text("(")
                        .foregroundColor(.white.opacity(0.8))
                    + Text("\"Hello, Python!\"")
                        .foregroundColor(.warmYellow)
                    + Text(")")
                        .foregroundColor(.white.opacity(0.8))
                }
                .font(.system(size: 15, weight: .regular, design: .monospaced))
                Spacer()
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 14)
            .background(Color.textDark)
            .cornerRadius(12, corners: [.bottomLeft, .bottomRight])
        }
    }
}

// MARK: - Answer Area

private struct AnswerArea: View {
    let answerState: AnswerState
    let onSelect: (Int) -> Void

    var body: some View {
        VStack(spacing: 10) {
            ForEach(answers) { answer in
                AnswerCard(
                    answer: answer,
                    state: cardState(for: answer.id),
                    onTap: { onSelect(answer.id) }
                )
            }
        }
    }

    private func cardState(for id: Int) -> AnswerCardState {
        switch answerState {
        case .idle:
            return .normal

        case .selected(let selected):
            return id == selected ? .selected : .normal

        case .submitted(let selected):
            if id == selected {
                return id == correctAnswerID ? .correct : .wrong
            }
            if id == correctAnswerID { return .correct }
            return .normal
        }
    }
}

private enum AnswerCardState {
    case normal, selected, correct, wrong
}

private struct AnswerCard: View {
    let answer: AnswerChoice
    let state: AnswerCardState
    let onTap: () -> Void

    @State private var pressed = false

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 12) {
                // State icon
                ZStack {
                    Circle()
                        .fill(iconBackground)
                        .frame(width: 34, height: 34)
                    Image(systemName: iconName)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(iconForeground)
                }

                Text(answer.text)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundColor(textColor)

                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
            .background(background)
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(borderColor, lineWidth: borderWidth)
            )
            .shadow(color: shadowColor.opacity(0.15), radius: 8, x: 0, y: 3)
        }
        .scaleEffect(pressed ? 0.97 : 1.0)
        .animation(.spring(response: 0.2, dampingFraction: 0.6), value: pressed)
        .buttonStyle(PlainButtonStyle())
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in pressed = true }
                .onEnded   { _ in pressed = false }
        )
    }

    private var background: Color {
        switch state {
        case .normal:   return .white
        case .selected: return Color.primaryPurple.opacity(0.05)
        case .correct:  return Color.successGreen.opacity(0.08)
        case .wrong:    return Color.errorRed.opacity(0.06)
        }
    }

    private var borderColor: Color {
        switch state {
        case .normal:   return .clear
        case .selected: return .primaryPurple
        case .correct:  return .successGreen
        case .wrong:    return .errorRed
        }
    }

    private var borderWidth: CGFloat {
        state == .normal ? 0 : 2
    }

    private var textColor: Color {
        switch state {
        case .correct: return .successGreen
        case .wrong:   return .errorRed
        default:       return .textDark
        }
    }

    private var shadowColor: Color {
        switch state {
        case .selected: return .primaryPurple
        case .correct:  return .successGreen
        case .wrong:    return .errorRed
        default:        return .black
        }
    }

    private var iconBackground: Color {
        switch state {
        case .normal:   return Color.appBackground
        case .selected: return Color.primaryPurple.opacity(0.12)
        case .correct:  return Color.successGreen.opacity(0.15)
        case .wrong:    return Color.errorRed.opacity(0.12)
        }
    }

    private var iconName: String {
        switch state {
        case .correct: return "checkmark"
        case .wrong:   return "xmark"
        default:       return "circle"
        }
    }

    private var iconForeground: Color {
        switch state {
        case .normal:   return Color.textGray.opacity(0.3)
        case .selected: return .primaryPurple
        case .correct:  return .successGreen
        case .wrong:    return .errorRed
        }
    }
}

// MARK: - Confirm Button

private struct ConfirmButton: View {
    let isEnabled: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            Text("確認する")
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundColor(isEnabled ? Color(hex: "#1D2433") : Color.textGray)
                .frame(maxWidth: .infinity)
                .frame(height: 60)
                .background(isEnabled ? Color.pythonLime : Color(hex: "#E4E7EF"))
                .clipShape(Capsule())
                .shadow(
                    color: isEnabled ? Color.pythonLime.opacity(0.4) : .clear,
                    radius: 12, x: 0, y: 6
                )
        }
        .disabled(!isEnabled)
        .animation(.easeInOut(duration: 0.2), value: isEnabled)
    }
}

// MARK: - Result Bottom Sheet

private struct ResultBottomSheet: View {
    let isCorrect: Bool
    let onNext: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            VStack(spacing: 0) {
                // Handle
                Capsule()
                    .fill(Color.white.opacity(0.3))
                    .frame(width: 40, height: 4)
                    .padding(.top, 12)

                VStack(spacing: 16) {
                    if isCorrect {
                        CorrectContent(onNext: onNext)
                    } else {
                        WrongContent(onNext: onNext)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 20)
                .padding(.bottom, 40)
            }
            .background(
                isCorrect ? Color(hex: "#1EB87A") : Color(hex: "#E8455A")
            )
            .cornerRadius(32, corners: [.topLeft, .topRight])
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

private struct CorrectContent: View {
    let onNext: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            HStack(alignment: .top, spacing: 16) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("🎉 正解！")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(.white)

                    HStack(spacing: 10) {
                        RewardPill(icon: "🔥", text: "+10 XP")
                        RewardPill(icon: "💎", text: "+1 Gem")
                    }

                    Text("print() は画面に文字を表示するための命令だよ！")
                        .font(.system(size: 14, weight: .regular, design: .rounded))
                        .foregroundColor(.white.opacity(0.9))
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.top, 4)
                }

                Spacer()

                // Pyro mascot placeholder
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white.opacity(0.15))
                        .frame(width: 64, height: 64)
                    Text("[Pyro\nMascot]")
                        .font(.system(size: 9, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.7))
                        .multilineTextAlignment(.center)
                }
            }

            Button(action: onNext) {
                Text("つぎへ →")
                    .font(.system(size: 17, weight: .bold, design: .rounded))
                    .foregroundColor(Color(hex: "#1EB87A"))
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(Color.white)
                    .clipShape(Capsule())
            }
        }
    }
}

private struct WrongContent: View {
    let onNext: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            HStack(alignment: .top, spacing: 16) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("もう一度挑戦しよう！")
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        .foregroundColor(.white)

                    Text("正解は「文字を表示する」だよ。\nprint() はテキストを画面に出力するよ！")
                        .font(.system(size: 14, weight: .regular, design: .rounded))
                        .foregroundColor(.white.opacity(0.9))
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.top, 4)
                }

                Spacer()

                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white.opacity(0.15))
                        .frame(width: 64, height: 64)
                    Text("[Pyro\nMascot]")
                        .font(.system(size: 9, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.7))
                        .multilineTextAlignment(.center)
                }
            }

            Button(action: onNext) {
                Text("やり直す")
                    .font(.system(size: 17, weight: .bold, design: .rounded))
                    .foregroundColor(Color(hex: "#E8455A"))
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(Color.white)
                    .clipShape(Capsule())
            }
        }
    }
}

private struct RewardPill: View {
    let icon: String
    let text: String

    var body: some View {
        HStack(spacing: 4) {
            Text(icon).font(.system(size: 13))
            Text(text)
                .font(.system(size: 13, weight: .bold, design: .rounded))
                .foregroundColor(.white)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .background(Color.white.opacity(0.2))
        .clipShape(Capsule())
    }
}

// MARK: - Corner radius helper (shared)

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

private struct RoundedCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

#Preview {
    LessonView()
        .environmentObject(AppState())
}
