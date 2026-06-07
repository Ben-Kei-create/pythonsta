//
//  UserProgress.swift
//  pythonsta
//
//  Created by 茂木史明 on 2026/06/05.
//

import Foundation

// Plain value type holding all persisted user progress.
// Owned by AppState; read/written by UserProgressStore.
struct UserProgress {
    var totalXP: Int = 0
    var gems: Int = 0
    var currentStreak: Int = 0
    var completedLessons: Int = 0
    var currentLevel: Int = 1
    var levelCurrentXP: Int = 0
    var unlockedAchievementIDs: [Int] = []
    // Number of questions answered today (resets on new calendar day).
    // Soft target — no cap; users can learn beyond their goal.
    var dailyCompletedQuestions: Int = 0
    var lastActiveDateString: String = ""   // "yyyy-MM-dd", locale-independent
    var hearts: Int = 5
    // User-chosen daily question target, set during onboarding. Min 5.
    var dailyGoal: Int = 10
    // False on first install; set to true by AppState.completeOnboarding().
    var hasCompletedOnboarding: Bool = false
    // Selected learning purpose from onboarding Step A. Empty string until onboarding completes.
    var learningPurpose: String = ""
    // "yyyy-MM-dd" of the last day the daily-goal celebration was awarded.
    // Empty until first time reached. Comparing against "today" lets the gate
    // re-arm on a new calendar day with no separate reset bookkeeping needed.
    var dailyGoalCelebrationDateString: String = ""

    // IDs of questions answered incorrectly, queued for future review.
    // Appended (de-duplicated) by AppState.addQuestionToReview(); a question
    // already in the queue is not re-added on a repeat miss. Review Mode
    // itself is not implemented yet — this only persists the queue.
    var reviewQuestionIDs: [Int] = []

    // IDs of questions the user has manually bookmarked to revisit later.
    // Toggled (added/removed) by AppState.toggleQuestionBookmark(); independent
    // of reviewQuestionIDs — bookmarking is a manual user choice, not a
    // wrong-answer consequence, and does not affect the review queue.
    var bookmarkedQuestionIDs: [Int] = []

    // XP threshold to advance from `level` to `level + 1`.
    static func levelMaxXP(for level: Int) -> Int { max(level, 1) * 100 }

    var currentLevelMaxXP: Int { UserProgress.levelMaxXP(for: currentLevel) }

    var levelProgressFraction: Double {
        Double(levelCurrentXP) / Double(max(currentLevelMaxXP, 1))
    }

    var xpToNextLevel: Int { max(currentLevelMaxXP - levelCurrentXP, 0) }

    // Default state for a brand-new user (all fields at their zero values).
    static let newUser = UserProgress()
}
