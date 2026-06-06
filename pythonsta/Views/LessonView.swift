//
//  LessonView.swift
//  pythonsta
//
//  Created by 茂木史明 on 2026/06/05.
//

import SwiftUI

// MARK: - Answer state

private enum AnswerState {
    case idle, selected(Int), submitted(Int)

    var selectedIndex: Int? {
        switch self {
        case .selected(let i), .submitted(let i): return i
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

    @State private var currentQuestionIndex: Int = 0
    @State private var answerState: AnswerState = .idle
    @State private var fillAnswer: String = ""
    @State private var fillSubmitted: Bool = false
    @State private var showSheet = false
    @State private var showNoHeartsSheet = false
    @State private var isCorrect = false

    // Session tracking
    @State private var earnedXP: Int = 0
    @State private var earnedGems: Int = 0
    @State private var correctCount: Int = 0
    @State private var currentCombo: Int = 0
    @State private var maxCombo: Int = 0
    @State private var sessionStart: Date = Date()

    private var lesson: Lesson { appState.currentLesson }

    // Safe only after the empty-questions guard in `body` passes.
    private var question: Question { lesson.questions[currentQuestionIndex] }

    private var isConfirmEnabled: Bool {
        if question.type == .fillInBlank {
            return !fillAnswer.trimmingCharacters(in: .whitespaces).isEmpty && !fillSubmitted
        }
        return answerState.selectedIndex != nil
    }

    var body: some View {
        // Guard against a lesson with no questions (e.g. a stub lesson added before
        // its content is written). Shows a clean fallback instead of crashing.
        if lesson.questions.isEmpty {
            LessonUnavailableFallback(onBack: { appState.navigate(to: .home) })
        } else {
            lessonBody
        }
    }

    @ViewBuilder
    private var lessonBody: some View {
        ZStack(alignment: .bottom) {
            Color.appBackground.ignoresSafeArea()

            VStack(spacing: 0) {
                LessonTopBar(
                    hearts: appState.progress.hearts,
                    currentQuestion: currentQuestionIndex + 1,
                    totalQuestions: lesson.questions.count,
                    onBack: { appState.navigate(to: .home) }
                )
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 8)

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 16) {
                        LessonCard(question: question, category: lesson.category)

                        if question.type == .fillInBlank {
                            FillInBlankArea(
                                answer: $fillAnswer,
                                submitted: fillSubmitted,
                                isCorrect: isCorrect
                            )
                            .padding(.horizontal, 20)
                        } else {
                            AnswerArea(
                                choices: question.choices,
                                correctAnswer: question.correctAnswer,
                                answerState: answerState,
                                onSelect: { index in
                                    guard !answerState.isSubmitted else { return }
                                    withAnimation(.spring(response: 0.25, dampingFraction: 0.7)) {
                                        answerState = .selected(index)
                                    }
                                }
                            )
                            .padding(.horizontal, 20)
                        }

                        Spacer().frame(height: 100)
                    }
                }

                Spacer(minLength: 0)
            }

            // Fixed bottom button
            VStack(spacing: 0) {
                Spacer()
                ConfirmButton(
                    isEnabled: isConfirmEnabled,
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
                    question: question,
                    onNext: handleNext
                )
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .zIndex(10)
            }
        }
        .animation(.spring(response: 0.4, dampingFraction: 0.75), value: showSheet)
        .onAppear { sessionStart = Date() }
        .sheet(isPresented: $showNoHeartsSheet) {
            NoHeartsSheet(
                gems: appState.progress.gems,
                onSpendGems: {
                    if appState.spendGems(30) {
                        appState.restoreHeart()
                        showNoHeartsSheet = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                            withAnimation { showSheet = true }
                        }
                    }
                },
                onGoHome: {
                    showNoHeartsSheet = false
                    appState.navigate(to: .home)
                }
            )
            .presentationDetents([.medium])
        }
    }

    // MARK: - Actions

    private func submitAnswer() {
        if question.type == .fillInBlank {
            let typed = fillAnswer.trimmingCharacters(in: .whitespaces)
            guard !typed.isEmpty, !fillSubmitted else { return }
            isCorrect = typed.lowercased() == question.correctAnswer.lowercased()
            fillSubmitted = true
            if !isCorrect {
                appState.loseHeart()
                if appState.progress.hearts == 0 {
                    showNoHeartsSheet = true
                    return
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                withAnimation { showSheet = true }
            }
        } else {
            guard let selectedIndex = answerState.selectedIndex else { return }
            let selectedText = question.choices[selectedIndex]
            isCorrect = (selectedText == question.correctAnswer)
            if !isCorrect {
                appState.loseHeart()
                if appState.progress.hearts == 0 {
                    withAnimation { answerState = .submitted(selectedIndex) }
                    showNoHeartsSheet = true
                    return
                }
            }
            withAnimation { answerState = .submitted(selectedIndex) }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                withAnimation { showSheet = true }
            }
        }
    }

    private func handleNext() {
        if isCorrect {
            earnedXP += question.xpReward
            earnedGems += question.gemReward
            correctCount += 1
            currentCombo += 1
            maxCombo = max(maxCombo, currentCombo)
        } else {
            currentCombo = 0
        }

        let nextIndex = currentQuestionIndex + 1
        if nextIndex < lesson.questions.count {
            withAnimation {
                showSheet = false
                answerState = .idle
                fillAnswer = ""
                fillSubmitted = false
                currentQuestionIndex = nextIndex
            }
        } else {
            appState.completeLesson(result: buildResult())
        }
    }

    private func buildResult() -> LessonResult {
        let total = lesson.questions.count
        let accuracy = total > 0 ? Int(Double(correctCount) / Double(total) * 100) : 0
        let elapsed = formatElapsed(from: sessionStart)
        let title = accuracy >= 80 ? "レッスンクリア！" : "レッスン完了！"
        let message = accuracy >= 80
            ? "すごい！よく頑張ったね！\n次のレッスンも挑戦しよう。"
            : "惜しい！もう少しで完璧！\n復習してまた挑戦しよう。"
        // NOTE: currentLevel and levelMaxXP are snapped here, before completeLesson
        // calls applyLevelUps(). If this lesson causes a level-up, the result screen
        // briefly shows the pre-lesson level. This is a known minor display inconsistency
        // and does not affect any persisted values.
        return LessonResult(
            xpEarned: earnedXP,
            gemsEarned: earnedGems,
            streakDelta: 1,
            accuracyPercent: accuracy,
            elapsedTime: elapsed,
            comboCount: maxCombo,
            currentLevel: appState.progress.currentLevel,
            currentXP: appState.progress.levelCurrentXP + earnedXP,
            levelMaxXP: appState.progress.currentLevelMaxXP,
            successTitle: title,
            encouragementMessage: message,
            unlockedAchievement: nil
        )
    }

    private func formatElapsed(from start: Date) -> String {
        let secs = Int(Date().timeIntervalSince(start))
        return String(format: "%d:%02d", secs / 60, secs % 60)
    }
}

