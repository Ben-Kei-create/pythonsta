//
//  AppState.swift
//  pythonsta
//
//  Created by 茂木史明 on 2026/06/05.
//

import SwiftUI

enum Screen {
    case welcome, home, lesson, result, profile
}

final class AppState: ObservableObject {
    @Published var currentScreen: Screen = .welcome
    @Published var currentResult: LessonResult = .preview

    func navigate(to screen: Screen) {
        withAnimation(.easeInOut(duration: 0.3)) {
            currentScreen = screen
        }
    }

    func completeLesson(result: LessonResult) {
        currentResult = result
        withAnimation(.easeInOut(duration: 0.3)) {
            currentScreen = .result
        }
    }
}
