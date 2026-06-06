//
//  Course.swift
//  pythonsta
//
//  Created by 茂木史明 on 2026/06/05.
//

import Foundation

struct Course: Identifiable {
    let id: Int
    let title: String
    let subtitle: String
    let lessons: [Lesson]
}