// MARK: - Top Bar

private struct LessonTopBar: View {
    let hearts: Int
    let currentQuestion: Int
    let totalQuestions: Int
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
                    Text("\(currentQuestion) / \(totalQuestions)")
                        .font(.system(size: 12, weight: .semibold, design: .rounded))
                        .foregroundColor(.textGray)
                    Spacer()
                }
                RoundedProgressBar(
                    value: Double(currentQuestion - 1) / Double(max(totalQuestions, 1)),
                    color: .primaryPurple,
                    height: 8
                )
            }

            HeartRow(count: hearts)
        }
    }
}

// MARK: - Heart Row

private struct HeartRow: View {
    let count: Int
    private let maxHearts = 5

    var body: some View {
        HStack(spacing: 3) {
            ForEach(0..<maxHearts, id: \.self) { i in
                Image(systemName: i < count ? "heart.fill" : "heart")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(i < count ? .errorRed : Color.textGray.opacity(0.25))
            }
        }
    }
}

// MARK: - Lesson Card

private struct LessonCard: View {
    let question: Question
    let category: String

    var body: some View {
        FloatingCard {
            VStack(spacing: 20) {
                // Category pill
                HStack {
                    Text(category)
                        .font(.system(size: 12, weight: .semibold, design: .rounded))
                        .foregroundColor(.primaryPurple)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 5)
                        .background(Color.primaryPurple.opacity(0.1))
                        .clipShape(Capsule())
                    Spacer()
                }

                // Question prompt
                Text(question.prompt)
                    .font(.system(size: 26, weight: .bold, design: .rounded))
                    .foregroundColor(.textDark)
                    .lineSpacing(4)
                    .frame(maxWidth: .infinity, alignment: .leading)

                if let snippet = question.codeSnippet {
                    CodeBlock(code: snippet)
                } else {
                    LessonIllustrationPlaceholder()
                }
            }
            .padding(22)
        }
        .padding(.horizontal, 20)
        .padding(.top, 12)
    }
}

