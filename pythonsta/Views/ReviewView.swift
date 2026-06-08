//
//  ReviewView.swift
//  pythonsta
//
//  Created by 茂木史明 on 2026/06/05.
//
//  ═══════════════════════════════════════════════════════════════════
//  THIS IS "苦手問題" (MISTAKE REVIEW) — NOT THE SRS / FORGETTING-CURVE
//  SYSTEM ("今日の復習"). The two are distinct product concepts:
//    • 苦手問題 (Mistake Review, this view): wrong-answer recovery —
//      surfaces only questions the user previously answered incorrectly.
//    • 今日の復習 (SRS / spaced repetition): NOT YET IMPLEMENTED — will
//      resurface questions on a forgetting-curve schedule (nextReviewDate)
//      regardless of whether they were answered correctly before, tracked
//      independently of this mistake queue.
//  Do not conflate the two when extending either system.
//  ═══════════════════════════════════════════════════════════════════
//
//  Practice surface for questions previously answered incorrectly
//  (AppState.progress.mistakeQuestionIDs, surfaced via HomeView's
//  "苦手問題" card). Reuses LessonView's question-presentation
//  components (LessonTopBar, LessonCard, AnswerArea, FillInBlankArea,
//  ConfirmButton, ResultBottomSheet, AnswerState, LessonUnavailableFallback —
//  all widened from `private` to internal access for this purpose) so the
//  two flows stay visually and behaviorally consistent without duplicating
//  that UI code. Normal LessonView is unaffected: only access level changed.
//
//  POLICY DIFFERENCES FROM A NORMAL LESSON (intentional):
//    • Heart-free — wrong answers stay queued for next time but never call
//      loseHeart(); this encourages free retries without risking progress.
//    • Smaller reward — +2 XP per correct answer, 0 gems (vs. a normal
//      lesson's per-question xpReward/gemReward), reflecting that this is
//      supplementary practice on already-seen material, not new content.
//    • Does not affect streak, daily goal progress, or achievements —
//      only grants the small XP bonus and updates the mistake queue.
//    • Correct answers remove the question from mistakeQuestionIDs
//      immediately (persisted via AppState.removeQuestionFromMistakeQueue).
//

import SwiftUI

struct ReviewView: View {
    @EnvironmentObject var appState: AppState

    // Snapshotted once at construction (see ContentView) so that removals
    // from the queue mid-session don't reshuffle the in-progress list.
    let questions: [Question]

    @State private var currentQuestionIndex: Int = 0
    @State private var answerState: AnswerState = .idle
    @State private var fillAnswer: String = ""
    @State private var fillSubmitted: Bool = false
    @State private var showSheet = false
    @State private var isCorrect = false

    // Session tracking
    @State private var earnedXP: Int = 0
    @State private var correctCount: Int = 0
    @State private var currentCombo: Int = 0
    @State private var maxCombo: Int = 0
    @State private var sessionStart: Date = Date()

    // Reward per correctly-answered review question — intentionally smaller
    // than a normal lesson's per-question reward, and XP-only (no gems),
    // since review is supplementary practice rather than new-content progress.
    private let xpPerCorrectAnswer = 2

    private var question: Question { questions[currentQuestionIndex] }

    private var isConfirmEnabled: Bool {
        if question.type == .fillInBlank {
            return !fillAnswer.trimmingCharacters(in: .whitespaces).isEmpty && !fillSubmitted
        }
        // Mirrors LessonView's guard: `.submitted(i)` still returns a non-nil
        // selectedIndex, so without this check a rapid double-tap during the
        // 0.35s pre-sheet delay would call submitAnswer() twice.
        return answerState.selectedIndex != nil && !answerState.isSubmitted
    }

    var body: some View {
        // Guard against an empty queue (e.g. the user cleared it from another
        // tab, or navigated here directly with nothing queued).
        if questions.isEmpty {
            LessonUnavailableFallback(
                onBack: { appState.navigate(to: .home) },
                message: "復習する問題がありません"
            )
        } else {
            reviewBody
        }
    }

