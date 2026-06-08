//
//  PythonBasics.swift
//  pythonsta
//
//  Created by 茂木史明 on 2026/06/05.
//
//  Course: Python基礎
//  Course ID: 0
//  Lesson ID range:   0–9    (10 lessons at full scale — COMPLETE)
//  Lesson order range: 0–9   (globally unique; drives unlock sequencing)
//  Question ID range: 0–99   (100 questions at full scale — COMPLETE)
//
//  STATE: 10 lessons / 100 questions  (10 per lesson) — course COMPLETE
//
//  HOW TO ADD A LESSON
//  1. Create a `private let lessonN` constant with `order: N` (next in sequence).
//  2. Create `private let qNN, qNN1, ...` Question constants (IDs N*10 through N*10+9).
//  3. Append `lessonN` to `PythonBasicsCourse.course.lessons`.
//  4. Lesson unlock is automatic: completedLessons counter drives HomeView node states.
//
//  Authored per PythonSta Authoring Guidelines v1.2:
//  fixed 5 multipleChoice / 3 codeOutput / 2 fillInBlank per lesson,
//  3-choice rule, 答え→なぜ→覚え方 explanation template, Review/Interleaving
//  pulled from the immediately preceding 1–5 lessons.
//

import Foundation

enum PythonBasicsCourse {
    static let course = Course(
        id: 0,
        title: "Python基礎",
        subtitle: "Pythonの基本を身につけよう",
        lessons: [lesson0, lesson1, lesson2, lesson3, lesson4, lesson5, lesson6, lesson7, lesson8, lesson9]
    )
}

// ─────────────────────────────────────────────────────────
// MARK: - Lesson 0 · print()を使おう
// ─────────────────────────────────────────────────────────

private let lesson0 = Lesson(
    id: 0,
    title: "print()を使おう",
    shortLabel: "print()",
    subtitle: "出力",
    category: "Python基礎",
    order: 0,
    questions: [q0, q1, q2, q3, q4, q5, q6, q7, q8, q9],
    requiredXP: 0
)

private let q0 = Question(
    id: 0,
    type: .multipleChoice,
    prompt: "print() は\n何をする命令？",
    codeSnippet: nil,
    choices: ["文字を表示する", "計算する", "変数を保存する"],
    correctAnswer: "文字を表示する",
    explanation: "print() は () の中の値を画面に表示するよ！",
    xpReward: 10,
    gemReward: 1
)

private let q1 = Question(
    id: 1,
    type: .codeOutput,
    prompt: "このコードの出力は？",
    codeSnippet: "print(\"Hello!\")",
    choices: ["Hello!", "hello!", "\"Hello!\""],
    correctAnswer: "Hello!",
    explanation: "print() は \"\" の中の文字列をそのまま表示するよ。\"\" 自体は出力されないよ！",
    xpReward: 10,
    gemReward: 1
)

private let q2 = Question(
    id: 2,
    type: .multipleChoice,
    prompt: "print(42) の\n出力はどれ？",
    codeSnippet: nil,
    choices: ["42", "\"42\"", "int"],
    correctAnswer: "42",
    explanation: "数値はそのまま出力されるよ。数値を print() に渡すとき \"\" は不要だよ！",
    xpReward: 10,
    gemReward: 1
)

private let q3 = Question(
    id: 3,
    type: .codeOutput,
    prompt: "このコードの出力は？",
    codeSnippet: "print(\"A\", \"B\")",
    choices: ["A B", "AB", "A\nB"],
    correctAnswer: "A B",
    explanation: "print() に複数の値を渡すと、スペースで区切って表示されるよ！",
    xpReward: 10,
    gemReward: 1
)

private let q4 = Question(
    id: 4,
    type: .fillInBlank,
    prompt: "空欄に入る\n正しいコードは？",
    codeSnippet: "_(\"Python\")",
    choices: ["print", "show", "display"],
    correctAnswer: "print",
    explanation: "画面に表示するには print() を使うよ！",
    xpReward: 10,
    gemReward: 1
)

private let q5 = Question(
    id: 5,
    type: .codeOutput,
    prompt: "このコードの出力は？",
    codeSnippet: "print(3 * 4)",
    choices: ["12", "7", "34"],
    correctAnswer: "12",
    explanation: "print() は計算式も評価して出力するよ。3 × 4 = 12 だよ！",
    xpReward: 10,
    gemReward: 1
)

private let q6 = Question(
    id: 6,
    type: .multipleChoice,
    prompt: "print() に複数の値を\n渡したときの区切りは？",
    codeSnippet: nil,
    choices: ["スペース（半角）", "カンマ", "改行"],
    correctAnswer: "スペース（半角）",
    explanation: "print(a, b) のように複数の値を渡すと、半角スペースで区切って表示されるよ！",
    xpReward: 10,
    gemReward: 1
)

private let q7 = Question(
    id: 7,
    type: .codeOutput,
    prompt: "このコードの出力は？",
    codeSnippet: "name = \"Python\"\nprint(\"言語:\", name)",
    choices: ["言語: Python", "言語:Python", "\"言語:\", name"],
    correctAnswer: "言語: Python",
    explanation: "print() に文字列と変数を一緒に渡すと、スペースで区切って表示されるよ！",
    xpReward: 10,
    gemReward: 1
)

private let q8 = Question(
    id: 8,
    type: .multipleChoice,
    prompt: "print() で数値と\n文字列を同時に出力できる？",
    codeSnippet: nil,
    choices: ["できる", "できない", "int()が必要"],
    correctAnswer: "できる",
    explanation: "print() はカンマ区切りで何種類でも混ぜて出力できるよ！",
    xpReward: 10,
    gemReward: 1
)

private let q9 = Question(
    id: 9,
    type: .fillInBlank,
    prompt: "\"Hello\" と \"World\" を\nつなげて出力するには？",
    codeSnippet: "print(\"Hello\" _____ \"World\")",
    choices: ["+", ",", "&"],
    correctAnswer: "+",
    explanation: "文字列同士を + でつなげることを「文字列の結合」というよ！",
    xpReward: 10,
    gemReward: 1
)

// ─────────────────────────────────────────────────────────
// MARK: - Lesson 1 · 変数を使おう
// ─────────────────────────────────────────────────────────

private let lesson1 = Lesson(
    id: 1,
    title: "変数を使おう",
    shortLabel: "変数",
    subtitle: "データ保存",
    category: "Python基礎",
    order: 1,
    questions: [q10, q11, q12, q13, q14, q15, q16, q17, q18, q19],
    requiredXP: 50
)

