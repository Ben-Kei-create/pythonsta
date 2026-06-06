//
//  Lesson.swift
//  pythonsta
//
//  Created by 茂木史明 on 2026/06/05.
//

import Foundation

struct Lesson: Identifiable {
    let id: Int
    let title: String
    let shortLabel: String
    let subtitle: String
    let category: String
    let order: Int
    let questions: [Question]
    let requiredXP: Int
}
