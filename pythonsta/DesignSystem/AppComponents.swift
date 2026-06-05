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

struct MascotPlaceholder: View {
    let size: CGFloat

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: size * 0.2)
                .fill(Color.snakeGreen.opacity(0.12))
                .overlay(
                    RoundedRectangle(cornerRadius: size * 0.2)
                        .strokeBorder(Color.snakeGreen.opacity(0.4), lineWidth: 2)
                )
            VStack(spacing: 4) {
                Text("🐍")
                    .font(.system(size: size * 0.35))
                Text("[Pyro Mascot]")
                    .font(AppFonts.caption)
                    .foregroundColor(.textGray)
                    .multilineTextAlignment(.center)
            }
        }
        .frame(width: size, height: size)
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
