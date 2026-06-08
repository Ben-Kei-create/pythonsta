//
//  BookmarkView.swift
//  pythonsta
//
//  Created by 茂木史明 on 2026/06/07.
//
//  Practice surface for manually bookmarked questions
//  (AppState.progress.bookmarkedQuestionIDs, surfaced via HomeView's
//  "保存した問題" card). Reuses LessonView's question-presentation
//  components (LessonTopBar, LessonCard, AnswerArea, FillInBlankArea,
//  ConfirmButton, ResultBottomSheet, AnswerState, LessonUnavailableFallback)
//  exactly like ReviewView does, so all three flows stay visually and
//  behaviorally consistent without duplicating that UI code. Normal
//  LessonView and ReviewView are unaffected by this file.
//
//  POLICY DIFFERENCES FROM A NORMAL LESSON / REVIEW SESSION (intentional):
//    • Heart-free — wrong answers never call loseHeart(), same as Review Mode.
//    • Practice-only — zero rewards. No XP, no gems, no streak, no daily-goal
//      progress, no achievements. Unlike Review Mode (which still grants a
//      small +2 XP), Bookmark Mode is purely for revisiting saved material.
//    • Bookmark status is manual-only — answering correctly or incorrectly
//      never adds to or removes from bookmarkedQuestionIDs. The user can
//      unbookmark a question mid-session via the same bookmark button shown
//      in LessonView/ReviewView; doing so persists immediately but does not
//      remove the question from the current snapshot (it stays visible for
//      the rest of this session, mirroring ReviewView's snapshot behavior).
//

import SwiftUI

struct BookmarkView: View {
    @EnvironmentObject var appState: AppState

    // Snapshotted once at construction (see ContentView) so that
    // unbookmarking mid-session doesn't reshuffle the in-progress list.
    let questions: [Question]

    @State private var currentQuestionIndex: Int = 0
    @State private var answerState: AnswerState = .idle
    @State private var fillAnswer: String = ""
    @State private var fillSubmitted: Bool = false
    @State private var showSheet = false
    @State private var isCorrect = false

    // Session tracking (for the result screen's stats only — no rewards)
    @State private var correctCount: Int = 0
    @State private var currentCombo: Int = 0
    @State private var maxCombo: Int = 0
    @State private var sessionStart: Date = Date()

    private var question: Question { questions[currentQuestionIndex] }

    private var isConfirmEnabled: Bool {
        if question.type == .fillInBlank {
            return !fillAnswer.trimmingCharacters(in: .whitespaces).isEmpty && !fillSubmitted
        }
        // Mirrors LessonView's / ReviewView's guard against rapid double-taps
        // during the 0.35s pre-sheet delay calling submitAnswer() twice.
        return answerState.selectedIndex != nil && !answerState.isSubmitted
    }

    var body: some View {
        // Guard against an empty bookmark list (e.g. the user unbookmarked
        // everything from another tab, or navigated here directly with
        // nothing saved).
        if questions.isEmpty {
            LessonUnavailableFallback(
                onBack: { appState.navigate(to: .home) },
                message: "保存した問題がありません"
            )
        } else {
            bookmarkBody
        }
    }

    @ViewBuilder
    private var bookmarkBody: some View {
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
                            category: "保存済み",
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
            // Heart-free, reward-free, queue-free: no loseHeart()/addXP()/
            // addQuestionToMistakeQueue()/removeQuestionFromMistakeQueue() here. Bookmark
            // status changes only via the explicit bookmark button.
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                withAnimation { showSheet = true }
            }
        } else {
            guard let selectedIndex = answerState.selectedIndex else { return }
            let selectedText = question.choices[selectedIndex]
            isCorrect = (selectedText == question.correctAnswer)
            // Heart-free, reward-free, queue-free — see note above.
            withAnimation { answerState = .submitted(selectedIndex) }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                withAnimation { showSheet = true }
            }
        }
    }

    private func handleNext() {
        if isCorrect {
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
            finishBookmarkPractice()
        }
    }

    // Builds a zero-reward, bookmark-specific LessonResult and routes to the
    // existing ResultView — reused as-is per the "keep it simple" guidance,
    // exactly like ReviewView does. No addXP/addGems/completeLesson calls:
    // Bookmark Mode is practice-only and must not touch XP, gems, streak,
    // daily goal, or achievement bookkeeping.
    private func finishBookmarkPractice() {
        let total = questions.count
        let accuracy = total > 0 ? Int(Double(correctCount) / Double(total) * 100) : 0
        let elapsed = formatElapsed(from: sessionStart)

        appState.currentResult = LessonResult(
            xpEarned: 0,
            gemsEarned: 0,
            streakDelta: 0,
            accuracyPercent: accuracy,
            elapsedTime: elapsed,
            comboCount: maxCombo,
            currentLevel: appState.progress.currentLevel,
            currentXP: appState.progress.levelCurrentXP,
            levelMaxXP: appState.progress.currentLevelMaxXP,
            successTitle: "保存問題の確認完了！",
            encouragementMessage: "保存した問題をおさらいできたね！\n気になる問題はいつでも見返せるよ。",
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
    BookmarkView(questions: LessonDataSource.questions(for: [1, 12, 23]))
        .environmentObject(AppState())
}
