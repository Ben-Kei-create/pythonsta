//
//  UserProfile.swift
//  pythonsta
//
//  Created by 茂木史明 on 2026/06/05.
//

import Foundation

struct UserProfile {
    let displayName: String
    let username: String
    let level: Int
    let totalXP: Int
    let levelCurrentXP: Int
    let levelMaxXP: Int
    let currentStreak: Int
    let gems: Int
    let totalLearningMinutes: Int
    let completedLessons: Int
    let totalLessons: Int
    let achievements: [ProfileAchievement]

    var levelProgressFraction: Double {
        guard levelMaxXP > 0 else { return 0 }
        return min(Double(levelCurrentXP) / Double(levelMaxXP), 1.0)
    }

    var xpToNextLevel: Int { max(0, levelMaxXP - levelCurrentXP) }

    var lessonProgressFraction: Double {
        guard totalLessons > 0 else { return 0 }
        return min(Double(completedLessons) / Double(totalLessons), 1.0)
    }

    var formattedLearningTime: String {
        let h = totalLearningMinutes / 60
        let m = totalLearningMinutes % 60
        return h > 0 ? "\(h)時間\(m)分" : "\(m)分"
    }

    static let preview = UserProfile(
        displayName: "茂木史明",
        username: "@fumiaki_dev",
        level: 5,
        totalXP: 2_450,
        levelCurrentXP: 420,
        levelMaxXP: 500,
        currentStreak: 12,
        gems: 180,
        totalLearningMinutes: 184,
        completedLessons: 23,
        totalLessons: 60,
        achievements: [
            ProfileAchievement(id: 0, title: "初めてのコード", subtitle: "print()完了",  isEarned: true),
            ProfileAchievement(id: 1, title: "7日連続",      subtitle: "7日連続学習",    isEarned: true),
            ProfileAchievement(id: 2, title: "100XP達成",   subtitle: "XP100超え",     isEarned: true),
            ProfileAchievement(id: 3, title: "変数マスター", subtitle: "変数章完了",     isEarned: false),
            ProfileAchievement(id: 4, title: "関数マスター", subtitle: "関数章完了",     isEarned: false),
        ]
    )
}

struct ProfileAchievement: Identifiable {
    let id: Int
    let title: String
    let subtitle: String
    let isEarned: Bool
}
