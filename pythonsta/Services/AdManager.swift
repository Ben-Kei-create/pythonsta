//
//  AdManager.swift
//  pythonsta
//
//  Created by 茂木史明 on 2026/06/05.
//
//  STUB ONLY — no ad SDK loaded, no ATT permission requested, no network calls.
//
//  REAL IMPLEMENTATION STEPS (when ready):
//    1. Add Google Mobile Ads SDK via Swift Package Manager
//    2. Add NSUserTrackingUsageDescription to Info.plist
//    3. Call ATTrackingManager.requestTrackingAuthorization() in OnboardingView
//       (must happen before any ad load, and after user has seen app content)
//    4. Replace stub body with GADInterstitialAd load + present logic
//    5. Enforce frequency cap: max 1 interstitial per N lessons (local counter or
//       server-side config via Remote Config)
//
//  DISPLAY TRIGGER POINTS (already wired in AppState.completeLesson):
//    • After every lesson completion, before transitioning to ResultView.
//      Frequency capping is the AdManager's responsibility, not the call site.
//

import Foundation

// MARK: - Protocol (swap the conformer to go live, no call-site changes needed)

protocol AdPresenting {
    /// Pre-warm the next ad slot. Call once at app launch and after each shown ad.
    func loadNextInterstitial()
    /// Present an interstitial if one is loaded. No-op when not ready or frequency-capped.
    func showInterstitialIfReady()
}

// MARK: - Stub

final class AdManager: AdPresenting {
    static let shared = AdManager()
    private init() {}

    func loadNextInterstitial() {
        // TODO: GADInterstitialAd.load(withAdUnitID: adUnitID, request: GADRequest()) { ... }
    }

    func showInterstitialIfReady() {
        // TODO: guard let ad = loadedAd, frequencyCapAllows() else { return }
        //       ad.present(fromRootViewController: UIApplication.shared.topViewController())
        //       loadNextInterstitial()
    }
}