private struct LessonIllustrationPlaceholder: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.primaryPurple.opacity(0.06))
                .frame(height: 100)
            Text("[Lesson Illustration]")
                .font(.system(size: 12, weight: .medium, design: .rounded))
                .foregroundColor(.textGray.opacity(0.6))
        }
    }
}

private struct CodeBlock: View {
    let code: String

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

            // Code body
            Text(code)
                .font(.system(size: 14, weight: .regular, design: .monospaced))
                .foregroundColor(.white.opacity(0.9))
                .lineSpacing(4)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 14)
                .padding(.vertical, 14)
                .background(Color.textDark)
                .cornerRadius(12, corners: [.bottomLeft, .bottomRight])
        }
    }
}

// MARK: - Fill-in-Blank Area

private struct FillInBlankArea: View {
    @Binding var answer: String
    let submitted: Bool
    let isCorrect: Bool

    @FocusState private var isFocused: Bool

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: iconName)
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(accentColor)
                .frame(width: 36, height: 36)
                .background(accentColor.opacity(0.12))
                .clipShape(Circle())

            TextField("ここに入力…", text: $answer)
                .font(.system(size: 18, weight: .semibold, design: .monospaced))
                .foregroundColor(textColor)
                .focused($isFocused)
                .disabled(submitted)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 18)
        .background(background)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(borderColor, lineWidth: 2)
        )
        .shadow(color: borderColor.opacity(0.18), radius: 8, x: 0, y: 3)
        .onAppear { isFocused = true }
    }

    private var iconName: String {
        if !submitted { return "pencil" }
        return isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill"
    }

    private var accentColor: Color {
        if !submitted { return .primaryPurple }
        return isCorrect ? .successGreen : .errorRed
    }

    private var textColor: Color {
        if !submitted { return .textDark }
        return isCorrect ? .successGreen : .errorRed
    }

    private var background: Color {
        if !submitted { return Color.primaryPurple.opacity(0.05) }
        return isCorrect ? Color.successGreen.opacity(0.08) : Color.errorRed.opacity(0.06)
    }

    private var borderColor: Color {
        if !submitted { return isFocused ? .primaryPurple : Color.primaryPurple.opacity(0.3) }
        return isCorrect ? .successGreen : .errorRed
    }
}

// MARK: - Answer Area
//
// Renders multipleChoice and codeOutput questions as a tappable choice list.
// fillInBlank questions are handled by FillInBlankArea (text-field input).

private struct AnswerArea: View {
    let choices: [String]
    let correctAnswer: String
    let answerState: AnswerState
    let onSelect: (Int) -> Void

    var body: some View {
        VStack(spacing: 10) {
            ForEach(Array(choices.enumerated()), id: \.offset) { index, text in
                AnswerCard(
                    text: text,
                    state: cardState(for: index),
                    onTap: { onSelect(index) }
                )
            }
        }
    }

    private func cardState(for index: Int) -> AnswerCardState {
        switch answerState {
        case .idle:
            return .normal
        case .selected(let selected):
            return index == selected ? .selected : .normal
        case .submitted(let selected):
            if index == selected {
                return choices[selected] == correctAnswer ? .correct : .wrong
            }
            if choices[index] == correctAnswer { return .correct }
            return .normal
        }
    }
}

private enum AnswerCardState {
    case normal, selected, correct, wrong
}

private struct AnswerCard: View {
    let text: String
    let state: AnswerCardState
    let onTap: () -> Void

