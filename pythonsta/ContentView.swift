//
//  ContentView.swift
//  pythonsta
//
//  Created by 茂木史明 on 2026/06/05.
//

import SwiftUI
import Combine

struct ContentView: View {
    @StateObject private var appState = AppState()

    var body: some View {
        Group {
            switch appState.currentScreen {
            case .splash:
                SplashView()
                    .transition(.opacity)
            case .welcome:
                WelcomeView()
                    .transition(.opacity)
            case .onboarding:
                OnboardingView()
                    .transition(.opacity)
            case .home:
                HomeView()
                    .transition(.opacity)
            case .lesson:
                LessonView()
                    .transition(.opacity)
            case .result:
                ResultView(result: appState.currentResult)
                    .transition(.opacity)
            case .profile:
                ProfileView(profile: appState.userProfile)
                    .transition(.opacity)
            case .ranking:
                RankingView()
                    .transition(.opacity)
            case .collection:
                CollectionView()
                    .transition(.opacity)
            case .shop:
                ShopView()
                    .transition(.opacity)
            case .settings:
                SettingsView()
                    .transition(.opacity)
            case .review:
                ReviewView(questions: LessonDataSource.questions(for: appState.progress.reviewQuestionIDs))
                    .transition(.opacity)
            case .bookmarks:
                BookmarkView(questions: LessonDataSource.questions(for: appState.progress.bookmarkedQuestionIDs))
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
