//
//  UserProgressStore.swift
//  pythonsta
//
//  Created by 茂木史明 on 2026/06/05.
//

import Foundation

// Thin persistence layer: reads and writes UserProgress to UserDefaults.
// All keys are namespaced under "progress." to avoid collisions.
struct UserProgressStore {
    private let defaults: UserDefaults

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    // MARK: - Keys

    private enum Key {
        static let hasData            = "progress.hasData"
        static let totalXP            = "progress.totalXP"
        static let gems               = "progress.gems"
        static let currentStreak      = "progress.currentStreak"
        static let completedLessons   = "progress.completedLessons"
        static let currentLevel       = "progress.currentLevel"
        static let levelCurrentXP     = "progress.levelCurrentXP"
        static let achievementIDs     = "progress.achievementIDs"
        static let dailyLessons       = "progress.dailyLessons"
        static let lastActiveDate     = "progress.lastActiveDate"
        static let hearts             = "progress.hearts"
    }

    // MARK: - Load

    func load() -> UserProgress {
        // hasData acts as a first-launch sentinel.
        // Without it, integer(forKey:) returns 0 for every unset field,
        // making it impossible to distinguish "never saved" from "saved as 0".
        guard defaults.bool(forKey: Key.hasData) else { return .newUser }

        return UserProgress(
            totalXP:                defaults.integer(forKey: Key.totalXP),
            gems:                   defaults.integer(forKey: Key.gems),
            currentStreak:          defaults.integer(forKey: Key.currentStreak),
            completedLessons:       defaults.integer(forKey: Key.completedLessons),
            currentLevel:           max(defaults.integer(forKey: Key.currentLevel), 1),
            levelCurrentXP:         defaults.integer(forKey: Key.levelCurrentXP),
            unlockedAchievementIDs: defaults.array(forKey: Key.achievementIDs) as? [Int] ?? [],
            dailyCompletedLessons:  defaults.integer(forKey: Key.dailyLessons),
            lastActiveDateString:   defaults.string(forKey: Key.lastActiveDate) ?? "",
            hearts:                 defaults.integer(forKey: Key.hearts)
        )
    }

    // MARK: - Save

    func save(_ progress: UserProgress) {
        defaults.set(true,                              forKey: Key.hasData)
        defaults.set(progress.totalXP,                 forKey: Key.totalXP)
        defaults.set(progress.gems,                    forKey: Key.gems)
        defaults.set(progress.currentStreak,           forKey: Key.currentStreak)
        defaults.set(progress.completedLessons,        forKey: Key.completedLessons)
        defaults.set(progress.currentLevel,            forKey: Key.currentLevel)
        defaults.set(progress.levelCurrentXP,          forKey: Key.levelCurrentXP)
        defaults.set(progress.unlockedAchievementIDs,  forKey: Key.achievementIDs)
        defaults.set(progress.dailyCompletedLessons,   forKey: Key.dailyLessons)
        defaults.set(progress.lastActiveDateString,    forKey: Key.lastActiveDate)
        defaults.set(progress.hearts,                  forKey: Key.hearts)
    }

    // MARK: - Reset (development only)

    // Wipes all saved progress. Only compiled into Debug builds.
    // Call from the Xcode debugger console or a temporary debug menu:
    //   UserProgressStore().reset()
    #if DEBUG
    func reset() {
        [Key.hasData, Key.totalXP, Key.gems, Key.currentStreak, Key.completedLessons,
         Key.currentLevel, Key.levelCurrentXP, Key.achievementIDs, Key.dailyLessons,
         Key.lastActiveDate, Key.hearts].forEach { defaults.removeObject(forKey: $0) }
    }
    #endif
}
