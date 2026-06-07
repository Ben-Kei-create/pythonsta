//
//  LessonResult.swift
//  pythonsta
//
//  Created by 茂木史明 on 2026/06/05.
//

import Foundation

struct LessonResult {
    let xpEarned: Int
    let gemsEarned: Int
    let streakDelta: Int          // streaks gained this lesson
    let accuracyPercent: Int      // 0–100
    let elapsedTime: String       // formatted, e.g. "1:24"
    let comboCount: Int
    let currentLevel: Int
    let currentXP: Int
    let levelMaxXP: Int
    let successTitle: String
    let encouragementMessage: String
    let unlockedAchievement: UnlockedAchievement?
    let dailyGoalCelebration: DailyGoalCelebration?

    var levelProgressFraction: Double {
        guard levelMaxXP > 0 else { return 0 }
        return min(Double(currentXP) / Double(levelMaxXP), 1.0)
    }

    // XP fraction before this lesson's reward (for bar animation start point)
    var priorLevelProgressFraction: Double {
        let priorXP = max(0, currentXP - xpEarned)
        guard levelMaxXP > 0 else { return 0 }
        return min(Double(priorXP) / Double(levelMaxXP), 1.0)
    }

    var xpToNextLevel: Int { max(0, levelMaxXP - currentXP) }

    struct UnlockedAchievement {
        let title: String
        let description: String
    }

    // Carries the optional one-time-per-day bonus awarded when the daily
    // question goal is first reached. bonusXP/bonusGems are 0 when the
    // celebration is UI-only (no reward configured).
    struct DailyGoalCelebration {
        let bonusXP: Int
        let bonusGems: Int
    }

    // Returns a copy of this result with `unlockedAchievement` replaced.
    // Used by AppState.completeLesson() to attach newly unlocked achievements.
    func with(unlockedAchievement: UnlockedAchievement?) -> LessonResult {
        LessonResult(
            xpEarned: xpEarned,
            gemsEarned: gemsEarned,
            streakDelta: streakDelta,
            accuracyPercent: accuracyPercent,
            elapsedTime: elapsedTime,
            comboCount: comboCount,
            currentLevel: currentLevel,
            currentXP: currentXP,
            levelMaxXP: levelMaxXP,
            successTitle: successTitle,
            encouragementMessage: encouragementMessage,
            unlockedAchievement: unlockedAchievement,
            dailyGoalCelebration: dailyGoalCelebration
        )
    }

    // Returns a copy of this result with `dailyGoalCelebration` replaced.
    // Used by AppState.completeLesson() to attach the first-time daily-goal celebration.
    func with(dailyGoalCelebration: DailyGoalCelebration?) -> LessonResult {
        LessonResult(
            xpEarned: xpEarned,
            gemsEarned: gemsEarned,
            streakDelta: streakDelta,
            accuracyPercent: accuracyPercent,
            elapsedTime: elapsedTime,
            comboCount: comboCount,
            currentLevel: currentLevel,
            currentXP: currentXP,
            levelMaxXP: levelMaxXP,
            successTitle: successTitle,
            encouragementMessage: encouragementMessage,
            unlockedAchievement: unlockedAchievement,
            dailyGoalCelebration: dailyGoalCelebration
        )
    }

    static let preview = LessonResult(
        xpEarned: 50,
        gemsEarned: 5,
        streakDelta: 1,
        accuracyPercent: 90,
        elapsedTime: "1:24",
        comboCount: 7,
        currentLevel: 5,
        currentXP: 420,
        levelMaxXP: 500,
        successTitle: "レッスンクリア！",
        encouragementMessage: "Pythonが身についてきたね！\n次のレッスンも挑戦してみよう。",
        unlockedAchievement: UnlockedAchievement(
            title: "初めてのprint()",
            description: "初めてのレッスンを完了しました"
        ),
        dailyGoalCelebration: DailyGoalCelebration(bonusXP: 20, bonusGems: 5)
    )
}
