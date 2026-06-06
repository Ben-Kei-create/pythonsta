//
//  LessonDataSource.swift
//  pythonsta
//
//  Created by 茂木史明 on 2026/06/05.
//

import Foundation

enum LessonDataSource {
    static let courses: [Course] = [pythonIntro]

    static var allLessons: [Lesson] { courses.flatMap { $0.lessons } }

    static var defaultLesson: Lesson { courses[0].lessons[0] }
}

// MARK: - Python入門

private let pythonIntro = Course(
    id: 0,
    title: "Python入門",
    subtitle: "Pythonの基礎を学ぼう",
    lessons: [lesson0, lesson1, lesson2, lesson3]
)

// MARK: Lesson 0 — print()を使おう

private let lesson0 = Lesson(
    id: 0,
    title: "print()を使おう",
    shortLabel: "print()",
    subtitle: "出力",
    category: "Python基礎",
    order: 0,
    questions: [q0, q1, q2],
    requiredXP: 0
)

private let q0 = Question(
    id: 0,
    type: .multipleChoice,
    prompt: "print()は\n何をする命令でしょう？",
    codeSnippet: nil,
    choices: ["文字を表示する", "計算する", "保存する", "終了する"],
    correctAnswer: "文字を表示する",
    explanation: "print()は()の中の値を画面に表示するよ！",
    xpReward: 10,
    gemReward: 1
)

private let q1 = Question(
    id: 1,
    type: .codeOutput,
    prompt: "このコードを実行すると\n何が表示される？",
    codeSnippet: "print(\"Hello, Python!\")",
    choices: ["Hello, Python!", "hello, python!", "print", "エラー"],
    correctAnswer: "Hello, Python!",
    explanation: "print()は\"\"の中の文字をそのまま表示するよ！大文字・小文字も正確に出力されるよ。",
    xpReward: 10,
    gemReward: 1
)

private let q2 = Question(
    id: 2,
    type: .multipleChoice,
    prompt: "print(42)を実行すると\nどうなる？",
    codeSnippet: nil,
    choices: ["42が表示される", "エラーになる", "\"42\"と表示される", "何も起きない"],
    correctAnswer: "42が表示される",
    explanation: "print()は数値もそのまま表示できるよ！数値に「\"\"」は不要だよ。",
    xpReward: 10,
    gemReward: 1
)

// MARK: Lesson 1 — 変数を使おう

private let lesson1 = Lesson(
    id: 1,
    title: "変数を使おう",
    shortLabel: "変数",
    subtitle: "データ保存",
    category: "Python基礎",
    order: 1,
    questions: [q3, q4, q5],
    requiredXP: 30
)

private let q3 = Question(
    id: 3,
    type: .multipleChoice,
    prompt: "変数に値を入れる操作を\n何という？",
    codeSnippet: nil,
    choices: ["代入", "表示", "削除", "計算"],
    correctAnswer: "代入",
    explanation: "変数に値を入れることを「代入」というよ。「=」を使って代入するよ！",
    xpReward: 10,
    gemReward: 1
)

private let q4 = Question(
    id: 4,
    type: .codeOutput,
    prompt: "このコードを実行すると\n何が表示される？",
    codeSnippet: "name = \"Python\"\nprint(name)",
    choices: ["Python", "name", "\"Python\"", "エラー"],
    correctAnswer: "Python",
    explanation: "変数nameに\"Python\"を代入してprint()で表示したよ。\"\"は表示されないよ！",
    xpReward: 10,
    gemReward: 1
)

private let q5 = Question(
    id: 5,
    type: .multipleChoice,
    prompt: "正しい変数名は\nどれでしょう？",
    codeSnippet: nil,
    choices: ["my_name", "2name", "my-name", "my name"],
    correctAnswer: "my_name",
    explanation: "変数名は英字か_から始める必要があるよ。数字始まりや「-」「スペース」はNG！",
    xpReward: 10,
    gemReward: 1
)

// MARK: Lesson 2 — if文を使おう

private let lesson2 = Lesson(
    id: 2,
    title: "if文を使おう",
    shortLabel: "if文",
    subtitle: "判断",
    category: "条件分岐",
    order: 2,
    questions: [q6, q7, q8],
    requiredXP: 60
)

private let q6 = Question(
    id: 6,
    type: .multipleChoice,
    prompt: "if文は何のために\n使う？",
    codeSnippet: nil,
    choices: ["条件によって処理を変える", "繰り返しを行う", "関数を作る", "変数を保存する"],
    correctAnswer: "条件によって処理を変える",
    explanation: "if文は条件が真(True)か偽(False)かで実行する処理を変えることができるよ！",
    xpReward: 10,
    gemReward: 1
)

private let q7 = Question(
    id: 7,
    type: .codeOutput,
    prompt: "このコードを実行すると\n何が表示される？",
    codeSnippet: "x = 10\nif x > 5:\n    print(\"大きい\")",
    choices: ["大きい", "小さい", "10", "何も表示されない"],
    correctAnswer: "大きい",
    explanation: "x = 10 は 5 より大きいのでif条件が真となり「大きい」が表示されるよ！",
    xpReward: 10,
    gemReward: 1
)

private let q8 = Question(
    id: 8,
    type: .multipleChoice,
    prompt: "elseはいつ実行される？",
    codeSnippet: nil,
    choices: ["ifの条件が偽のとき", "ifの条件が真のとき", "常に実行される", "エラーのとき"],
    correctAnswer: "ifの条件が偽のとき",
    explanation: "elseはifの条件が偽(False)のときに実行されるよ。条件を満たさない場合の処理を書くよ！",
    xpReward: 10,
    gemReward: 1
)

// MARK: Lesson 3 — for文を使おう

private let lesson3 = Lesson(
    id: 3,
    title: "for文を使おう",
    shortLabel: "for文",
    subtitle: "ループ",
    category: "繰り返し",
    order: 3,
    questions: [q9, q10, q11],
    requiredXP: 90
)

private let q9 = Question(
    id: 9,
    type: .multipleChoice,
    prompt: "for文は何のために\n使う？",
    codeSnippet: nil,
    choices: ["繰り返し処理をする", "条件分岐する", "変数を作る", "関数を呼ぶ"],
    correctAnswer: "繰り返し処理をする",
    explanation: "for文はリストや範囲の各要素に対して同じ処理を繰り返すときに使うよ！",
    xpReward: 10,
    gemReward: 1
)

private let q10 = Question(
    id: 10,
    type: .codeOutput,
    prompt: "このコードで最後に\n表示される数字は？",
    codeSnippet: "for i in range(3):\n    print(i)",
    choices: ["2", "3", "0", "1"],
    correctAnswer: "2",
    explanation: "range(3)は0,1,2を生成するよ。最後の値は3-1=2だよ！",
    xpReward: 10,
    gemReward: 1
)

private let q11 = Question(
    id: 11,
    type: .multipleChoice,
    prompt: "range(5)が生成する\n数列はどれ？",
    codeSnippet: nil,
    choices: ["0, 1, 2, 3, 4", "1, 2, 3, 4, 5", "0, 1, 2, 3, 4, 5", "1, 2, 3, 4"],
    correctAnswer: "0, 1, 2, 3, 4",
    explanation: "range(n)は0からn-1までの整数を生成するよ。range(5)なら0〜4の5つだよ！",
    xpReward: 10,
    gemReward: 1
)