private let q10 = Question(
    id: 10,
    type: .multipleChoice,
    prompt: "変数に値を入れることを\n何という？",
    codeSnippet: nil,
    choices: ["代入", "表示", "削除"],
    correctAnswer: "代入",
    explanation: "= を使って変数に値を入れることを「代入」というよ！",
    xpReward: 10,
    gemReward: 1
)

private let q11 = Question(
    id: 11,
    type: .codeOutput,
    prompt: "このコードの出力は？",
    codeSnippet: "x = 5\nprint(x)",
    choices: ["5", "x", "\"5\""],
    correctAnswer: "5",
    explanation: "変数 x に 5 を代入して print() で表示したよ。変数名ではなく値が表示されるよ！",
    xpReward: 10,
    gemReward: 1
)

private let q12 = Question(
    id: 12,
    type: .multipleChoice,
    prompt: "正しい変数名はどれ？",
    codeSnippet: nil,
    choices: ["my_name", "2name", "my-name"],
    correctAnswer: "my_name",
    explanation: "変数名は英字か _ から始める必要があるよ。数字始まり・ハイフン・スペースは使えないよ！",
    xpReward: 10,
    gemReward: 1
)

private let q13 = Question(
    id: 13,
    type: .codeOutput,
    prompt: "このコードの出力は？",
    codeSnippet: "a = 3\nb = 4\nprint(a + b)",
    choices: ["7", "34", "a + b"],
    correctAnswer: "7",
    explanation: "変数 a と b の値を足し算して表示するよ。3 + 4 = 7 だよ！",
    xpReward: 10,
    gemReward: 1
)

private let q14 = Question(
    id: 14,
    type: .fillInBlank,
    prompt: "空欄に入るのは？",
    codeSnippet: "name = \"Python\"\n_____(name)",
    choices: ["print", "show", "display"],
    correctAnswer: "print",
    explanation: "変数の値を画面に表示するには print() を使うよ！",
    xpReward: 10,
    gemReward: 1
)

private let q15 = Question(
    id: 15,
    type: .codeOutput,
    prompt: "このコードの出力は？",
    codeSnippet: "x = 10\ny = 3\nprint(x - y)",
    choices: ["7", "13", "103"],
    correctAnswer: "7",
    explanation: "x - y は 10 - 3 = 7 だよ。変数を使った引き算もできるよ！",
    xpReward: 10,
    gemReward: 1
)

private let q16 = Question(
    id: 16,
    type: .multipleChoice,
    prompt: "変数に新しい値を\n代入したら？",
    codeSnippet: nil,
    choices: ["前の値は上書きされる", "両方保存される", "エラーになる"],
    correctAnswer: "前の値は上書きされる",
    explanation: "Pythonの変数は上書き可能で、新しい値を代入すると前の値は消えるよ！",
    xpReward: 10,
    gemReward: 1
)

private let q17 = Question(
    id: 17,
    type: .codeOutput,
    prompt: "このコードの出力は？",
    codeSnippet: "x = 5\nx = x + 1\nprint(x)",
    choices: ["6", "5", "x + 1"],
    correctAnswer: "6",
    explanation: "x = x + 1 は現在の x の値（5）に 1 を足して x に代入するよ。結果は 6 だよ！",
    xpReward: 10,
    gemReward: 1
)

private let q18 = Question(
    id: 18,
    type: .multipleChoice,
    prompt: "変数に保存できるデータは？",
    codeSnippet: nil,
    choices: ["数値・文字列・真偽値など", "数値だけ", "文字列だけ"],
    correctAnswer: "数値・文字列・真偽値など",
    explanation: "Pythonの変数には int・float・str・bool などさまざまな型のデータを保存できるよ！",
    xpReward: 10,
    gemReward: 1
)

private let q19 = Question(
    id: 19,
    type: .fillInBlank,
    prompt: "空欄に入るのは？",
    codeSnippet: "score = 100\nprint(_____)",
    choices: ["score", "\"score\"", "100"],
    correctAnswer: "score",
    explanation: "変数の値を表示するには、\"\" なしで変数名をそのまま print() に渡すよ！",
    xpReward: 10,
    gemReward: 1
)

// ─────────────────────────────────────────────────────────
// MARK: - Lesson 2 · 型を理解しよう
// ─────────────────────────────────────────────────────────

private let lesson2 = Lesson(
    id: 2,
    title: "型を理解しよう",
    shortLabel: "データ型",
    subtitle: "型の種類",
    category: "Python基礎",
    order: 2,
    questions: [q20, q21, q22, q23, q24, q25, q26, q27, q28, q29],
    requiredXP: 100
)

private let q20 = Question(
    id: 20,
    type: .multipleChoice,
    prompt: "\"hello\" のデータ型は？",
    codeSnippet: nil,
    choices: ["str（文字列）", "int（整数）", "float（小数）"],
    correctAnswer: "str（文字列）",
    explanation: "\"\" で囲まれた値は str（文字列）型だよ！",
    xpReward: 10,
    gemReward: 1
)

private let q21 = Question(
    id: 21,
    type: .multipleChoice,
    prompt: "42 のデータ型は？",
    codeSnippet: nil,
    choices: ["int（整数）", "str（文字列）", "float（小数）"],
    correctAnswer: "int（整数）",
    explanation: "小数点のない数値は int（整数）型だよ！",
    xpReward: 10,
    gemReward: 1
)

private let q22 = Question(
    id: 22,
    type: .codeOutput,
    prompt: "このコードの出力は？",
    codeSnippet: "print(type(42))",
    choices: ["<class 'int'>", "<class 'str'>", "int"],
    correctAnswer: "<class 'int'>",
    explanation: "type() はデータ型を返すよ。整数は <class 'int'> と表示されるよ！",
    xpReward: 10,
    gemReward: 1
)

private let q23 = Question(
    id: 23,
    type: .multipleChoice,
    prompt: "3.14 のデータ型は？",
    codeSnippet: nil,
    choices: ["float（小数）", "int（整数）", "double（倍精度）"],
    correctAnswer: "float（小数）",
    explanation: "小数点を含む数値は float（浮動小数点数）型だよ！",
    xpReward: 10,
    gemReward: 1
)