    @ViewBuilder
    private var reviewBody: some View {
        ZStack(alignment: .bottom) {
            Color.appBackground.ignoresSafeArea()

            VStack(spacing: 0) {
                LessonTopBar(
                    hearts: appState.progress.hearts,
                    currentQuestion: currentQuestionIndex + 1,
                    totalQuestions: questions.count,
                    onBack: { appState.navigate(to: .home) }
                )
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 8)

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 16) {
                        LessonCard(
                            question: question,
                            category: "復習",
                            isBookmarked: appState.isQuestionBookmarked(question.id),
                            onToggleBookmark: { appState.toggleQuestionBookmark(question.id) }
                        )

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

            // Result bottom sheet — same correct/incorrect + gated
            // "解説を見る" explanation reveal as a normal lesson.
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
    }

    // MARK: - Actions

    private func submitAnswer() {
        if question.type == .fillInBlank {
            let typed = fillAnswer.trimmingCharacters(in: .whitespaces)
            guard !typed.isEmpty, !fillSubmitted else { return }
            isCorrect = typed.lowercased() == question.correctAnswer.lowercased()
            fillSubmitted = true
            // Heart-free: no loseHeart() call here, unlike LessonView.
            if isCorrect {
                appState.removeQuestionFromMistakeQueue(question.id)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                withAnimation { showSheet = true }
            }
        } else {
            guard let selectedIndex = answerState.selectedIndex else { return }
            let selectedText = question.choices[selectedIndex]
            isCorrect = (selectedText == question.correctAnswer)
            // Heart-free: no loseHeart() call here, unlike LessonView.
            if isCorrect {
                appState.removeQuestionFromMistakeQueue(question.id)
            }
            withAnimation { answerState = .submitted(selectedIndex) }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                withAnimation { showSheet = true }
            }
        }
    }

    private func handleNext() {
        if isCorrect {
            earnedXP += xpPerCorrectAnswer
            correctCount += 1
            currentCombo += 1
            maxCombo = max(maxCombo, currentCombo)
        } else {
            currentCombo = 0
        }

        let nextIndex = currentQuestionIndex + 1
        if nextIndex < questions.count {
            withAnimation {
                showSheet = false
                answerState = .idle
                fillAnswer = ""
                fillSubmitted = false
                currentQuestionIndex = nextIndex
            }
        } else {
            finishReview()
        }
    }

    // Awards the tallied XP in one shot (addXP saves immediately), then
    // builds a review-specific LessonResult and routes to the existing
    // ResultView — reused as-is per the "keep it simple" guidance, rather
    // than building a separate review result screen. Review sessions don't
    // touch streak, daily-goal, or achievement bookkeeping (completeLesson
    // is intentionally not called), so streakDelta/gems are 0 and no
    // achievement/celebration is attached.
    private func finishReview() {
        if earnedXP > 0 {
            appState.addXP(earnedXP)
        }

        let total = questions.count
        let accuracy = total > 0 ? Int(Double(correctCount) / Double(total) * 100) : 0
        let elapsed = formatElapsed(from: sessionStart)

        // NOTE: addXP() above already applied the reward (and any level-up),
        // so currentXP/currentLevel reflect the post-session state — mirrors
        // the same minor display-timing note in LessonView.buildResult().
        appState.currentResult = LessonResult(
            xpEarned: earnedXP,
            gemsEarned: 0,
            streakDelta: 0,
            accuracyPercent: accuracy,
            elapsedTime: elapsed,
            comboCount: maxCombo,
            currentLevel: appState.progress.currentLevel,
            currentXP: appState.progress.levelCurrentXP,
            levelMaxXP: appState.progress.currentLevelMaxXP,
            successTitle: "復習完了！",
            encouragementMessage: "復習お疲れさま！\n苦手を1つずつ克服していこう。",
            unlockedAchievement: nil,
            dailyGoalCelebration: nil
        )
        appState.navigate(to: .result)
    }

    private func formatElapsed(from start: Date) -> String {
        let secs = Int(Date().timeIntervalSince(start))
        return String(format: "%d:%02d", secs / 60, secs % 60)
    }
}

#Preview {
    ReviewView(questions: LessonDataSource.questions(for: [0, 4, 9]))
        .environmentObject(AppState())
}
