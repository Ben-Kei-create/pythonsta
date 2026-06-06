//
//  ShopView.swift
//  pythonsta
//
//  Created by 茂木史明 on 2026/06/05.
//
//  LOCAL PURCHASES (gem-spending only; no StoreKit):
//    • Heart Restore  — 30 gems  → restoreHeart(1),  max 5
//    • Full Refill    — 120 gems → resetHearts(),     sets to 5
//
//  FUTURE ITEMS (visible but locked):
//    • Streak Freeze, Pyro Skin, Color Theme — "近日公開" badge, no logic
//    • Premium teaser card — no purchase logic
//
//  SAFETY INVARIANTS:
//    • spendGems() guards gems >= cost before deducting (no negative gems)
//    • restoreHeart() and resetHearts() cap hearts at 5 (no overflow)
//    • Buttons disabled in UI when preconditions fail (UX + AppState both enforce)
//

import SwiftUI

// MARK: - ShopView

struct ShopView: View {
    @EnvironmentObject var appState: AppState

    private var gems: Int   { appState.progress.gems }
    private var hearts: Int { appState.progress.hearts }

    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    ShopHeader(onBack: { appState.navigate(to: appState.previousScreen) })
                        .padding(.horizontal, 20)
                        .padding(.top, 16)

                    GemBalanceCard(gems: gems, hearts: hearts)
                        .padding(.horizontal, 20)

                    // MARK: Hearts section
                    ShopSectionLabel(title: "ハート回復", icon: "heart.fill", color: .errorRed)
                        .padding(.horizontal, 20)

                    HeartRestoreCard(
                        hearts: hearts,
                        gems: gems,
                        onBuy: {
                            if appState.spendGems(30) { appState.restoreHeart() }
                        }
                    )
                    .padding(.horizontal, 20)

                    FullHeartRefillCard(
                        hearts: hearts,
                        gems: gems,
                        onBuy: {
                            if appState.spendGems(120) { appState.resetHearts() }
                        }
                    )
                    .padding(.horizontal, 20)

                    // MARK: Coming-soon items
                    ShopSectionLabel(title: "アイテム", icon: "bag.fill", color: .primaryPurple)
                        .padding(.horizontal, 20)

                    LockedItemCard(
                        icon: "snowflake",
                        iconColor: .appTeal,
                        title: "ストリークフリーズ",
                        description: "1日休んでも連続記録を維持する"
                    )
                    .padding(.horizontal, 20)

                    LockedItemCard(
                        icon: "wand.and.stars",
                        iconColor: .primaryPurple,
                        title: "Pyroスキン",
                        description: "マスコットの見た目をカスタマイズ"
                    )
                    .padding(.horizontal, 20)

                    LockedItemCard(
                        icon: "paintpalette.fill",
                        iconColor: .warmYellow,
                        title: "カラーテーマ",
                        description: "アプリの配色テーマを変更する"
                    )
                    .padding(.horizontal, 20)

                    PremiumTeaserCard()
                        .padding(.horizontal, 20)

                    Spacer().frame(height: 40)
                }
            }
        }
    }
}

// MARK: - Header

private struct ShopHeader: View {
    let onBack: () -> Void

    var body: some View {
        HStack(spacing: 14) {
            Button(action: onBack) {
                ZStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 40, height: 40)
                        .shadow(color: .black.opacity(0.06), radius: 6, x: 0, y: 2)
                    Image(systemName: "chevron.left")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.textDark)
                }
            }

            Text("ジェムショップ")
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .foregroundColor(.textDark)

            Spacer()
        }
    }
}

// MARK: - Gem Balance Card

private struct GemBalanceCard: View {
    let gems: Int
    let hearts: Int

    var body: some View {
        FloatingCard {
            HStack(spacing: 0) {
                VStack(spacing: 4) {
                    HStack(spacing: 6) {
                        Text("💎")
                            .font(.system(size: 28))
                        Text("\(gems)")
                            .font(.system(size: 36, weight: .bold, design: .rounded))
                            .foregroundColor(.textDark)
                    }
                    Text("現在のジェム")
                        .font(.system(size: 11, weight: .regular, design: .rounded))
                        .foregroundColor(.textGray)
                }
                .frame(maxWidth: .infinity)

                Rectangle()
                    .fill(Color.appBackground)
                    .frame(width: 1, height: 52)

                VStack(spacing: 6) {
                    HStack(spacing: 3) {
                        ForEach(0..<5, id: \.self) { i in
                            Image(systemName: i < hearts ? "heart.fill" : "heart")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(i < hearts ? .errorRed : Color.textGray.opacity(0.25))
                        }
                    }
                    Text("ハート \(hearts) / 5")
                        .font(.system(size: 11, weight: .regular, design: .rounded))
                        .foregroundColor(.textGray)
                }
                .frame(maxWidth: .infinity)
            }
            .padding(.vertical, 22)
        }
    }
}

// MARK: - Section Label

private struct ShopSectionLabel: View {
    let title: String
    let icon: String
    let color: Color

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(color)
            Text(title)
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .foregroundColor(.textDark)
            Spacer()
        }
    }
}

// MARK: - Heart Restore Card  (30 gems → +1 heart, max 5)

private struct HeartRestoreCard: View {
    let hearts: Int
    let gems: Int
    let onBuy: () -> Void

    private var heartsAreFull: Bool { hearts >= 5 }
    private var canAfford: Bool     { gems >= 30 }
    private var isEnabled: Bool     { !heartsAreFull && canAfford }

