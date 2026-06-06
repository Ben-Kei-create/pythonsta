//
//  AchievementCatalog.swift
//  pythonsta
//
//  Created by 茂木史明 on 2026/06/05.
//
//  Single source of truth for achievement definitions and unlock conditions.
//  IDs 0–11 match CollectionAchievement and UserProgress.unlockedAchievementIDs.
//
//  Condition mapping (lesson orders vs. completedLessons):
//    After lesson order N completes, completedLessons == N+1.
//    ID 0 (初めてのコード)   : completedLessons >= 1  (order 0 = print done)
//    ID 4 (変数マスター)     : completedLessons >= 2  (order 1 = 変数 done)
//    ID 7 (条件分岐の達人)   : completedLessons >= 4  (order 3 = if文 done)
//    ID 8 (ループ職人)       : completedLessons >= 5  (order 4 = for文 done)
//    ID 6, 10               : always false — future lessons / tracking not yet built
//

import Foundation

// MARK: - Definition

struct AchievementDefinition {
    let id: Int
    let title: String        // short, for ProfileAchievement.title
    let subtitle: String     // one-liner badge, for ProfileAchievement.subtitle
    let description: String  // full sentence, for CollectionAchievement.description
    let category: String
    // Evaluated with fully-updated progress right after lesson completion.
    // `result` is nil when called outside a lesson context.
    let condition: (UserProgress, LessonResult?) -> Bool
}

// MARK: - Catalog

enum AchievementCatalog {

    static let all: [AchievementDefinition] = [
        .init(id: 0, title: "初めてのコード",   subtitle: "最初のレッスン完了",
              description: "最初のレッスンを完了した",
              category: "学習",
              condition: { p, _ in p.completedLessons >= 1 }),

        .init(id: 1, title: "7日連続達成",     subtitle: "7日連続学習",
              description: "7日間連続で学習した",
              category: "連続",
              condition: { p, _ in p.currentStreak >= 7 }),

        .init(id: 2, title: "100XP達成",       subtitle: "XP 100超え",
              description: "累計XPが100を突破した",
              category: "スコア",
              condition: { p, _ in p.totalXP >= 100 }),

        // Fires on any lesson where every question was answered correctly.
        .init(id: 3, title: "完璧なスコア",    subtitle: "全問正解",
              description: "レッスンを全問正解で完了した",
              category: "スコア",
              condition: { _, r in r?.accuracyPercent == 100 }),

        .init(id: 4, title: "変数マスター",    subtitle: "変数章完了",
              description: "変数レッスンをすべて完了した",
              category: "学習",
              condition: { p, _ in p.completedLessons >= 2 }),

        .init(id: 5, title: "30日連続達成",    subtitle: "30日連続学習",
              description: "1ヶ月連続で学習した",
              category: "連続",
              condition: { p, _ in p.currentStreak >= 30 }),

        // Future lesson — condition will be updated when the lesson is added to seed data.
        .init(id: 6, title: "関数マスター",    subtitle: "関数章完了",
              description: "関数レッスンをすべて完了した",
              category: "学習",
              condition: { _, _ in false }),

        .init(id: 7, title: "条件分岐の達人",  subtitle: "if文完了",
              description: "if文レッスンをすべて完了した",
              category: "学習",
              condition: { p, _ in p.completedLessons >= 4 }),

        .init(id: 8, title: "ループ職人",      subtitle: "for文完了",
              description: "繰り返し処理をすべて完了した",
              category: "学習",
              condition: { p, _ in p.completedLessons >= 5 }),

        .init(id: 9, title: "1000XP達成",      subtitle: "XP 1000超え",
              description: "累計XPが1000を突破した",
              category: "スコア",
              condition: { p, _ in p.totalXP >= 1000 }),

        // Requires per-lesson perfect-score tracking not yet implemented.
        .init(id: 10, title: "完璧主義者",     subtitle: "全問全正解",
              description: "全レッスンを全問正解で完了した",
              category: "特別",
              condition: { _, _ in false }),

        .init(id: 11, title: "Pythonスター",   subtitle: "全レッスン完了",
              description: "全レッスンをクリアした",
              category: "特別",
              condition: { p, _ in p.completedLessons >= LessonDataSource.totalLessonCount }),
    ]

    // MARK: - Queries

    static func definition(for id: Int) -> AchievementDefinition? {
        all.first { $0.id == id }
    }

    // Returns IDs whose conditions are newly met — excludes any already in progress.unlockedAchievementIDs.
    static func newlyUnlocked(progress: UserProgress, result: LessonResult? = nil) -> [Int] {
        all.compactMap { def in
            guard !progress.unlockedAchievementIDs.contains(def.id),
                  def.condition(progress, result) else { return nil }
            return def.id
        }
    }

    // MARK: - View model factories

    // Full catalog as ProfileAchievement rows; isEarned reflects real unlock state.
    static func profileAchievements(unlockedIDs: [Int]) -> [ProfileAchievement] {
        all.map { def in
            ProfileAchievement(
                id: def.id,
                title: def.title,
                subtitle: def.subtitle,
                isEarned: unlockedIDs.contains(def.id)
            )
        }
    }

    // Full catalog as CollectionAchievement rows; unlockedDateText always nil
    // (date tracking not yet implemented).
    static func collectionAchievements(unlockedIDs: [Int]) -> [CollectionAchievement] {
        all.map { def in
            CollectionAchievement(
                id: def.id,
                title: def.title,
                description: def.description,
                isUnlocked: unlockedIDs.contains(def.id),
                unlockedDateText: nil,
                category: def.category
            )
        }
    }
}
