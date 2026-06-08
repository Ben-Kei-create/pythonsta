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
}
