//
//  RewardedAdService.swift
//  pythonsta
//
//  Created by 茂木史明 on 2026/06/08.
//
//  STUB ONLY — no ad SDK loaded, no ATT permission requested, no network calls,
//  no real ad unit IDs in source, no ads ever actually presented, no rewards
//  ever actually granted. Mirrors the AdManager (interstitial) stub pattern
//  but for the separate rewarded-ad placement.
//
//  AD UNIT CONFIGURATION (future — DO NOT hardcode IDs here):
//    AdMob IDs have been issued for this app but are intentionally NOT wired
//    into source code yet:
//      App ID:       ca-app-pub-4859622277330192~1942143375
//      Interstitial: ca-app-pub-4859622277330192/2829369542
//      Rewarded:     ca-app-pub-4859622277330192/4376735029
//    When the real SDK is integrated, these belong in build configuration —
//    e.g. GADApplicationIdentifier in Info.plist (per-target via xcconfig so
//    Debug/Release can point at test vs. production units), and the ad-unit
//    IDs read from a config plist or build setting, NOT committed as string
//    literals in .swift sources. This file documents them for that future
//    wiring step only; nothing here references them programmatically.
//
//  PRODUCT DECISION — primary rewarded placement:
//    Watch rewarded ad → restore +1 heart (NOT gems). Hearts are a renewable
//    "play again" resource; gems are the Shop's spendable currency. Granting
//    gems directly from ads would undermine the gem economy (Shop purchases,
//    future cosmetics/Premium), whereas heart restore is a healthy, bounded
//    reward that keeps users in the learning loop without inflating currency.
//
//  FUTURE REWARD FLOW (when the real SDK is integrated):
//    1. User taps "広告を見てハート回復" (in NoHeartsSheet or ShopView's
//       heart-restore area — see trigger points below).
//    2. RewardedAdService presents a loaded rewarded interstitial.
//    3. On the SDK's "user did earn reward" callback (and ONLY then — never
//       speculatively, never on dismiss-without-completion), this service
//       invokes the `onReward` closure passed in by the call site.
//    4. The call site's `onReward` closure calls `appState.restoreHeart(1)`
//       (existing method, already caps at 5 — see AppState.restoreHeart).
//    This service never touches AppState/UserProgress directly; it only
//    decides whether/when to present an ad and relays the SDK's reward signal
//    via the closure. Keeping the reward grant at the call site (not in this
//    service) matches how AdManager stays presentation-only and keeps
//    progress mutations centralized in AppState.
//
//  REAL IMPLEMENTATION STEPS (when ready — mirrors AdManager's checklist):
//    1. Add the Google Mobile Ads SDK via Swift Package Manager (shared with
//       the interstitial implementation — one SDK, two ad formats).
//    2. Add NSUserTrackingUsageDescription to Info.plist (shared with
//       AdManager's ATT step — request once, not per ad format).
//    3. Replace loadNextRewardedAd()/showRewardedAdIfReady(reason:onReward:)
//       bodies with real GADRewardedAd.load + present + reward-callback logic.
//    4. Replace `isPremiumUser` with the same real entitlement check used by
//       AdManager once purchases are implemented (Premium users should never
//       need rewarded ads to keep playing — see ShopView's PremiumTeaserCard).
//    5. Implement availability/frequency rules inside isReady(for:) (e.g. ad
//       loaded, daily cap on rewarded heart restores, cooldown between asks).
//
//  TRIGGER POINTS (UI stubs only — see inline comments at each site):
//    • Views/LessonView.swift  → NoHeartsSheet
//        "広告を見てハート回復" button, currently disabled + labeled "近日対応"
//    • Views/ShopView.swift    → Hearts section (ハート回復)
//        "広告を見て回復" row, currently disabled + labeled "近日対応"
//    Neither site calls into this service yet — both are inert placeholders
//    documenting where the real wiring will attach.
//

import Foundation

// MARK: - Trigger reasons

// Enumerates *why* a rewarded ad might be requested. Extend this as new
// reward placements are introduced (e.g. bonus gems for ad-watch, in a way
// that's deliberate and economy-safe — see the product-decision note above
// for why heart restore was chosen as the primary placement).
enum RewardedAdReason {
    /// User ran out of hearts and chooses to watch an ad to restore one,
    /// instead of spending gems or waiting. The only currently-planned
    /// rewarded placement.
    case heartRestore
}

// MARK: - Protocol (swap the conformer to go live, no call-site changes needed)

protocol RewardedAdPresenting {
    /// Pre-warm the next rewarded ad slot. Call once at app launch and after
    /// each shown ad (mirrors AdManager.loadNextInterstitial()).
    func loadNextRewardedAd()

    /// Present a rewarded ad if one is loaded, allowed, and not capped.
    /// `onReward` must be invoked ONLY on the SDK's genuine "user earned
    /// reward" callback — never speculatively, never if the user dismisses
    /// the ad early. No-op in the stub: never presents anything, never
    /// invokes `onReward`, never grants anything.
    func showRewardedAdIfReady(reason: RewardedAdReason, onReward: @escaping () -> Void)
}

// MARK: - Stub

final class RewardedAdService: RewardedAdPresenting {
    static let shared = RewardedAdService()
    private init() {}

    // Placeholder premium flag — stubbed to `false`, mirroring AdManager's
    // `isPremiumUser`. Once a real entitlement system exists, both should
    // read from the same source of truth (Premium users skip ads of every
    // format, including rewarded — they simply don't need the heart-restore
    // bargain because hearts won't gate them).
    var isPremiumUser: Bool = false

    func loadNextRewardedAd() {
        // TODO: GADRewardedAd.load(withAdUnitID: rewardedAdUnitID, request: GADRequest()) { ad, error in ... }
    }

    func showRewardedAdIfReady(reason: RewardedAdReason, onReward: @escaping () -> Void) {
        guard isReady(for: reason) else { return }
        // TODO: present the loaded ad from the active root view controller with
        //       a GADUserDidEarnRewardHandler that calls `onReward()` exactly
        //       once, only on genuine reward completion, e.g.:
        //         loadedAd.present(fromRootViewController: ...) { onReward() }
        //       then call loadNextRewardedAd() to pre-warm the next slot.
        //
        // STUB BEHAVIOR: never reaches here (isReady always returns false),
        // so `onReward` is never invoked and no heart is ever granted from
        // a fake/no-op ad presentation.
    }

    // Pure decision stub — always returns false. This is where the real
    // implementation will combine ad-readiness, the premium check, and any
    // frequency/cooldown rules into a single yes/no answer, kept separate
    // from the presentation call above (mirrors AdManager.shouldShowInterstitial).
    private func isReady(for reason: RewardedAdReason) -> Bool {
        guard !isPremiumUser else { return false }
        switch reason {
        case .heartRestore:
            // TODO: return adIsLoaded && dailyRewardedCapAllows(reason)
            return false
        }
    }
}
