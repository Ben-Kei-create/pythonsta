//
//  AdManager.swift
//  pythonsta
//
//  Created by 茂木史明 on 2026/06/05.
//
//  STUB ONLY — no ad SDK loaded, no ATT permission requested, no network calls,
//  no real ad unit IDs, no ads ever actually presented.
//
//  AD POLICY (must hold for both the stub and the real implementation):
//    • NEVER show ads between/during lesson questions — interstitials are
//      strictly a post-lesson placement.
//    • The only planned trigger today is lesson completion:
//        Lesson Complete → ResultView → Interstitial Ad → Home / Continue Learning
//      i.e. the ad would be presented as part of (or immediately before) the
//      transition into ResultView, never interrupting the question flow itself.
//    • Premium users must skip interstitials entirely (see `isPremiumUser`).
//
//  REAL IMPLEMENTATION STEPS (when ready):
//    1. Add the Google Mobile Ads SDK via Swift Package Manager.
//    2. Add NSUserTrackingUsageDescription to Info.plist.
//    3. Call ATTrackingManager.requestTrackingAuthorization() in OnboardingView
//       (must happen before any ad load, and after the user has seen app content).
//    4. Replace loadNextInterstitial()/showInterstitialIfReady(reason:) bodies
//       with real GADInterstitialAd load + present logic.
//    5. Replace `isPremiumUser` with a real entitlement check (StoreKit /
//       RevenueCat) once purchases are implemented — see ShopView's
//       PremiumTeaserCard for the UI side of that future feature.
//    6. Implement the frequency cap inside shouldShowInterstitial(for:)
//       (e.g. max 1 interstitial per N lessons, local counter or Remote Config).
//
//  CALL SITE (already wired, do not call from anywhere else):
//    AppState.completeLesson() → AdManager.shared.showInterstitialIfReady(reason: .lessonCompletion)
//    This fires once, after all lesson state is saved and right before the
//    transition to ResultView — never mid-lesson.
//

import Foundation

// MARK: - Trigger reasons

// Enumerates *why* an interstitial might be requested. Extend this as new
// post-lesson placements are introduced — do NOT add cases that fire during
// active question-answering.
enum AdTrigger {
    /// Fired immediately after a lesson finishes, on the way to ResultView.
    /// This is the only currently-planned interstitial placement.
    case lessonCompletion
}

// MARK: - Protocol (swap the conformer to go live, no call-site changes needed)

protocol AdPresenting {
    /// Pre-warm the next ad slot. Call once at app launch and after each shown ad.
    func loadNextInterstitial()
    /// Present an interstitial if one is loaded, allowed, and not frequency-capped.
    /// No-op in the stub — always does nothing.
    func showInterstitialIfReady(reason: AdTrigger)
}

// MARK: - Stub

final class AdManager: AdPresenting {
    static let shared = AdManager()
    private init() {}

    // Placeholder premium flag — stubbed to `false` until a real purchase /
    // entitlement system (StoreKit / RevenueCat) is implemented. Premium users
    // must never see interstitials; once real, this should reflect the user's
    // actual subscription/purchase state instead of a hardcoded constant.
    var isPremiumUser: Bool = false

    func loadNextInterstitial() {
        // TODO: GADInterstitialAd.load(withAdUnitID: adUnitID, request: GADRequest()) { ... }
    }

    func showInterstitialIfReady(reason: AdTrigger) {
        guard shouldShowInterstitial(for: reason) else { return }
        // TODO: present the loaded ad from the active root view controller,
        //       then call loadNextInterstitial() to pre-warm the next slot.
        //       e.g. loadedAd.present(fromRootViewController: ...); loadNextInterstitial()
    }

    // Pure decision stub — always returns false. This is where the real
    // implementation will combine ad-readiness, frequency capping, and the
    // premium check into a single yes/no answer, kept separate from the
    // presentation call above so each concern can be tested independently.
    private func shouldShowInterstitial(for reason: AdTrigger) -> Bool {
        guard !isPremiumUser else { return false }
        switch reason {
        case .lessonCompletion:
            // TODO: return adIsLoaded && frequencyCapAllows(reason)
            return false
        }
    }
}
