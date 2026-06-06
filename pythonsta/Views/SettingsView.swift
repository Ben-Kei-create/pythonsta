//
//  SettingsView.swift
//  pythonsta
//
//  Created by 茂木史明 on 2026/06/05.
//
//  REAL vs PLACEHOLDER:
//    Real:        Account info display (from AppState.userProfile)
//                 Daily goal display (hardcoded 10 questions)
//                 DEBUG reset progress (calls AppState.resetAllProgress())
//    Placeholder: Notifications toggle — no OS permission request, no scheduling
//                 Sound effects toggle — no AVAudioPlayer wiring
//                 Haptics toggle      — no UIImpactFeedbackGenerator wiring
//                 Restore Purchases   — no StoreKit, no-op button
//                 Terms of Use        — no URL, no-op button
//                 Privacy Policy      — no URL, no-op button
//

import SwiftUI

// MARK: - SettingsView

struct SettingsView: View {
    @EnvironmentObject var appState: AppState

    // Placeholder toggles — not persisted; wired to real implementations later.
    @State private var notificationsOn = false
    @State private var soundOn         = true
    @State private var hapticsOn       = true

    @State private var showResetAlert  = false

    private var profile: UserProfile { appState.userProfile }

    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    SettingsHeader(onBack: { appState.navigate(to: appState.previousScreen) })
                        .padding(.horizontal, 20)
                        .padding(.top, 16)

                    // ── Account ─────────────────────────────────────────
                    SettingsSectionLabel(title: "アカウント")
                        .padding(.horizontal, 20)

                    FloatingCard {
                        VStack(spacing: 0) {
                            SettingsInfoRow(
                                icon: "person.fill",
                                iconColor: .primaryPurple,
                                label: "表示名",
                                value: profile.displayName
                            )
                            SettingsDivider()
                            SettingsInfoRow(
                                icon: "at",
                                iconColor: .textGray,
                                label: "ユーザー名",
                                value: profile.username
                            )
                        }
                    }
                    .padding(.horizontal, 20)

                    // ── Learning ─────────────────────────────────────────
                    SettingsSectionLabel(title: "学習設定")
                        .padding(.horizontal, 20)

                    FloatingCard {
                        VStack(spacing: 0) {
                            SettingsInfoRow(
                                icon: "target",
                                iconColor: .snakeGreen,
                                label: "1日の目標",
                                value: "\(appState.progress.dailyGoal)問"
                            )
                            SettingsDivider()
                            SettingsToggleRow(
                                icon: "bell.fill",
                                iconColor: Color(hex: "#FF8C42"),
                                label: "通知",
                                note: "近日対応",
                                isOn: $notificationsOn
                            )
                        }
                    }
                    .padding(.horizontal, 20)

                    // ── App ──────────────────────────────────────────────
                    SettingsSectionLabel(title: "アプリ")
                        .padding(.horizontal, 20)

                    FloatingCard {
                        VStack(spacing: 0) {
                            SettingsToggleRow(
                                icon: "speaker.wave.2.fill",
                                iconColor: .appTeal,
                                label: "効果音",
                                note: "近日対応",
                                isOn: $soundOn
                            )
                            SettingsDivider()
                            SettingsToggleRow(
                                icon: "iphone.radiowaves.left.and.right",
                                iconColor: .primaryPurple,
                                label: "触覚フィードバック",
                                note: "近日対応",
                                isOn: $hapticsOn
                            )
                        }
                    }
                    .padding(.horizontal, 20)

                    // ── Premium ──────────────────────────────────────────
                    SettingsSectionLabel(title: "プレミアム")
                        .padding(.horizontal, 20)

                    FloatingCard {
                        VStack(spacing: 0) {
                            SettingsInfoRow(
                                icon: "crown.fill",
                                iconColor: .warmYellow,
                                label: "プラン",
                                value: "Free"
                            )
                            SettingsDivider()
                            SettingsActionRow(
                                icon: "arrow.clockwise",
                                iconColor: .textGray,
                                label: "購入を復元",
                                note: "近日対応",
                                action: { }
                            )
                        }
                    }
                    .padding(.horizontal, 20)

                    // ── Developer (DEBUG only) ───────────────────────────
                    #if DEBUG
                    SettingsSectionLabel(title: "開発者")
                        .padding(.horizontal, 20)

                    FloatingCard {
                        SettingsDestructiveRow(
                            icon: "arrow.counterclockwise.circle.fill",
                            label: "進捗をリセット",
                            action: { showResetAlert = true }
                        )
                    }
                    .padding(.horizontal, 20)
                    #endif

