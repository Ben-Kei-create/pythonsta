//
//  Question.swift
//  pythonsta
//
//  Created by 茂木史明 on 2026/06/05.
//

import Foundation

// Determines how LessonView renders a question.
// Current UI support:
//   .multipleChoice — fully supported (choice list with tap selection)
//   .codeOutput     — fully supported (rendered identically to multipleChoice;
//                     the code snippet appears in a CodeBlock above the choices)
//   .fillInBlank    — DATA ONLY — rendered as multipleChoice in the current UI.
//                     A dedicated text-field input view is planned for a future sprint.
//                     Questions of this type must always supply a non-empty `choices`
//                     array so they render correctly in the interim UI.
enum QuestionType {
    case multipleChoice
    case codeOutput
    case fillInBlank
}

struct Question: Identifiable {
    let id: Int
    let type: QuestionType

    // The question text shown above the answer area.
    // Use \n for line breaks; keep under ~50 characters per line for SE/mini safety.
    let prompt: String

    // Optional Python code displayed in the CodeBlock component.
    // Use "_____ " as the fill-in placeholder for fillInBlank questions.
    // Use literal \n for line breaks within the snippet.
    let codeSnippet: String?

    // Answer options displayed as tappable cards.
    // Required for all types including fillInBlank (used as interim multiple-choice).
    // Order is shown as-is; shuffle at the call site if randomisation is desired.
    let choices: [String]

    // Must exactly match one element of `choices` (string equality check).
    let correctAnswer: String

    // Shown in the result bottom sheet after the answer is submitted.
    let explanation: String

    // Reward credited to the session when this question is answered correctly.
    let xpReward: Int
    let gemReward: Int
}