private let q24 = Question(
    id: 24,
    type: .fillInBlank,
    prompt: "空欄に入る型名は？",
    codeSnippet: "flag = True\nprint(type(flag))\n# <class '_____'>",
    choices: ["bool", "str", "int"],
    correctAnswer: "bool",
    explanation: "True と False は bool（真偽値）型だよ。条件分岐でよく使うよ！",
    xpReward: 10,
    gemReward: 1
)

private let q25 = Question(
    id: 25,
    type: .multipleChoice,
    prompt: "int(\"42\") の結果は？",
    codeSnippet: nil,
    choices: ["整数の42", "文字列の\"42\"", "42.0"],
    correctAnswer: "整数の42",
    explanation: "int() は文字列や小数を整数に変換するよ。\"42\" → 42 になるよ！",
    xpReward: 10,
    gemReward: 1
)

private let q26 = Question(
    id: 26,
    type: .codeOutput,
    prompt: "このコードの出力は？",
    codeSnippet: "print(type(\"hello\"))",
    choices: ["<class 'str'>", "<class 'int'>", "str"],
    correctAnswer: "<class 'str'>",
    explanation: "\"hello\" は文字列なので type() は <class 'str'> を返すよ！",
    xpReward: 10,
    gemReward: 1
)

private let q27 = Question(
    id: 27,
    type: .multipleChoice,
    prompt: "1 + 1.0 の結果の型は？",
    codeSnippet: nil,
    choices: ["float", "int", "str"],
    correctAnswer: "float",
    explanation: "整数と小数を足すと結果は float になるよ。Pythonは自動で型を昇格させるよ！",
    xpReward: 10,
    gemReward: 1
)

private let q28 = Question(
    id: 28,
    type: .codeOutput,
    prompt: "このコードの出力は？",
    codeSnippet: "print(type(True))",
    choices: ["<class 'bool'>", "<class 'int'>", "<class 'str'>"],
    correctAnswer: "<class 'bool'>",
    explanation: "True と False は bool 型だよ。type(True) は <class 'bool'> を返すよ！",
    xpReward: 10,
    gemReward: 1
)

private let q29 = Question(
    id: 29,
    type: .fillInBlank,
    prompt: "変数の型を調べるには？",
    codeSnippet: "print(_____(3.14))",
    choices: ["type", "str", "int"],
    correctAnswer: "type",
    explanation: "type() 関数に値や変数を渡すとデータ型を調べられるよ！",
    xpReward: 10,
    gemReward: 1
)

// ─────────────────────────────────────────────────────────
// MARK: - Lesson 3 · if文を使おう
// ─────────────────────────────────────────────────────────

private let lesson3 = Lesson(
    id: 3,
    title: "if文を使おう",
    shortLabel: "if文",
    subtitle: "判断",
    category: "条件分岐",
    order: 3,
    questions: [q30, q31, q32, q33, q34, q35, q36, q37, q38, q39],
    requiredXP: 150
)

private let q30 = Question(
    id: 30,
    type: .multipleChoice,
    prompt: "if 文は何に使う？",
    codeSnippet: nil,
    choices: ["条件で処理を変える", "繰り返し処理", "関数を作る"],
    correctAnswer: "条件で処理を変える",
    explanation: "if 文は条件が True か False かで実行する処理を切り替えるよ！",
    xpReward: 10,
    gemReward: 1
)

private let q31 = Question(
    id: 31,
    type: .codeOutput,
    prompt: "このコードの出力は？",
    codeSnippet: "x = 10\nif x > 5:\n    print(\"大きい\")",
    choices: ["大きい", "小さい", "10"],
    correctAnswer: "大きい",
    explanation: "x = 10 は 5 より大きいので条件が True となり「大きい」が表示されるよ！",
    xpReward: 10,
    gemReward: 1
)

private let q32 = Question(
    id: 32,
    type: .multipleChoice,
    prompt: "else ブロックは\nいつ実行される？",
    codeSnippet: nil,
    choices: ["if の条件が偽のとき", "if の条件が真のとき", "常に実行される"],
    correctAnswer: "if の条件が偽のとき",
    explanation: "else は if の条件が False（偽）のときに実行されるよ！",
    xpReward: 10,
    gemReward: 1
)

private let q33 = Question(
    id: 33,
    type: .multipleChoice,
    prompt: "elif は何の省略？",
    codeSnippet: nil,
    choices: ["else if", "end if", "else in"],
    correctAnswer: "else if",
    explanation: "elif は「else if」の省略形だよ。複数の条件を連続して書けるよ！",
    xpReward: 10,
    gemReward: 1
)

private let q34 = Question(
    id: 34,
    type: .codeOutput,
    prompt: "このコードの出力は？",
    codeSnippet: "x = 3\nif x > 5:\n    print(\"大\")\nelse:\n    print(\"小\")",
    choices: ["小", "大", "3"],
    correctAnswer: "小",
    explanation: "x = 3 は 5 以下なので if の条件が False となり else の「小」が表示されるよ！",
    xpReward: 10,
    gemReward: 1
)

private let q35 = Question(
    id: 35,
    type: .codeOutput,
    prompt: "このコードの出力は？",
    codeSnippet: "x = 5\nif x == 5:\n    print(\"同じ\")",
    choices: ["同じ", "違う", "5"],
    correctAnswer: "同じ",
    explanation: "== は「等しい」を確認する演算子だよ。x は 5 なので True になり「同じ」が表示されるよ！",
    xpReward: 10,
    gemReward: 1
)

private let q36 = Question(
    id: 36,
    type: .multipleChoice,
    prompt: "「等しい」を確認する\n演算子はどれ？",
    codeSnippet: nil,
    choices: ["==", "=", "!="],
    correctAnswer: "==",
    explanation: "== が「等しい」の比較演算子だよ。= は代入、== は比較として使い分けてね！",
    xpReward: 10,
    gemReward: 1
)

private let q37 = Question(
    id: 37,
    type: .multipleChoice,
    prompt: "「等しくない」を確認する\n演算子はどれ？",
    codeSnippet: nil,
    choices: ["!=", "<>", "=/="],
    correctAnswer: "!=",
    explanation: "!= が「等しくない」の比較演算子だよ。True / False を返すよ！",
    xpReward: 10,
    gemReward: 1
)

private let q38 = Question(
    id: 38,
    type: .codeOutput,
    prompt: "このコードの出力は？",
    codeSnippet: "x = 10\nif x >= 10:\n    print(\"OK\")\nelse:\n    print(\"NG\")",
    choices: ["OK", "NG", "10"],
    correctAnswer: "OK",
    explanation: "x = 10 は 10 以上なので >= の条件が True となり「OK」が表示されるよ！",
    xpReward: 10,
    gemReward: 1
)

