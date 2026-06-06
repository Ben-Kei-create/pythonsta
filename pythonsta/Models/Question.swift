//
//  Question.swift
//  pythonsta
//
//  Created by 茂木史明 on 2026/06/05.
//

import Foundation

enum QuestionType {
    case multipleChoice
    case codeOutput
    case fillInBlank
}

struct Question: Identifiable {
    let id: Int
    let type: QuestionType
    let prompt: String
    let codeSnippet: String?
    let choices: [String]
    let correctAnswer: String
    let explanation: String
    let xpReward: Int
    let gemReward: Int
}