    @State private var pressed = false

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(iconBackground)
                        .frame(width: 34, height: 34)
                    Image(systemName: iconName)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(iconForeground)
                }

                Text(text)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundColor(textColor)
                    .lineLimit(2)
                    .minimumScaleFactor(0.85)

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

    private var borderWidth: CGFloat { state == .normal ? 0 : 2 }

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
    let question: Question
    let onNext: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            VStack(spacing: 0) {
                Capsule()
                    .fill(Color.white.opacity(0.3))
                    .frame(width: 40, height: 4)
                    .padding(.top, 12)

                VStack(spacing: 16) {
                    if isCorrect {
                        CorrectContent(
                            explanation: question.explanation,
                            xpReward: question.xpReward,
                            gemReward: question.gemReward,
                            onNext: onNext
                        )
                    } else {
                        WrongContent(
                            explanation: question.explanation,
                            correctAnswer: question.correctAnswer,
                            onNext: onNext
                        )
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 20)
                .padding(.bottom, 40)
            }
            .background(isCorrect ? Color(hex: "#1EB87A") : Color(hex: "#E8455A"))
            .cornerRadius(32, corners: [.topLeft, .topRight])
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

private struct CorrectContent: View {
    let explanation: String
    let xpReward: Int
    let gemReward: Int
    let onNext: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            HStack(alignment: .top, spacing: 16) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("🎉 正解！")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(.white)

                    HStack(spacing: 10) {
                        RewardPill(icon: "🔥", text: "+\(xpReward) XP")
                        RewardPill(icon: "💎", text: "+\(gemReward) Gem")
                    }

                    Text(explanation)
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
    let explanation: String
    let correctAnswer: String
    let onNext: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            HStack(alignment: .top, spacing: 16) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("もう一度挑戦しよう！")
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        .foregroundColor(.white)

                    Text("正解は「\(correctAnswer)」だよ。\n\(explanation)")
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

// MARK: - No Hearts Sheet

private struct NoHeartsSheet: View {
    let gems: Int
    let onSpendGems: () -> Void
    let onGoHome: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Capsule()
                .fill(Color.textGray.opacity(0.25))
                .frame(width: 40, height: 4)
                .padding(.top, 16)
                .padding(.bottom, 28)

            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.errorRed.opacity(0.1))
                    .frame(width: 96, height: 96)
                Text("[Pyro\nMascot]")
                    .font(.system(size: 10, weight: .medium, design: .rounded))
                    .foregroundColor(.errorRed.opacity(0.5))
                    .multilineTextAlignment(.center)
            }

            VStack(spacing: 8) {
                Text("ハートがなくなった！")
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .foregroundColor(.textDark)
                Text("ジェムを使ってハートを回復するか\nホームに戻ってまた挑戦しよう。")
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                    .foregroundColor(.textGray)
                    .multilineTextAlignment(.center)
            }
            .padding(.top, 20)

            VStack(spacing: 12) {
                Button(action: onSpendGems) {
                    HStack(spacing: 8) {
                        Text("💎")
                            .font(.system(size: 16))
                        Text("30ジェムで回復")
                            .font(.system(size: 17, weight: .bold, design: .rounded))
                            .foregroundColor(gems >= 30 ? Color(hex: "#1D2433") : .textGray)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(gems >= 30 ? Color.pythonLime : Color(hex: "#E4E7EF"))
                    .clipShape(Capsule())
                }
                .disabled(gems < 30)

                Button(action: onGoHome) {
                    Text("ホームに戻る")
                        .font(.system(size: 17, weight: .semibold, design: .rounded))
                        .foregroundColor(.textGray)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(Color.white)
                        .clipShape(Capsule())
                        .overlay(
                            Capsule()
                                .strokeBorder(Color.textGray.opacity(0.2), lineWidth: 1.5)
                        )
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 28)

            Spacer()
        }
        .background(Color.appBackground.ignoresSafeArea())
    }
}

// MARK: - Unavailable Fallback

// Shown when appState.currentLesson.questions is empty (e.g. a stub lesson added
// before its content is written). Prevents an out-of-bounds crash on `questions[0]`.
private struct LessonUnavailableFallback: View {
    let onBack: () -> Void

    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()
            VStack(spacing: 24) {
                Image(systemName: "exclamationmark.circle")
                    .font(.system(size: 48, weight: .light))
                    .foregroundColor(.textGray.opacity(0.5))
                Text("このレッスンはまだ準備中です")
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .foregroundColor(.textDark)
                Button(action: onBack) {
                    Text("ホームに戻る")
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(Color.primaryPurple)
                        .clipShape(Capsule())
                }
                .padding(.horizontal, 40)
            }
            .padding(24)
        }
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