                    // ── Legal ────────────────────────────────────────────
                    SettingsSectionLabel(title: "法的情報")
                        .padding(.horizontal, 20)

                    FloatingCard {
                        VStack(spacing: 0) {
                            SettingsActionRow(
                                icon: "doc.text.fill",
                                iconColor: .textGray,
                                label: "利用規約",
                                action: { }
                            )
                            SettingsDivider()
                            SettingsActionRow(
                                icon: "hand.raised.fill",
                                iconColor: .textGray,
                                label: "プライバシーポリシー",
                                action: { }
                            )
                        }
                    }
                    .padding(.horizontal, 20)

                    Spacer().frame(height: 40)
                }
            }
        }
        #if DEBUG
        .alert("進捗をリセット", isPresented: $showResetAlert) {
            Button("リセット", role: .destructive) {
                appState.resetAllProgress()
            }
            Button("キャンセル", role: .cancel) { }
        } message: {
            Text("すべての学習データ、XP、ジェム、連続記録が削除されます。この操作は取り消せません。")
        }
        #endif
    }
}

// MARK: - Header

private struct SettingsHeader: View {
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

            Text("設定")
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .foregroundColor(.textDark)

            Spacer()
        }
    }
}

// MARK: - Section Label

private struct SettingsSectionLabel: View {
    let title: String

    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 13, weight: .semibold, design: .rounded))
                .foregroundColor(.textGray)
                .textCase(.uppercase)
            Spacer()
        }
    }
}

// MARK: - Divider

private struct SettingsDivider: View {
    var body: some View {
        Rectangle()
            .fill(Color.appBackground)
            .frame(height: 1)
            .padding(.horizontal, 16)
    }
}

// MARK: - Info Row (label + static value)

private struct SettingsInfoRow: View {
    let icon: String
    let iconColor: Color
    let label: String
    let value: String

    var body: some View {
        HStack(spacing: 12) {
            SettingsIcon(name: icon, color: iconColor)
            Text(label)
                .font(.system(size: 15, weight: .regular, design: .rounded))
                .foregroundColor(.textDark)
            Spacer(minLength: 8)
            Text(value)
                .font(.system(size: 15, weight: .regular, design: .rounded))
                .foregroundColor(.textGray)
                .lineLimit(1)
                .minimumScaleFactor(0.85)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
    }
}

// MARK: - Toggle Row

private struct SettingsToggleRow: View {
    let icon: String
    let iconColor: Color
    let label: String
    var note: String? = nil
    @Binding var isOn: Bool

    var body: some View {
        HStack(spacing: 12) {
            SettingsIcon(name: icon, color: iconColor)
            Text(label)
                .font(.system(size: 15, weight: .regular, design: .rounded))
                .foregroundColor(.textDark)
            if let note {
                Text(note)
                    .font(.system(size: 11, weight: .medium, design: .rounded))
                    .foregroundColor(.textGray)
                    .padding(.horizontal, 7)
                    .padding(.vertical, 3)
                    .background(Color.appBackground)
                    .clipShape(Capsule())
            }
            Spacer(minLength: 8)
            Toggle("", isOn: $isOn)
                .labelsHidden()
                .tint(.primaryPurple)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
}

// MARK: - Action Row (tappable, chevron)

private struct SettingsActionRow: View {
    let icon: String
    let iconColor: Color
    let label: String
    var note: String? = nil
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                SettingsIcon(name: icon, color: iconColor)
                Text(label)
                    .font(.system(size: 15, weight: .regular, design: .rounded))
                    .foregroundColor(.textDark)
                if let note {
                    Text(note)
                        .font(.system(size: 11, weight: .medium, design: .rounded))
                        .foregroundColor(.textGray)
                        .padding(.horizontal, 7)
                        .padding(.vertical, 3)
                        .background(Color.appBackground)
                        .clipShape(Capsule())
                }
                Spacer(minLength: 8)
                Image(systemName: "chevron.right")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(Color.textGray.opacity(0.45))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Destructive Row

private struct SettingsDestructiveRow: View {
    let icon: String
    let label: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                SettingsIcon(name: icon, color: .errorRed)
                Text(label)
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .foregroundColor(.errorRed)
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Icon chip (shared)

private struct SettingsIcon: View {
    let name: String
    let color: Color

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(color.opacity(0.12))
                .frame(width: 34, height: 34)
            Image(systemName: name)
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(color)
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(AppState())
}
