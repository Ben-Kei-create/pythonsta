//
//  AppState.swift
//  pythonsta
//
//  Created by 茂木史明 on 2026/06/05.
//

import SwiftUI
import Combine


enum Screen {
    case splash, welcome, onboarding, home, lesson, result, profile, ranking, collection, shop, settings
}

final class AppState: ObservableObject {
    @Published var currentScreen: Screen = .splash
    @Published var currentResult: LessonResult = .preview
    @Published var currentLesson: Lesson = LessonDataSource.defaultLesson
    @Published private(set) var progress: UserProgress

    // Tracks the screen to return to when ShopView's back button is tapped.
    // .lesson is excluded: navigating away from an active lesson abandons it,
    // so the shop back button should return to .home rather than a stale session.
    private(set) var previousScreen: Screen = .home

    private let store = UserProgressStore()

    init() {
        let saved = store.load()
        self.progress = saved
        checkStreakOnLaunch()
    }

    // MARK: - Navigation

    func navigate(to screen: Screen) {
        previousScreen = (currentScreen == .lesson) ? .home : currentScreen
        withAnimation(.easeInOut(duration: 0.3)) {
            currentScreen = screen
        }
    }

    func startLesson(_ lesson: Lesson) {
        currentLesson = lesson
        navigate(to: .lesson)
    }

    // Routes from WelcomeView: first-time users go to Onboarding, returning users to Home.
    func navigateAfterWelcome() {
        navigate(to: progress.hasCompletedOnboarding ? .home : .onboarding)
    }

    // Called by OnboardingView on completion. Persists purpose + goal and marks onboarding done.
    func completeOnboarding(learningPurpose: String, dailyGoal: Int = 10) {
        progress.learningPurpose = learningPurpose
        progress.dailyGoal = max(5, dailyGoal)
        progress.hasCompletedOnboarding = true
        save()
        navigate(to: .home)
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

        // Daily goal celebration — fires once per calendar day, the first time
        // dailyCompletedQuestions reaches dailyGoal. Comparing the stored date
        // string to "today" re-arms the gate on a new day with no extra reset logic.
        // The goal is a soft target: hitting it neither caps nor blocks further activity.
        var celebration: LessonResult.DailyGoalCelebration? = nil
        let today = isoDate(Date())
        if progress.dailyGoal > 0,
           progress.dailyCompletedQuestions >= progress.dailyGoal,
           progress.dailyGoalCelebrationDateString != today {
            progress.dailyGoalCelebrationDateString = today
            let bonusXP = 20
            let bonusGems = 5
            progress.totalXP += bonusXP
            progress.levelCurrentXP += bonusXP
            applyLevelUps()
            progress.gems = max(0, progress.gems + bonusGems)
            celebration = .init(bonusXP: bonusXP, bonusGems: bonusGems)
        }

        // Check and batch-unlock achievements with fully updated progress.
        // Appended directly here so the single save() below persists everything atomically.
        let newIDs = AchievementCatalog.newlyUnlocked(progress: progress, result: result)
        for id in newIDs where !progress.unlockedAchievementIDs.contains(id) {
            progress.unlockedAchievementIDs.append(id)
        }

        save()

        // Attach the first newly-unlocked achievement and any daily-goal celebration
        // to the result for ResultView display.
        let enrichedResult = newIDs
            .compactMap { AchievementCatalog.definition(for: $0) }
            .first
            .map { def in
                result.with(unlockedAchievement: .init(title: def.title, description: def.description))
            } ?? result
        let finalResult = enrichedResult.with(dailyGoalCelebration: celebration)

        // Ad display trigger — frequency cap enforced inside AdManager.
        AdManager.shared.showInterstitialIfReady()

        currentResult = finalResult
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

    // Deducts `amount` gems if the user has enough. Returns true on success.
    // Use for gem-gated actions (e.g. heart recovery from NoHeartsSheet).
    @discardableResult
    func spendGems(_ amount: Int) -> Bool {
        guard progress.gems >= amount else { return false }
        progress.gems -= amount
        save()
        return true
    }

    // Exposed for external callers (e.g. a future daily-login bonus screen).
    // Passes 0 questions — records activity for streak purposes without crediting
    // questions toward the daily goal (no questions were actually answered).
    func updateStreakIfNeeded() {
        recordActivity(questionCount: 0)
        save()
    }

    // MARK: - Debug utilities

    #if DEBUG
    // Wipes all persisted data and restarts from the welcome screen.
    // Exposed only in debug builds via the Developer section of SettingsView.
    func resetAllProgress() {
        store.reset()
        progress = .newUser
        currentLesson = LessonDataSource.defaultLesson
        currentResult = .preview
        navigate(to: .welcome)
    }
    #endif

    // MARK: - Computed UserProfile

    // Bridges persisted UserProgress into the UserProfile shape that ProfileView expects.
    // displayName / username remain hardcoded until an auth system is added.
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
            achievements: AchievementCatalog.profileAchievements(unlockedIDs: progress.unlockedAchievementIDs)
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