private let q39 = Question(
    id: 39,
    type: .fillInBlank,
    prompt: "x が 5 より大きいか\n確認するには？",
    codeSnippet: "if x _____ 5:\n    print(\"大きい\")",
    choices: [">", ">=", "<"],
    correctAnswer: ">",
    explanation: "> は「より大きい」を確認する比較演算子だよ。>= は「以上」だよ！",
    xpReward: 10,
    gemReward: 1
)

// ─────────────────────────────────────────────────────────
// MARK: - Lesson 4 · for文を使おう
// ─────────────────────────────────────────────────────────

private let lesson4 = Lesson(
    id: 4,
    title: "for文を使おう",
    shortLabel: "for文",
    subtitle: "ループ",
    category: "繰り返し",
    order: 4,
    questions: [q40, q41, q42, q43, q44, q45, q46, q47, q48, q49],
    requiredXP: 200
)

private let q40 = Question(
    id: 40,
    type: .multipleChoice,
    prompt: "for 文は何に使う？",
    codeSnippet: nil,
    choices: ["繰り返し処理", "条件分岐", "変数を作る"],
    correctAnswer: "繰り返し処理",
    explanation: "for 文はリストや範囲の各要素に対して処理を繰り返すよ！",
    xpReward: 10,
    gemReward: 1
)

private let q41 = Question(
    id: 41,
    type: .codeOutput,
    prompt: "このコードで最後に\n表示される値は？",
    codeSnippet: "for i in range(3):\n    print(i)",
    choices: ["2", "0", "1"],
    correctAnswer: "2",
    explanation: "range(3) は 0, 1, 2 を生成するよ。最後の値は 2 だよ！",
    xpReward: 10,
    gemReward: 1
)

private let q42 = Question(
    id: 42,
    type: .multipleChoice,
    prompt: "range(5) が生成する\n数列はどれ？",
    codeSnippet: nil,
    choices: ["0, 1, 2, 3, 4", "1, 2, 3, 4, 5", "0, 1, 2, 3, 4, 5"],
    correctAnswer: "0, 1, 2, 3, 4",
    explanation: "range(n) は 0 から n-1 までの整数を生成するよ。range(5) なら 0〜4 の 5 つだよ！",
    xpReward: 10,
    gemReward: 1
)

private let q43 = Question(
    id: 43,
    type: .codeOutput,
    prompt: "このコードで最初に\n表示される文字は？",
    codeSnippet: "for c in \"ABC\":\n    print(c)",
    choices: ["A", "B", "C"],
    correctAnswer: "A",
    explanation: "文字列に対して for を使うと 1 文字ずつ順番に取り出せるよ！最初は「A」だよ。",
    xpReward: 10,
    gemReward: 1
)

private let q44 = Question(
    id: 44,
    type: .fillInBlank,
    prompt: "空欄に入るのは？",
    codeSnippet: "for i in _____(4):\n    print(i)  # 0, 1, 2, 3",
    choices: ["range", "loop", "repeat"],
    correctAnswer: "range",
    explanation: "range() を使うと連続した整数の列を生成できるよ！",
    xpReward: 10,
    gemReward: 1
)

private let q45 = Question(
    id: 45,
    type: .codeOutput,
    prompt: "このコードの出力は？",
    codeSnippet: "total = 0\nfor i in range(3):\n    total += i\nprint(total)",
    choices: ["3", "6", "0"],
    correctAnswer: "3",
    explanation: "i は 0, 1, 2 と変化するよ。0 + 1 + 2 = 3 だよ！+= は左辺に加算して代入する演算子だよ。",
    xpReward: 10,
    gemReward: 1
)

private let q46 = Question(
    id: 46,
    type: .multipleChoice,
    prompt: "break を使うと？",
    codeSnippet: nil,
    choices: ["ループを途中で終了する", "次の繰り返しに飛ぶ", "ループを再開する"],
    correctAnswer: "ループを途中で終了する",
    explanation: "break はループを即座に終了するよ。continue は現在の繰り返しをスキップして次へ進むよ！",
    xpReward: 10,
    gemReward: 1
)

private let q47 = Question(
    id: 47,
    type: .multipleChoice,
    prompt: "range(2, 5) が\n生成するのは？",
    codeSnippet: nil,
    choices: ["2, 3, 4", "2, 3, 4, 5", "1, 2, 3, 4"],
    correctAnswer: "2, 3, 4",
    explanation: "range(start, stop) は start から stop-1 までを生成するよ。range(2, 5) は 2, 3, 4 だよ！",
    xpReward: 10,
    gemReward: 1
)

private let q48 = Question(
    id: 48,
    type: .codeOutput,
    prompt: "最後に表示される文字は？",
    codeSnippet: "words = [\"A\", \"B\", \"C\"]\nfor w in words:\n    print(w)",
    choices: ["C", "A", "B"],
    correctAnswer: "C",
    explanation: "リストの各要素を順番に処理するよ。最後の要素は \"C\" なので最後に「C」が表示されるよ！",
    xpReward: 10,
    gemReward: 1
)

private let q49 = Question(
    id: 49,
    type: .fillInBlank,
    prompt: "1 から始まるループに\nするには？",
    codeSnippet: "for i in range(_____, 3):\n    print(i)  # 1, 2",
    choices: ["1", "0", "2"],
    correctAnswer: "1",
    explanation: "range(start, stop) の start を 1 にすると、1 から始まるループになるよ！",
    xpReward: 10,
    gemReward: 1
)

// ─────────────────────────────────────────────────────────
// MARK: - Lesson 5 · 関数を使おう
// ─────────────────────────────────────────────────────────

private let lesson5 = Lesson(
    id: 5,
    title: "関数を使おう",
    shortLabel: "関数",
    subtitle: "再利用",
    category: "関数",
    order: 5,
    questions: [q50, q51, q52, q53, q54, q55, q56, q57, q58, q59],
    requiredXP: 250
)

