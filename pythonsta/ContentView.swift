//
//  ContentView.swift
//  pythonsta
//
//  Created by 茂木史明 on 2026/06/05.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var appState = AppState()

    var body: some View {
        Group {
            switch appState.currentScreen {
            case .welcome:
                WelcomeView()
                    .transition(.opacity)
            case .home:
                HomeView()
                    .transition(.opacity)
            case .lesson:
                LessonView()
                    .transition(.opacity)
            case .result:
                ResultView()
                    .transition(.opacity)
            }
        }
        .environmentObject(appState)
        .animation(.easeInOut(duration: 0.3), value: appState.currentScreen)
    }
}

#Preview {
    ContentView()
}
