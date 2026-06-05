//
//  LessonView.swift
//  pythonsta
//
//  Created by 茂木史明 on 2026/06/05.
//

import SwiftUI

struct LessonView: View {
    @EnvironmentObject var appState: AppState
    @State private var selectedAnswer: Int? = nil

    private let answers = [
        "name と age に値を代入している",
        "変数を表示している",
        "変数を削除している",
    ]

    var body: some View {
        VStack(spacing: 0) {
            // Top bar
            LessonTopBar(onBack: { appState.navigate(to: .home) })
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 20)

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    // Lesson title + mascot
                    HStack(alignment: .top) {
                        Text("変数を使ってみよう")
                            .font(AppFonts.title)
                            .foregroundColor(.textDark)
                            .fixedSize(horizontal: false, vertical: true)

                        Spacer()

                        MascotPlaceholder(size: 90)
                    }

                    // Explanation
                    Text("変数は、データに名前をつけて保存するための箱だよ！")
                        .font(AppFonts.body)
                        .foregroundColor(.textGray)
                        .fixedSize(horizontal: false, vertical: true)

                    // Code block
                    CodeBlock()

                    // Question
                    Text("このコードは何をしているかな？")
                        .font(AppFonts.headline)
                        .foregroundColor(.textDark)

                    // Answer choices
                    VStack(spacing: 12) {
                        ForEach(Array(answers.enumerated()), id: \.offset) { index, answer in
                            AnswerButton(
                                text: answer,
                                isSelected: selectedAnswer == index,
                                onTap: { selectedAnswer = index }
                            )
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }

            // Next button
            PillButton(title: "つぎへ", color: .pythonLime) {
                appState.navigate(to: .result)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 40)
            .padding(.top, 12)
        }
        .background(Color.appBackground.ignoresSafeArea())
    }
}

// MARK: - Top Bar

private struct LessonTopBar: View {
    let onBack: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            Button(action: onBack) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.textDark)
            }

            RoundedProgressBar(value: 0.4, color: .snakeGreen)

            HStack(spacing: 4) {
                Text("❤️")
                    .font(.system(size: 14))
                Text("5")
                    .font(AppFonts.headline)
                    .foregroundColor(.errorRed)
            }
        }
    }
}

// MARK: - Code Block

private struct CodeBlock: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Title bar
            HStack {
                Circle().fill(Color(hex: "#FF6B6B")).frame(width: 10, height: 10)
                Circle().fill(Color(hex: "#FFD66B")).frame(width: 10, height: 10)
                Circle().fill(Color(hex: "#36D399")).frame(width: 10, height: 10)
                Spacer()
                Text("main.py")
                    .font(AppFonts.caption)
                    .foregroundColor(.textGray.opacity(0.6))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(Color(hex: "#141B2A"))
            .cornerRadius(12, corners: [.topLeft, .topRight])

            // Code content
            VStack(alignment: .leading, spacing: 4) {
                CodeLine(parts: [
                    (.variable, "name"),
                    (.plain,    " = "),
                    (.string,   "\"PythonSta\""),
                ])
                CodeLine(parts: [
                    (.variable, "age"),
                    (.plain,    " = "),
                    (.number,   "3"),
                ])
                Text(" ")
                    .font(AppFonts.code)
                CodeLine(parts: [
                    (.function, "print"),
                    (.plain,    "("),
                    (.variable, "name"),
                    (.plain,    ")"),
                ])
                CodeLine(parts: [
                    (.function, "print"),
                    (.plain,    "("),
                    (.variable, "age"),
                    (.plain,    ")"),
                ])
            }
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.textDark)
            .cornerRadius(12, corners: [.bottomLeft, .bottomRight])
        }
    }
}

private enum CodeTokenKind {
    case plain, variable, string, number, function
}

private struct CodeLine: View {
    let parts: [(CodeTokenKind, String)]

    var body: some View {
        parts.reduce(Text("")) { result, part in
            result + Text(part.1)
                .font(AppFonts.code)
                .foregroundColor(color(for: part.0))
        }
    }

    private func color(for kind: CodeTokenKind) -> Color {
        switch kind {
        case .plain:    return .white.opacity(0.85)
        case .variable: return .snakeGreen
        case .string:   return .warmYellow
        case .number:   return .appTeal
        case .function: return Color(hex: "#C792EA")
        }
    }
}

// MARK: - Answer Button

private struct AnswerButton: View {
    let text: String
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack {
                Text(text)
                    .font(AppFonts.body)
                    .foregroundColor(isSelected ? .white : .textDark)
                    .multilineTextAlignment(.leading)

                Spacer()

                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                }
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 16)
            .background(isSelected ? Color.primaryPurple : Color.white)
            .cornerRadius(16)
            .shadow(color: .black.opacity(isSelected ? 0 : 0.05), radius: 8, x: 0, y: 3)
        }
    }
}

// MARK: - Corner radius helper

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

private struct RoundedCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

#Preview {
    LessonView()
        .environmentObject(AppState())
}