private let q50 = Question(
    id: 50,
    type: .multipleChoice,
    prompt: "関数を定義するときに\n使うキーワードは？",
    codeSnippet: nil,
    choices: ["def", "function", "func"],
    correctAnswer: "def",
    explanation: "正解は def だよ！Pythonで関数を作るときは def 関数名(): の形で書くんだ。「関数定義＝def」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q51 = Question(
    id: 51,
    type: .multipleChoice,
    prompt: "関数の中で return を\n使うと何が起きる？",
    codeSnippet: nil,
    choices: ["値を呼び出し元に返す", "画面に表示する", "関数を削除する"],
    correctAnswer: "値を呼び出し元に返す",
    explanation: "正解は 値を呼び出し元に返す だよ！return は関数の処理結果を、呼び出した場所に渡してくれるんだ。「return＝値を返す」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q52 = Question(
    id: 52,
    type: .fillInBlank,
    prompt: "空欄に入る\n正しいキーワードは？",
    codeSnippet: "_____ greet():\n    print(\"こんにちは\")\n\ngreet()",
    choices: ["def", "function", "func"],
    correctAnswer: "def",
    explanation: "正解は def だよ！関数を定義するときは def に続けて関数名と ()、最後に : を書くんだ。「関数定義＝def」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q53 = Question(
    id: 53,
    type: .multipleChoice,
    prompt: "次のうち、正しい\n関数の定義はどれ？",
    codeSnippet: nil,
    choices: ["def greet():", "def greet);", "define greet():"],
    correctAnswer: "def greet():",
    explanation: "正解は def greet(): だよ！def のあとに関数名、()、最後に : をつけるのが正しい書き方なんだ。「関数定義＝def 名前():」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q54 = Question(
    id: 54,
    type: .multipleChoice,
    prompt: "return がない関数を\n呼び出すと、戻り値はどうなる？",
    codeSnippet: nil,
    choices: ["None になる", "エラーになる", "0 になる"],
    correctAnswer: "None になる",
    explanation: "正解は None になる だよ！return を書かない関数は、自動的に「値がない」を意味する None を返すんだ。「戻り値なし＝None」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q55 = Question(
    id: 55,
    type: .codeOutput,
    prompt: "このコードの出力は？",
    codeSnippet: "def add(a, b):\n    return a + b\n\nprint(add(2, 3))",
    choices: ["5", "23", "2 3"],
    correctAnswer: "5",
    explanation: "正解は 5 だよ！add(2, 3) は a に 2、b に 3 が入り、2 + 3 を計算した結果 5 を返すんだ。「関数の戻り値＝計算結果」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q56 = Question(
    id: 56,
    type: .fillInBlank,
    prompt: "空欄に入る\n正しい文字列は？",
    codeSnippet: "def greet(name=\"_____\"):\n    print(\"こんにちは、\" + name)\n\ngreet()  # こんにちは、ゲスト",
    choices: ["ゲスト", "name", "こんにちは"],
    correctAnswer: "ゲスト",
    explanation: "正解は ゲスト だよ！name=\"ゲスト\" のように初期値を設定すると、引数を渡さなかったときにその値が使われるんだ。「デフォルト引数＝省略時の値」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q57 = Question(
    id: 57,
    type: .codeOutput,
    prompt: "このコードを実行すると、\n何が表示される？",
    codeSnippet: "def square(n):\n    return n * n\n\nresult = square(4)\nprint(result)",
    choices: ["16", "4", "44"],
    correctAnswer: "16",
    explanation: "正解は 16 だよ！square(4) は 4 * 4 を計算して 16 を返し、それを result に代入して表示しているんだ。「関数の戻り値＝計算結果」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q58 = Question(
    id: 58,
    type: .multipleChoice,
    prompt: "range(3) が生成する\n数列はどれ？",
    codeSnippet: nil,
    choices: ["0, 1, 2", "1, 2, 3", "0, 1, 2, 3"],
    correctAnswer: "0, 1, 2",
    explanation: "正解は 0, 1, 2 だよ！range(n) は 0 から n-1 までの整数を生成するから、range(3) は 0, 1, 2 になるんだ。「range(n)＝0からn-1」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q59 = Question(
    id: 59,
    type: .codeOutput,
    prompt: "2つの数の大きい方を\n返す関数を作りたい。\n出力はどれ？",
    codeSnippet: "def bigger(a, b):\n    if a > b:\n        return a\n    else:\n        return b\n\nprint(bigger(3, 7))",
    choices: ["7", "3", "a"],
    correctAnswer: "7",
    explanation: "正解は 7 だよ！bigger(3, 7) は 3 と 7 を比べて、大きい方の 7 を返しているんだ。「大きい方を選ぶ＝ifとreturnの組み合わせ」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

// ─────────────────────────────────────────────────────────
// MARK: - Lesson 6 · リストを使おう
// ─────────────────────────────────────────────────────────

private let lesson6 = Lesson(
    id: 6,
    title: "リストを使おう",
    shortLabel: "リスト",
    subtitle: "複数のデータ",
    category: "リスト",
    order: 6,
    questions: [q60, q61, q62, q63, q64, q65, q66, q67, q68, q69],
    requiredXP: 300
)

private let q60 = Question(
    id: 60,
    type: .multipleChoice,
    prompt: "リストを作るときに\n使う記号は？",
    codeSnippet: nil,
    choices: ["[ ]", "( )", "{ }"],
    correctAnswer: "[ ]",
    explanation: "正解は [ ] だよ！Pythonでリストを作るときは [ ] の中に値をカンマ区切りで並べるんだ。「リスト＝[ ]」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q61 = Question(
    id: 61,
    type: .multipleChoice,
    prompt: "リストの最初の要素を\n取り出すインデックスは？",
    codeSnippet: nil,
    choices: ["0", "1", "-1"],
    correctAnswer: "0",
    explanation: "正解は 0 だよ！Pythonのリストは 0 番目から数えるから、最初の要素はインデックス 0 で取り出せるんだ。「最初の要素＝インデックス0」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q62 = Question(
    id: 62,
    type: .fillInBlank,
    prompt: "「りんご」を取り出す\n正しいコードは？",
    codeSnippet: "fruits = [\"りんご\", \"バナナ\", \"みかん\"]\nprint(fruits_____)",
    choices: ["[0]", "[1]", "(0)"],
    correctAnswer: "[0]",
    explanation: "正解は [0] だよ！リストの要素は fruits[0] のように [ ] とインデックス番号で取り出すんだ。最初の要素は 0 番目だよ。「要素の取り出し＝[インデックス]」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q63 = Question(
    id: 63,
    type: .multipleChoice,
    prompt: "次のうち、正しい\nリストの書き方はどれ？",
    codeSnippet: nil,
    choices: ["numbers = [1, 2, 3]", "numbers = (1, 2, 3)", "numbers = {1, 2, 3}"],
    correctAnswer: "numbers = [1, 2, 3]",
    explanation: "正解は numbers = [1, 2, 3] だよ！リストは [ ] を使って作るんだ。( ) はタプル、{ } は辞書やセットに使うから区別しよう。「リスト＝[ ]」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q64 = Question(
    id: 64,
    type: .multipleChoice,
    prompt: "リストの最後の要素を\n取り出すインデックスは？",
    codeSnippet: nil,
    choices: ["-1", "0", "最後の数字"],
    correctAnswer: "-1",
    explanation: "正解は -1 だよ！Pythonでは -1 を指定すると、リストの最後の要素を取り出せるんだ。「最後の要素＝インデックス-1」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q65 = Question(
    id: 65,
    type: .codeOutput,
    prompt: "このコードの出力は？",
    codeSnippet: "fruits = [\"りんご\", \"バナナ\"]\nfruits.append(\"みかん\")\nprint(fruits)",
    choices: ["['りんご', 'バナナ', 'みかん']", "['みかん', 'りんご', 'バナナ']", "['りんご', 'バナナ']"],
    correctAnswer: "['りんご', 'バナナ', 'みかん']",
    explanation: "正解は ['りんご', 'バナナ', 'みかん'] だよ！append() はリストの末尾に新しい要素を追加するメソッドなんだ。「追加＝append で末尾に」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q66 = Question(
    id: 66,
    type: .fillInBlank,
    prompt: "リストの要素数を\n調べる関数は？",
    codeSnippet: "fruits = [\"りんご\", \"バナナ\", \"みかん\"]\nprint(_____(fruits))",
    choices: ["len", "count", "size"],
    correctAnswer: "len",
    explanation: "正解は len だよ！len() にリストを渡すと、要素の数（ここでは 3）を調べられるんだ。「要素数＝len()」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q67 = Question(
    id: 67,
    type: .codeOutput,
    prompt: "このコードを実行すると、\n何が表示される？",
    codeSnippet: "scores = [80, 95, 70]\ntotal = 0\nfor s in scores:\n    total += s\nprint(total)",
    choices: ["245", "80", "3"],
    correctAnswer: "245",
    explanation: "正解は 245 だよ！for でリストの値を順番に取り出して total に足していくと、80 + 95 + 70 = 245 になるんだ。「リストの合計＝forで足し算」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q68 = Question(
    id: 68,
    type: .multipleChoice,
    prompt: "関数の中で return を\n使うと何が起きる？",
    codeSnippet: nil,
    choices: ["値を呼び出し元に返す", "画面に表示する", "関数を削除する"],
    correctAnswer: "値を呼び出し元に返す",
    explanation: "正解は 値を呼び出し元に返す だよ！return は関数の処理結果を呼び出した場所に渡してくれるんだ。「return＝値を返す」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q69 = Question(
    id: 69,
    type: .codeOutput,
    prompt: "リストの中から一番大きい数を\n知りたい。出力はどれ？",
    codeSnippet: "numbers = [3, 7, 2]\nprint(max(numbers))",
    choices: ["7", "3", "12"],
    correctAnswer: "7",
    explanation: "正解は 7 だよ！max() はリストの中から一番大きい値を返してくれるから、3, 7, 2 の中で一番大きい 7 になるんだ。「最大値を探す＝max()」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

// ─────────────────────────────────────────────────────────
// MARK: - Lesson 7 · 辞書を使おう
// ─────────────────────────────────────────────────────────

private let lesson7 = Lesson(
    id: 7,
    title: "辞書を使おう",
    shortLabel: "辞書",
    subtitle: "対応関係",
    category: "辞書",
    order: 7,
    questions: [q70, q71, q72, q73, q74, q75, q76, q77, q78, q79],
    requiredXP: 350
)

private let q70 = Question(
    id: 70,
    type: .multipleChoice,
    prompt: "辞書を作るときに\n使う記号は？",
    codeSnippet: nil,
    choices: ["{ }", "[ ]", "( )"],
    correctAnswer: "{ }",
    explanation: "正解は { } だよ！辞書は { キー: 値 } の形で作るんだ。リストの [ ] と区別しよう。「辞書＝{ }」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q71 = Question(
    id: 71,
    type: .multipleChoice,
    prompt: "辞書から値を\n取り出すには？",
    codeSnippet: nil,
    choices: ["キーを指定する", "インデックス番号を指定する", "値を直接書く"],
    correctAnswer: "キーを指定する",
    explanation: "正解は キーを指定する だよ！辞書は person[\"name\"] のように、キーを指定して対応する値を取り出すんだ。「辞書の取り出し＝キーで指定」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q72 = Question(
    id: 72,
    type: .fillInBlank,
    prompt: "name の値を取り出す\n正しいコードは？",
    codeSnippet: "person = {\"name\": \"太郎\", \"age\": 14}\nprint(person_____)",
    choices: ["[\"name\"]", "[0]", "(\"name\")"],
    correctAnswer: "[\"name\"]",
    explanation: "正解は [\"name\"] だよ！辞書は person[\"name\"] のように [ ] とキーの名前を指定して値を取り出すんだ。「辞書の取り出し＝[キー]」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q73 = Question(
    id: 73,
    type: .multipleChoice,
    prompt: "次のうち、正しい\n辞書の書き方はどれ？",
    codeSnippet: nil,
    choices: ["{\"a\": 1, \"b\": 2}", "[\"a\": 1, \"b\": 2]", "(\"a\": 1, \"b\": 2)"],
    correctAnswer: "{\"a\": 1, \"b\": 2}",
    explanation: "正解は {\"a\": 1, \"b\": 2} だよ！辞書は { } の中に キー: 値 をカンマ区切りで書くんだ。「辞書＝{キー: 値}」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q74 = Question(
    id: 74,
    type: .multipleChoice,
    prompt: "辞書にないキーを [ ] で\n指定すると、どうなる？",
    codeSnippet: nil,
    choices: ["エラーになる", "None が返る", "0 が返る"],
    correctAnswer: "エラーになる",
    explanation: "正解は エラーになる だよ！存在しないキーを [ ] で指定すると KeyError というエラーが発生するんだ。安全に取り出すには get() が便利だよ。「存在しないキー＝KeyError」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q75 = Question(
    id: 75,
    type: .codeOutput,
    prompt: "このコードの出力は？",
    codeSnippet: "person = {\"name\": \"太郎\"}\nperson[\"age\"] = 14\nprint(person)",
    choices: ["{'name': '太郎', 'age': 14}", "{'name': '太郎'}", "{'age': 14}"],
    correctAnswer: "{'name': '太郎', 'age': 14}",
    explanation: "正解は {'name': '太郎', 'age': 14} だよ！person[\"age\"] = 14 のように新しいキーへ代入すると、辞書に追加されるんだ。「辞書への追加＝新しいキーに代入」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q76 = Question(
    id: 76,
    type: .fillInBlank,
    prompt: "存在しないキーでも\nエラーにせず取り出すには？",
    codeSnippet: "person = {\"name\": \"太郎\"}\nprint(person._____(\"age\", 0))",
    choices: ["get", "fetch", "find"],
    correctAnswer: "get",
    explanation: "正解は get だよ！get(\"age\", 0) は \"age\" キーがなければ代わりに 0 を返してくれるから、エラーを防げるんだ。「安全な取り出し＝get()」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q77 = Question(
    id: 77,
    type: .codeOutput,
    prompt: "このコードを実行すると、\n最初に表示されるのは？",
    codeSnippet: "scores = {\"国語\": 80, \"数学\": 90}\nfor subject in scores:\n    print(subject)",
    choices: ["国語", "数学", "80"],
    correctAnswer: "国語",
    explanation: "正解は 国語 だよ！辞書を for で繰り返すと、登録した順にキーが取り出されるんだ。最初のキーは「国語」だよ。「辞書のfor＝キーを順番に取り出す」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q78 = Question(
    id: 78,
    type: .multipleChoice,
    prompt: "リストに新しい要素を\n追加するメソッドは？",
    codeSnippet: nil,
    choices: ["append", "add", "push"],
    correctAnswer: "append",
    explanation: "正解は append だよ！リストの末尾に要素を追加するときは append() を使うんだ。「追加＝append」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q79 = Question(
    id: 79,
    type: .codeOutput,
    prompt: "「バナナ」の値段を\n調べたい。出力はどれ？",
    codeSnippet: "prices = {\"りんご\": 100, \"バナナ\": 50}\nitem = \"バナナ\"\nprint(prices[item])",
    choices: ["50", "100", "バナナ"],
    correctAnswer: "50",
    explanation: "正解は 50 だよ！変数 item に \"バナナ\" を入れて prices[item] とすると、対応する値段 50 が取り出せるんだ。「辞書で検索＝キー名で取り出す」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

// ─────────────────────────────────────────────────────────
// MARK: - Lesson 8 · 文字列を扱おう
// ─────────────────────────────────────────────────────────

private let lesson8 = Lesson(
    id: 8,
    title: "文字列を扱おう",
    shortLabel: "文字列",
    subtitle: "テキスト操作",
    category: "文字列処理",
    order: 8,
    questions: [q80, q81, q82, q83, q84, q85, q86, q87, q88, q89],
    requiredXP: 400
)

private let q80 = Question(
    id: 80,
    type: .multipleChoice,
    prompt: "文字列の長さ（文字数）を\n調べる関数は？",
    codeSnippet: nil,
    choices: ["len", "size", "count"],
    correctAnswer: "len",
    explanation: "正解は len だよ！len(\"hello\") のように文字列を渡すと、文字数を調べられるんだ。「文字数＝len()」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q81 = Question(
    id: 81,
    type: .multipleChoice,
    prompt: "文字列を全て大文字に\n変換するメソッドは？",
    codeSnippet: nil,
    choices: ["upper()", "lower()", "capital()"],
    correctAnswer: "upper()",
    explanation: "正解は upper() だよ！\"hello\".upper() のように書くと、すべて大文字に変換できるんだ。「大文字化＝upper()」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q82 = Question(
    id: 82,
    type: .fillInBlank,
    prompt: "文字列を大文字に\n変換する正しいコードは？",
    codeSnippet: "name = \"python\"\nprint(name._____())",
    choices: ["upper", "lower", "big"],
    correctAnswer: "upper",
    explanation: "正解は upper だよ！name.upper() と書くと、文字列を大文字に変換して返してくれるんだ。「大文字化＝upper()」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q83 = Question(
    id: 83,
    type: .multipleChoice,
    prompt: "「こんにちは」の\n文字数は？",
    codeSnippet: nil,
    choices: ["5", "4", "6"],
    correctAnswer: "5",
    explanation: "正解は 5 だよ！「こんにちは」は こ・ん・に・ち・は の 5 文字だから、len() は 5 を返すんだ。「文字数を数える＝len()」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q84 = Question(
    id: 84,
    type: .multipleChoice,
    prompt: "文字列を全て小文字に\n変換するメソッドは？",
    codeSnippet: nil,
    choices: ["lower()", "upper()", "small()"],
    correctAnswer: "lower()",
    explanation: "正解は lower() だよ！\"PYTHON\".lower() のように書くと、すべて小文字に変換できるんだ。「小文字化＝lower()」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q85 = Question(
    id: 85,
    type: .codeOutput,
    prompt: "このコードの出力は？",
    codeSnippet: "word = \"Python\"\nprint(word[0:3])",
    choices: ["Pyt", "Pytho", "thon"],
    correctAnswer: "Pyt",
    explanation: "正解は Pyt だよ！word[0:3] は インデックス 0 から 3 の手前まで、つまり P, y, t を取り出すんだ。「スライス＝[開始:終了の手前まで]」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q86 = Question(
    id: 86,
    type: .fillInBlank,
    prompt: "文字列の一部を\n置き換える正しいコードは？",
    codeSnippet: "text = \"I like cats\"\nprint(text._____(\"cats\", \"dogs\"))",
    choices: ["replace", "change", "swap"],
    correctAnswer: "replace",
    explanation: "正解は replace だよ！text.replace(\"cats\", \"dogs\") のように書くと、指定した文字列を別の文字列に置き換えられるんだ。「置き換え＝replace()」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q87 = Question(
    id: 87,
    type: .codeOutput,
    prompt: "このコードを実行すると、\n何が表示される？",
    codeSnippet: "sentence = \"I love Python\"\nwords = sentence.split()\nprint(len(words))",
    choices: ["3", "13", "I love Python"],
    correctAnswer: "3",
    explanation: "正解は 3 だよ！split() は文字列を空白で区切ってリストにするから [\"I\", \"love\", \"Python\"] となり、len() で要素数 3 が求まるんだ。「単語に分割＝split()」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q88 = Question(
    id: 88,
    type: .multipleChoice,
    prompt: "辞書から値を取り出すときに\n指定するものは？",
    codeSnippet: nil,
    choices: ["キー", "インデックス番号", "値そのもの"],
    correctAnswer: "キー",
    explanation: "正解は キー だよ！辞書は person[\"name\"] のように、キーを指定して対応する値を取り出すんだ。「辞書の取り出し＝キーで指定」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q89 = Question(
    id: 89,
    type: .codeOutput,
    prompt: "メールアドレスに @ が\n含まれているか確認したい。\n出力はどれ？",
    codeSnippet: "email = \"taro@example.com\"\nprint(\"@\" in email)",
    choices: ["True", "False", "@"],
    correctAnswer: "True",
    explanation: "正解は True だよ！in 演算子は指定した文字が文字列に含まれていれば True を返すんだ。email には @ が含まれているから True になるよ。「含まれているか確認＝in」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

// ─────────────────────────────────────────────────────────
// MARK: - Lesson 9 · エラーを読もう
// ─────────────────────────────────────────────────────────

private let lesson9 = Lesson(
    id: 9,
    title: "エラーを読もう",
    shortLabel: "エラー",
    subtitle: "例外処理",
    category: "例外処理",
    order: 9,
    questions: [q90, q91, q92, q93, q94, q95, q96, q97, q98, q99],
    requiredXP: 450
)

private let q90 = Question(
    id: 90,
    type: .multipleChoice,
    prompt: "プログラム実行中に発生する\n問題のことを何という？",
    codeSnippet: nil,
    choices: ["エラー（例外）", "コメント", "変数"],
    correctAnswer: "エラー（例外）",
    explanation: "正解は エラー（例外） だよ！プログラムを実行している途中で起きる問題のことを「エラー」または「例外」と呼ぶんだ。「実行時の問題＝エラー（例外）」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q91 = Question(
    id: 91,
    type: .multipleChoice,
    prompt: "定義されていない変数名を\n使うと発生するエラーは？",
    codeSnippet: nil,
    choices: ["NameError", "TypeError", "IndexError"],
    correctAnswer: "NameError",
    explanation: "正解は NameError だよ！定義されていない名前を使うと、Pythonは「その名前は定義されていません」という意味の NameError を出すんだ。「未定義の名前＝NameError」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q92 = Question(
    id: 92,
    type: .fillInBlank,
    prompt: "0で割ったときのエラー\nメッセージに出てくる単語は？",
    codeSnippet: "print(10 / 0)\n# ZeroDivisionError: division by _____",
    choices: ["zero", "none", "null"],
    correctAnswer: "zero",
    explanation: "正解は zero だよ！数を 0 で割ろうとすると、Pythonは ZeroDivisionError: division by zero というエラーを出すんだ。「ゼロ除算＝ZeroDivisionError」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q93 = Question(
    id: 93,
    type: .multipleChoice,
    prompt: "エラー（例外）が発生して\n対処していないと、プログラムは？",
    codeSnippet: nil,
    choices: ["そこで停止する", "そのまま続行する", "自動で修正される"],
    correctAnswer: "そこで停止する",
    explanation: "正解は そこで停止する だよ！エラーが発生すると、特に対処していなければプログラムはそこで止まってしまうんだ。「エラー発生＝そこで停止」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q94 = Question(
    id: 94,
    type: .multipleChoice,
    prompt: "リストの範囲外の番号を\n指定すると発生するエラーは？",
    codeSnippet: nil,
    choices: ["IndexError", "NameError", "TypeError"],
    correctAnswer: "IndexError",
    explanation: "正解は IndexError だよ！リストに存在しない番号を指定すると、「範囲外です」という意味の IndexError が出るんだ。「範囲外アクセス＝IndexError」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q95 = Question(
    id: 95,
    type: .codeOutput,
    prompt: "このコードの出力は？",
    codeSnippet: "try:\n    print(10 / 0)\nexcept ZeroDivisionError:\n    print(\"0では割れないよ\")",
    choices: ["0では割れないよ", "10 / 0", "エラーで停止する"],
    correctAnswer: "0では割れないよ",
    explanation: "正解は 0では割れないよ だよ！try の中でエラーが起きると、対応する except のブロックが実行されてメッセージが表示されるんだ。「try/except＝エラーを捕まえて処理を続ける」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q96 = Question(
    id: 96,
    type: .fillInBlank,
    prompt: "エラーが起きるかもしれない\n処理を囲むキーワードは？",
    codeSnippet: "_____:\n    print(int(\"abc\"))\nexcept ValueError:\n    print(\"数字に変換できないよ\")",
    choices: ["try", "catch", "check"],
    correctAnswer: "try",
    explanation: "正解は try だよ！エラーが起きるかもしれない処理を try ブロックで囲み、except でエラー発生時の処理を書くんだ。「try/except＝エラー対策の基本構文」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q97 = Question(
    id: 97,
    type: .codeOutput,
    prompt: "このコードを実行すると、\n何が表示される？",
    codeSnippet: "try:\n    result = \"5\" + 5\nexcept TypeError:\n    result = \"型が違うよ\"\nprint(result)",
    choices: ["型が違うよ", "55", "10"],
    correctAnswer: "型が違うよ",
    explanation: "正解は 型が違うよ だよ！文字列と数値は + で直接つなげられず TypeError が発生するから、except の処理が実行されて「型が違うよ」が表示されるんだ。「文字列＋数値＝TypeError」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q98 = Question(
    id: 98,
    type: .multipleChoice,
    prompt: "文字列の中に特定の文字が\n含まれているか調べる演算子は？",
    codeSnippet: nil,
    choices: ["in", "==", "+"],
    correctAnswer: "in",
    explanation: "正解は in だよ！\"@\" in email のように書くと、文字列の中に指定した文字が含まれているか調べられるんだ。「含まれているか確認＝in」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q99 = Question(
    id: 99,
    type: .codeOutput,
    prompt: "ユーザーの入力が数字に\n変換できないときに備えたい。\n出力はどれ？",
    codeSnippet: "text = \"abc\"\ntry:\n    number = int(text)\nexcept ValueError:\n    number = 0\nprint(number)",
    choices: ["0", "abc", "エラーで停止する"],
    correctAnswer: "0",
    explanation: "正解は 0 だよ！int(\"abc\") は変換できず ValueError が起きるけど、except で 0 を代入しているから安全に処理が続くんだ。「変換失敗に備える＝try/exceptで初期値を用意」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)
