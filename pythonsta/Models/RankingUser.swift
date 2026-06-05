//
//  RankingUser.swift
//  pythonsta
//
//  Created by 茂木史明 on 2026/06/05.
//

import Foundation

struct RankingUser: Identifiable {
    let id: Int
    let rank: Int
    let displayName: String
    let username: String
    let weeklyXP: Int
    let streakDays: Int
    let isCurrentUser: Bool

    static let previewList: [RankingUser] = [
        RankingUser(id: 0, rank: 1, displayName: "サクラ",     username: "@sakura_py",   weeklyXP: 3840, streakDays: 21, isCurrentUser: false),
        RankingUser(id: 1, rank: 2, displayName: "タカシ",     username: "@takashi_dev", weeklyXP: 3210, streakDays: 14, isCurrentUser: false),
        RankingUser(id: 2, rank: 3, displayName: "ハルカ",     username: "@haruka_code", weeklyXP: 2780, streakDays: 9,  isCurrentUser: false),
        RankingUser(id: 3, rank: 4, displayName: "茂木史明",   username: "@fumiaki",     weeklyXP: 2450, streakDays: 12, isCurrentUser: true),
        RankingUser(id: 4, rank: 5, displayName: "ケンジ",     username: "@kenji_py",    weeklyXP: 2190, streakDays: 7,  isCurrentUser: false),
        RankingUser(id: 5, rank: 6, displayName: "アヤカ",     username: "@ayaka_learn", weeklyXP: 1950, streakDays: 5,  isCurrentUser: false),
        RankingUser(id: 6, rank: 7, displayName: "リョウ",     username: "@ryo_python",  weeklyXP: 1720, streakDays: 3,  isCurrentUser: false),
        RankingUser(id: 7, rank: 8, displayName: "ミサキ",     username: "@misaki_dev",  weeklyXP: 1480, streakDays: 8,  isCurrentUser: false),
        RankingUser(id: 8, rank: 9, displayName: "ダイスケ",   username: "@daisuke_c",   weeklyXP: 1230, streakDays: 2,  isCurrentUser: false),
        RankingUser(id: 9, rank: 10, displayName: "ノゾミ",    username: "@nozomi_p",    weeklyXP:  980, streakDays: 6,  isCurrentUser: false),
    ]
}
