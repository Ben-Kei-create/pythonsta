//
//  PythonBasics.swift
//  pythonsta
//
//  Created by 茂木史明 on 2026/06/05.
//
//  Course: Python基礎
//  Course ID: 0
//  Lesson ID range:   0–9    (10 lessons at full scale; 5 seed lessons now)
//  Lesson order range: 0–9   (globally unique; drives unlock sequencing)
//  Question ID range: 0–99   (100 questions at full scale; 50 seed questions now)
//
//  SEED STATE: 5 lessons / 50 questions  (10 per lesson)
//  TARGET:     10 lessons / 100 questions
//
//  HOW TO ADD A LESSON
//  1. Create a `private let lessonN` constant with `order: N` (next in sequence).
//  2. Create `private let qNN, qNN1, ...` Question constants (IDs N*10 through N*10+9).
//  3. Append `lessonN` to `PythonBasicsCourse.course.lessons`.
//  4. Lesson unlock is automatic: completedLessons counter drives HomeView node states.
//
//  REMAINING LESSONS (stub — implement when content is ready)
//  lesson5 — リスト入門         order 5, question IDs 50–59
//  lesson6 — 文字列操作         order 6, question IDs 60–69
//  lesson7 — 関数の基礎         order 7, question IDs 70–79
//  lesson8 — 辞書の基礎         order 8, question IDs 80–89
//  lesson9 — 例外処理入門       order 9, question IDs 90–99
//

import Foundation

enum PythonBasicsCourse {
    static let course = Course(
        id: 0,
        title: "Python基礎",
        subtitle: "Pythonの基本を身につけよう",
        lessons: [lesson0, lesson1, lesson2, lesson3, lesson4]
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
