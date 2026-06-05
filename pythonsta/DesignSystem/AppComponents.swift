//
//  AppComponents.swift
//  pythonsta
//
//  Created by 茂木史明 on 2026/06/05.
//

import SwiftUI

// MARK: - PillButton

struct PillButton: View {
    let title: String
    let color: Color
    let textColor: Color
    let action: () -> Void

    init(title: String, color: Color, textColor: Color = .textDark, action: @escaping () -> Void) {
        self.title = title
        self.color = color
        self.textColor = textColor
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(AppFonts.headline)
                .foregroundColor(textColor)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(color)
                .clipShape(Capsule())
        }
    }
}

// MARK: - FloatingCard

struct FloatingCard<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color: .black.opacity(0.06), radius: 12, x: 0, y: 4)
    }
}

// MARK: - RoundedProgressBar

struct RoundedProgressBar: View {
    let value: Double
    let color: Color
    var height: CGFloat = 8

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(color.opacity(0.15))
                    .frame(height: height)
                Capsule()
                    .fill(color)
                    .frame(width: geo.size.width * min(max(value, 0), 1), height: height)
            }
        }
        .frame(height: height)
    }
}

// MARK: - MascotPlaceholder
// Text-only container. Artwork supplied separately as [Pyro Mascot].

struct MascotPlaceholder: View {
    let size: CGFloat

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: size * 0.2)
                .fill(Color.snakeGreen.opacity(0.08))
                .overlay(
                    RoundedRectangle(cornerRadius: size * 0.2)
                        .strokeBorder(Color.snakeGreen.opacity(0.25), lineWidth: 1.5)
                )
            Text("[Pyro Mascot]")
                .font(.system(size: max(size * 0.11, 9), weight: .medium, design: .rounded))
                .foregroundColor(.textGray.opacity(0.55))
                .multilineTextAlignment(.center)
                .padding(8)
        }
        .frame(width: size, height: size)
    }
}

// MARK: - PlaceholderArtworkView
// Generic text-only placeholder for any future image asset.

struct PlaceholderArtworkView: View {
    let label: String
    var height: CGFloat = 120
    var cornerRadius: CGFloat = 16
    var background: Color = Color.white.opacity(0.18)

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(background)
                .frame(maxWidth: .infinity)
                .frame(height: height)
            Text(label)
                .font(.system(size: 12, weight: .medium, design: .rounded))
                .foregroundColor(.white.opacity(0.55))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)
        }
    }
}

// MARK: - StatChip

struct StatChip: View {
    let icon: String
    let value: String
    let color: Color

    var body: some View {
        HStack(spacing: 4) {
            Text(icon)
                .font(.system(size: 14))
            Text(value)
                .font(AppFonts.caption)
                .foregroundColor(.textDark)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(color.opacity(0.15))
        .clipShape(Capsule())
    }
}

// MARK: - RewardChip

struct RewardChip: View {
    let icon: String
    let label: String
    let color: Color

    var body: some View {
        HStack(spacing: 6) {
            Text(icon)
                .font(.system(size: 18))
            Text(label)
                .font(AppFonts.headline)
                .foregroundColor(color)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(color.opacity(0.12))
        .cornerRadius(12)
    }
}

// MARK: - AppTabBar
// Shared bottom navigation bar used across Home and Profile screens.

struct AppTabBar: View {
    let selectedIndex: Int
    let onSelect: (Int) -> Void

    private let tabs: [(icon: String, label: String)] = [
        ("house.fill",  "ホーム"),
        ("trophy.fill", "ランキング"),
        ("bag.fill",    "コレクション"),
        ("person.fill", "プロフィール"),
    ]

    var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(tabs.enumerated()), id: \.offset) { index, tab in
                Button {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        onSelect(index)
                    }
                } label: {
                    VStack(spacing: 4) {
                        ZStack {
                            if selectedIndex == index {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.primaryPurple.opacity(0.12))
                                    .frame(width: 44, height: 34)
                            }
                            Image(systemName: tab.icon)
                                .font(.system(size: 20))
                                .foregroundColor(
                                    selectedIndex == index ? .primaryPurple : .textGray.opacity(0.5)
                                )
                        }
                        Text(tab.label)
                            .font(.system(size: 10, weight: .medium, design: .rounded))
                            .foregroundColor(
                                selectedIndex == index ? .primaryPurple : .textGray.opacity(0.5)
                            )
                            .lineLimit(1)
                            .minimumScaleFactor(0.8)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 28)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.10), radius: 20, x: 0, y: 8)
        )
    }
}
