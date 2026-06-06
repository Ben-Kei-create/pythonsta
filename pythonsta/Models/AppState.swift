//
//  AppState.swift
//  pythonsta
//
//  Created by 茂木史明 on 2026/06/05.
//

import SwiftUI

enum Screen {
    case welcome, home, lesson, result, profile, ranking, collection
}

final class AppState: ObservableObject {
    @Published var currentScreen: Screen = .welcome
    @Published var currentResult: LessonResult = .preview
    @Published var currentLesson: Lesson = LessonDataSource.defaultLesson
    @Published private(set) var progress: UserProgress

    private let store = UserProgressStore()

    init() {
        let saved = store.load()
        self.progress = saved
        checkStreakOnLaunch()
    }

    // MARK: - Navigation

    func navigate(to screen: Screen) {
        withAnimation(.easeInOut(duration: 0.3)) {
            currentScreen = screen
        }
    }

    func startLesson(_ lesson: Lesson) {
        currentLesson = lesson
        navigate(to: .lesson)
    }

    // MARK: - Lesson completion

    // Batch-updates all progress from a completed lesson in one save.
    // `result` carries real session data (XP, gems, accuracy, combo, elapsed time)
    // built by LessonView.buildResult() after all questions are answered.
    func completeLesson(result: LessonResult) {
        progress.totalXP += result.xpEarned
        progress.levelCurrentXP += result.xpEarned
        applyLevelUps()
        progress.gems = max(0, progress.gems + result.gemsEarned)
        progress.completedLessons += 1
        // Credit the exact number of questions answered in this lesson toward the daily goal.
        recordActivity(questionCount: currentLesson.questions.count)
        save()

        currentResult = result
        withAnimation(.easeInOut(duration: 0.3)) {
            currentScreen = .result
        }
    }

    // MARK: - Individual mutations (each saves immediately)

    func addXP(_ amount: Int) {
        progress.totalXP += amount
        progress.levelCurrentXP += amount
        applyLevelUps()
        save()
    }

    func addGems(_ amount: Int) {
        progress.gems = max(0, progress.gems + amount)
        save()
    }

    func unlockAchievement(id: Int) {
        guard !progress.unlockedAchievementIDs.contains(id) else { return }
        progress.unlockedAchievementIDs.append(id)
        save()
    }

    func loseHeart() {
        guard progress.hearts > 0 else { return }
        progress.hearts -= 1
        save()
    }

    // Restores `count` hearts, capped at the maximum of 5.
    // Use for single-heart restorations (ad reward, gem purchase, etc.).
    func restoreHeart(_ count: Int = 1) {
        progress.hearts = min(5, progress.hearts + max(count, 0))
        save()
    }

    // Refills all hearts to 5. Use for full-refill purchases.
    func resetHearts() {
        progress.hearts = 5
        save()
    }

    // Exposed for external callers (e.g. a future daily-login bonus screen).
    // Passes 0 questions — records activity for streak purposes without crediting
    // questions toward the daily goal (no questions were actually answered).
    func updateStreakIfNeeded() {
        recordActivity(questionCount: 0)
        save()
    }

    // MARK: - Computed UserProfile

    // Bridges persisted UserProgress into the UserProfile shape that ProfileView expects.
    // displayName / username remain hardcoded until an auth system is added.
    // achievements ([]) is mock until achievement unlock tracking is wired to unlockAchievement.
    // totalLearningMinutes (0) is mock until in-lesson time tracking is added.
    var userProfile: UserProfile {
        UserProfile(
            displayName: "茂木史明",
            username: "@fumiaki_dev",
            level: progress.currentLevel,
            totalXP: progress.totalXP,
            levelCurrentXP: progress.levelCurrentXP,
            levelMaxXP: progress.currentLevelMaxXP,
            currentStreak: progress.currentStreak,
            gems: progress.gems,
            totalLearningMinutes: 0,
            completedLessons: progress.completedLessons,
            totalLessons: LessonDataSource.totalLessonCount,
            achievements: []
        )
    }

    // MARK: - Private

    // On launch: reset daily counter and streak if the user missed days.
    // Does NOT advance the streak — that only happens on lesson completion.
    private func checkStreakOnLaunch() {
        guard !progress.lastActiveDateString.isEmpty else { return }
        let today = isoDate(Date())
        guard progress.lastActiveDateString != today else { return }

        var dirty = false

        if progress.dailyCompletedQuestions != 0 {
            progress.dailyCompletedQuestions = 0
            dirty = true
        }

        let yesterday = isoDate(Calendar.current.date(byAdding: .day, value: -1, to: Date())!)
        if progress.lastActiveDateString != yesterday, progress.currentStreak != 0 {
            progress.currentStreak = 0
            dirty = true
        }

        if dirty { save() }
    }

    // Updates streak and daily question count on lesson completion.
    // questionCount: number of questions answered in the completed lesson.
    //   Pass 0 for non-lesson activity (daily-login streak update, etc.).
    // Daily goal is a soft target; dailyCompletedQuestions accumulates indefinitely
    // with no cap — extra questions beyond the goal still count.
    private func recordActivity(questionCount: Int) {
        let today = isoDate(Date())

        if progress.lastActiveDateString == today {
            progress.dailyCompletedQuestions += questionCount
            return
        }

        let yesterday = isoDate(Calendar.current.date(byAdding: .day, value: -1, to: Date())!)
        if progress.lastActiveDateString == yesterday {
            progress.currentStreak += 1
        } else {
            // First lesson ever, or gap of 2+ days (streak already reset by checkStreakOnLaunch)
            progress.currentStreak = 1
        }

        progress.lastActiveDateString = today
        progress.dailyCompletedQuestions += questionCount
    }

    private func applyLevelUps() {
        while progress.levelCurrentXP >= progress.currentLevelMaxXP {
            progress.levelCurrentXP -= progress.currentLevelMaxXP
            progress.currentLevel += 1
        }
    }

    private func isoDate(_ date: Date) -> String {
        let f = DateFormatter()
        f.dateFormat = "yyyy-MM-dd"
        f.locale = Locale(identifier: "en_US_POSIX")
        return f.string(from: date)
    }

    private func save() {
        store.save(progress)
    }
}