    var body: some View {
        FloatingCard {
            HStack(spacing: 14) {
                ZStack {
                    RoundedRectangle(cornerRadius: 14)
                        .fill(Color.errorRed.opacity(isEnabled ? 0.10 : 0.05))
                        .frame(width: 56, height: 56)
                    Image(systemName: "heart.fill")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(isEnabled ? .errorRed : .textGray.opacity(0.35))
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text("ハートを1つ回復")
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                        .foregroundColor(isEnabled ? .textDark : .textGray)
                    Text(heartsAreFull ? "ハートは満タンです" : "ハートを1つ追加 (最大5)")
                        .font(.system(size: 12, weight: .regular, design: .rounded))
                        .foregroundColor(.textGray)
                        .lineLimit(1)
                }

                Spacer(minLength: 8)

                PurchaseButton(cost: "30", isEnabled: isEnabled, onTap: onBuy)
            }
            .padding(16)
        }
    }
}

// MARK: - Full Heart Refill Card  (120 gems → hearts = 5)

private struct FullHeartRefillCard: View {
    let hearts: Int
    let gems: Int
    let onBuy: () -> Void

    private var heartsAreFull: Bool { hearts >= 5 }
    private var canAfford: Bool     { gems >= 120 }
    private var isEnabled: Bool     { !heartsAreFull && canAfford }

    var body: some View {
        FloatingCard {
            HStack(spacing: 14) {
                ZStack {
                    RoundedRectangle(cornerRadius: 14)
                        .fill(Color.errorRed.opacity(isEnabled ? 0.10 : 0.05))
                        .frame(width: 56, height: 56)
                    Image(systemName: "heart.circle.fill")
                        .font(.system(size: 28, weight: .semibold))
                        .foregroundColor(isEnabled ? .errorRed : .textGray.opacity(0.35))
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text("ハートを全回復")
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                        .foregroundColor(isEnabled ? .textDark : .textGray)
                    Text(heartsAreFull ? "ハートは満タンです" : "ハートを5つ全て回復")
                        .font(.system(size: 12, weight: .regular, design: .rounded))
                        .foregroundColor(.textGray)
                        .lineLimit(1)
                }

                Spacer(minLength: 8)

                PurchaseButton(cost: "120", isEnabled: isEnabled, onTap: onBuy)
            }
            .padding(16)
        }
    }
}

// MARK: - Purchase Button (shared by both heart cards)

private struct PurchaseButton: View {
    let cost: String
    let isEnabled: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 4) {
                Text("💎")
                    .font(.system(size: 13))
                Text(cost)
                    .font(.system(size: 15, weight: .bold, design: .rounded))
                    .foregroundColor(isEnabled ? .textDark : .textGray)
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
            .background(isEnabled ? Color.pythonLime : Color(hex: "#E4E7EF"))
            .clipShape(Capsule())
        }
        .disabled(!isEnabled)
    }
}

// MARK: - Locked Item Card

private struct LockedItemCard: View {
    let icon: String
    let iconColor: Color
    let title: String
    let description: String

    var body: some View {
        FloatingCard {
            HStack(spacing: 14) {
                ZStack {
                    RoundedRectangle(cornerRadius: 14)
                        .fill(Color.textGray.opacity(0.08))
                        .frame(width: 56, height: 56)
                    Image(systemName: icon)
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundColor(.textGray.opacity(0.40))
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                        .foregroundColor(.textGray)
                    Text(description)
                        .font(.system(size: 12, weight: .regular, design: .rounded))
                        .foregroundColor(.textGray.opacity(0.70))
                        .lineLimit(2)
                }

                Spacer(minLength: 8)

                Text("近日公開")
                    .font(.system(size: 10, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .padding(.horizontal, 9)
                    .padding(.vertical, 5)
                    .background(Color.textGray.opacity(0.35))
                    .clipShape(Capsule())
            }
            .padding(16)
        }
        .opacity(0.70)
    }
}

// MARK: - Premium Teaser Card

private struct PremiumTeaserCard: View {
    var body: some View {
        ZStack(alignment: .topLeading) {
            LinearGradient(
                colors: [.primaryPurple, .deepPurple],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .cornerRadius(20)
            .shadow(color: Color.primaryPurple.opacity(0.35), radius: 16, x: 0, y: 6)

            VStack(alignment: .leading, spacing: 16) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 5) {
                        HStack(spacing: 7) {
                            Image(systemName: "crown.fill")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.warmYellow)
                            Text("Premium")
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                        }
                        Text("制限なし、全機能を解放")
                            .font(.system(size: 13, weight: .regular, design: .rounded))
                            .foregroundColor(.white.opacity(0.72))
                    }

                    Spacer(minLength: 8)

                    Text("近日公開")
                        .font(.system(size: 10, weight: .bold, design: .rounded))
                        .foregroundColor(.primaryPurple)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color.white)
                        .clipShape(Capsule())
                }

                VStack(alignment: .leading, spacing: 8) {
                    PremiumBenefitRow(text: "広告なし、学習に集中できる")
                    PremiumBenefitRow(text: "ハートが無制限")
                    PremiumBenefitRow(text: "ストリークフリーズ無制限")
                    PremiumBenefitRow(text: "全スキン・テーマ解放")
                }
            }
            .padding(20)
        }
    }
}

private struct PremiumBenefitRow: View {
    let text: String

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.pythonLime)
            Text(text)
                .font(.system(size: 13, weight: .medium, design: .rounded))
                .foregroundColor(.white.opacity(0.90))
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

#Preview {
    ShopView()
        .environmentObject(AppState())
}
