//
//  CollectionAchievement.swift
//  pythonsta
//
//  Created by 茂木史明 on 2026/06/05.
//

import Foundation

struct CollectionAchievement: Identifiable {
    let id: Int
    let title: String
    let description: String
    let isUnlocked: Bool
    let unlockedDateText: String?
    let category: String?

    static let previewList: [CollectionAchievement] = [
        CollectionAchievement(id:  0, title: "初めてのコード",   description: "print()を初めて実行した",      isUnlocked: true,  unlockedDateText: "2026/05/01", category: "学習"),
        CollectionAchievement(id:  1, title: "7日連続達成",     description: "7日間連続で学習した",          isUnlocked: true,  unlockedDateText: "2026/05/07", category: "連続"),
        CollectionAchievement(id:  2, title: "100XP達成",       description: "累計XPが100を突破した",        isUnlocked: true,  unlockedDateText: "2026/05/10", category: "スコア"),
        CollectionAchievement(id:  3, title: "完璧なスコア",    description: "レッスンを全問正解で完了した",  isUnlocked: true,  unlockedDateText: "2026/05/15", category: "スコア"),
        CollectionAchievement(id:  4, title: "変数マスター",    description: "変数レッスンをすべて完了した",  isUnlocked: true,  unlockedDateText: "2026/05/20", category: "学習"),
        CollectionAchievement(id:  5, title: "30日連続達成",    description: "1ヶ月連続で学習した",          isUnlocked: true,  unlockedDateText: "2026/06/01", category: "連続"),
        CollectionAchievement(id:  6, title: "関数マスター",    description: "関数レッスンを完全攻略した",    isUnlocked: false, unlockedDateText: nil,          category: "学習"),
        CollectionAchievement(id:  7, title: "条件分岐の達人",  description: "if文レッスンをすべて完了した",  isUnlocked: false, unlockedDateText: nil,          category: "学習"),
        CollectionAchievement(id:  8, title: "ループ職人",      description: "繰り返し処理をすべて完了した",  isUnlocked: false, unlockedDateText: nil,          category: "学習"),
        CollectionAchievement(id:  9, title: "1000XP達成",      description: "累計XPが1000を突破した",       isUnlocked: false, unlockedDateText: nil,          category: "スコア"),
        CollectionAchievement(id: 10, title: "完璧主義者",      description: "全レッスンを全問正解で完了した",isUnlocked: false, unlockedDateText: nil,          category: "特別"),
        CollectionAchievement(id: 11, title: "Pythonスター",    description: "全レッスンをクリアした",        isUnlocked: false, unlockedDateText: nil,          category: "特別"),
    ]
}
