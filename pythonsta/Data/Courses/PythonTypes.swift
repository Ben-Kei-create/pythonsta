//
//  PythonTypes.swift
//  pythonsta
//
//  Created by 茂木史明 on 2026/06/08.
//
//  Course: 変数と型
//  Course ID: 1
//  Lesson ID range:   10–19  (10 lessons at full scale — COMPLETE)
//  Lesson order range: 10–19 (globally unique; drives unlock sequencing)
//  Question ID range: 100–199 (100 questions at full scale — COMPLETE)
//
//  STATE: 10 lessons / 100 questions  (10 per lesson) — course COMPLETE
//
//  Authored per PythonSta Authoring Guidelines v1.3:
//  fixed 5 multipleChoice / 3 codeOutput / 2 fillInBlank per lesson,
//  3-choice rule, 答え→なぜ→覚え方 explanation template, Review/Interleaving
//  pulled from the immediately preceding 1–5 lessons (Slot 9), Mini Practical
//  scenario in Slot 10, and Rule D practical-variable-naming from Slot 4 onward
//  (price, user_name, total, is_valid, item_list, email, age, score, ...).
//

import Foundation

enum PythonTypesCourse {
    static let course = Course(
        id: 1,
        title: "変数と型",
        subtitle: "値の種類と扱い方を学ぼう",
        lessons: [lesson10, lesson11, lesson12, lesson13, lesson14, lesson15, lesson16, lesson17, lesson18, lesson19]
    )
}


// ─────────────────────────────────────────────────────────
// MARK: - Lesson 10 · 変数名を理解しよう
// ─────────────────────────────────────────────────────────

private let lesson10 = Lesson(
    id: 10,
    title: "変数名を理解しよう",
    shortLabel: "変数名",
    subtitle: "ルール",
    category: "変数と型",
    order: 10,
    questions: [q100, q101, q102, q103, q104, q105, q106, q107, q108, q109],
    requiredXP: 500
)

private let q100 = Question(
    id: 100,
    type: .multipleChoice,
    prompt: "Pythonの変数名のルールとして\n正しいものは？",
    codeSnippet: nil,
    choices: ["数字から始めない", "記号から始めてもよい", "スペースを使ってもよい"],
    correctAnswer: "数字から始めない",
    explanation: "正解は 数字から始めない だよ！Pythonの変数名は数字で始めることができないんだ。「変数名＝数字スタート禁止」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q101 = Question(
    id: 101,
    type: .multipleChoice,
    prompt: "Pythonでよく使われる\n変数名の書き方は？",
    codeSnippet: nil,
    choices: ["snake_case（小文字とアンダースコア）", "CamelCase（先頭大文字）", "全部大文字＋記号"],
    correctAnswer: "snake_case（小文字とアンダースコア）",
    explanation: "正解は snake_case（小文字とアンダースコア） だよ！Pythonでは user_name のように小文字とアンダースコアでつなぐ書き方が一般的なんだ。「Pythonの変数名＝snake_case」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q102 = Question(
    id: 102,
    type: .fillInBlank,
    prompt: "変数に値を入れる（代入する）\nときに使う記号は？",
    codeSnippet: "user_name _____ \"太郎\"",
    choices: ["=", "==", "->"],
    correctAnswer: "=",
    explanation: "正解は = だよ！= は右側の値を左側の変数に代入する記号なんだ。比較に使う == とは違うので注意しよう。「代入＝=」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q103 = Question(
    id: 103,
    type: .multipleChoice,
    prompt: "ユーザーの年齢を保存する\n変数名として最も適切なのは？",
    codeSnippet: nil,
    choices: ["age", "a", "data1"],
    correctAnswer: "age",
    explanation: "正解は age だよ！何のデータかひと目でわかる名前をつけると、後でコードを読む人（未来の自分も）が理解しやすいんだ。「中身がわかる名前＝age」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q104 = Question(
    id: 104,
    type: .multipleChoice,
    prompt: "商品の値段を保存する\n変数名として最も適切なのは？",
    codeSnippet: nil,
    choices: ["price", "p", "x1"],
    correctAnswer: "price",
    explanation: "正解は price だよ！price なら「値段が入っている」とすぐわかるよね。x1 のような名前だと、コードを読み返したときに中身が想像できないんだ。「値段＝price」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q105 = Question(
    id: 105,
    type: .codeOutput,
    prompt: "このコードの出力は？",
    codeSnippet: "user_name = \"太郎\"\nage = 16\nprint(user_name, age)",
    choices: ["太郎 16", "user_name age", "エラーになる"],
    correctAnswer: "太郎 16",
    explanation: "正解は 太郎 16 だよ！print() に複数の変数をカンマで渡すと、それぞれの中身がスペース区切りで表示されるんだ。「print(変数, 変数)＝中身を順番に表示」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q106 = Question(
    id: 106,
    type: .fillInBlank,
    prompt: "次の値段を表す変数の\n名前として空欄に入るのは？",
    codeSnippet: "_____ = 280\nprint(\"値段は\", _____, \"円\")",
    choices: ["price", "1number", "my-price"],
    correctAnswer: "price",
    explanation: "正解は price だよ！1number は数字スタートでNG、my-price はハイフンが使えないからNGなんだ。「使える変数名＝英字スタート＋アンダースコア」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q107 = Question(
    id: 107,
    type: .codeOutput,
    prompt: "このコードを実行すると\n何が表示される？",
    codeSnippet: "item_name = \"ノート\"\ntotal = 3\nprint(item_name, \"が\", total, \"冊\")",
    choices: ["ノート が 3 冊", "item_name が total 冊", "エラーになる"],
    correctAnswer: "ノート が 3 冊",
    explanation: "正解は ノート が 3 冊 だよ！print() の中の変数は中身の値に置き換わって表示されるんだ。「変数は中身の値で表示される」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q108 = Question(
    id: 108,
    type: .multipleChoice,
    prompt: "0で割ったときに発生する\nエラーの名前は？",
    codeSnippet: nil,
    choices: ["ZeroDivisionError", "NameError", "TypeError"],
    correctAnswer: "ZeroDivisionError",
    explanation: "正解は ZeroDivisionError だよ！数を 0 で割ろうとすると Python はこのエラーを出すんだったね。「ゼロ除算＝ZeroDivisionError」と覚えておこう！（前のレッスン「エラーを読もう」の復習だよ）",
    xpReward: 10,
    gemReward: 1
)

private let q109 = Question(
    id: 109,
    type: .codeOutput,
    prompt: "アプリのプロフィール画面用に\n名前と年齢を表示したい。\n出力はどれ？",
    codeSnippet: "user_name = \"花子\"\nage = 20\nprint(user_name + \"さん（\" + str(age) + \"歳）\")",
    choices: ["花子さん（20歳）", "user_nameさん（age歳）", "エラーになる"],
    correctAnswer: "花子さん（20歳）",
    explanation: "正解は 花子さん（20歳） だよ！+ で文字列をつなげるときは、数値の age を str() で文字列に変換してからつなぐ必要があるんだ。「数値を文章に混ぜる前に＝str()で変換」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)


// ─────────────────────────────────────────────────────────
// MARK: - Lesson 11 · 数値型を理解しよう
// ─────────────────────────────────────────────────────────

private let lesson11 = Lesson(
    id: 11,
    title: "数値型を理解しよう",
    shortLabel: "数値型",
    subtitle: "int / float",
    category: "変数と型",
    order: 11,
    questions: [q110, q111, q112, q113, q114, q115, q116, q117, q118, q119],
    requiredXP: 550
)

private let q110 = Question(
    id: 110,
    type: .multipleChoice,
    prompt: "整数を表す型の名前は？",
    codeSnippet: nil,
    choices: ["int", "str", "bool"],
    correctAnswer: "int",
    explanation: "正解は int だよ！1 や 100 のような整数は int（インテジャー）型として扱われるんだ。「整数＝int」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q111 = Question(
    id: 111,
    type: .multipleChoice,
    prompt: "小数を表す型の名前は？",
    codeSnippet: nil,
    choices: ["float", "int", "double"],
    correctAnswer: "float",
    explanation: "正解は float だよ！3.14 のような小数は float（フロート）型として扱われるんだ。「小数＝float」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q112 = Question(
    id: 112,
    type: .fillInBlank,
    prompt: "値の型を調べるときに\n使う関数は？",
    codeSnippet: "print(_____(100))\n# <class 'int'>",
    choices: ["type", "kind", "class"],
    correctAnswer: "type",
    explanation: "正解は type だよ！type(値) と書くと、その値がどんな型かを調べられるんだ。「型を調べる＝type()」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q113 = Question(
    id: 113,
    type: .multipleChoice,
    prompt: "商品の価格を保存するのに\nふさわしい型はどれ？",
    codeSnippet: nil,
    choices: ["int（例：price = 280）", "str（例：price = \"二百八十\"）", "bool（例：price = True）"],
    correctAnswer: "int（例：price = 280）",
    explanation: "正解は int（例：price = 280） だよ！価格のように計算に使う数は int や float で持つと、合計や割引の計算がそのままできるんだ。「計算する数＝int / float」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q114 = Question(
    id: 114,
    type: .multipleChoice,
    prompt: "テストの平均点のように\n小数になりうる値に\nふさわしい型はどれ？",
    codeSnippet: nil,
    choices: ["float（例：average = 76.5）", "int（例：average = 76.5）", "str（例：average = 76.5）"],
    correctAnswer: "float（例：average = 76.5）",
    explanation: "正解は float（例：average = 76.5） だよ！平均点のように小数点が出る可能性のある値は float で扱うのが自然なんだ。「小数になりうる値＝float」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q115 = Question(
    id: 115,
    type: .codeOutput,
    prompt: "このコードの出力は？",
    codeSnippet: "price = 100\ntax = 1.1\ntotal = price * tax\nprint(total)",
    choices: ["110.00000000000001", "100", "1.1"],
    correctAnswer: "110.00000000000001",
    explanation: "正解は 110.00000000000001 だよ！int と float をかけ算すると float になり、コンピュータの計算の都合で細かい誤差が出ることがあるんだ。「int × float＝floatになり、誤差が出ることもある」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q116 = Question(
    id: 116,
    type: .fillInBlank,
    prompt: "次のコードで total の型を\n確認したい。空欄に入るのは？",
    codeSnippet: "price = 280\nquantity = 3\ntotal = price * quantity\nprint(_____(total))",
    choices: ["type", "int", "len"],
    correctAnswer: "type",
    explanation: "正解は type だよ！type(total) と書けば、total が int なのか float なのかをその場で確認できるんだ。「中身の型を確認＝type()」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q117 = Question(
    id: 117,
    type: .codeOutput,
    prompt: "このコードを実行すると\n何が表示される？",
    codeSnippet: "score = 88\nbonus = 2.5\nprint(type(score), type(bonus))",
    choices: ["<class 'int'> <class 'float'>", "<class 'float'> <class 'int'>", "<class 'int'> <class 'int'>"],
    correctAnswer: "<class 'int'> <class 'float'>",
    explanation: "正解は <class 'int'> <class 'float'> だよ！整数の score は int、小数の bonus は float と表示されるんだ。「整数＝int、小数＝float」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q118 = Question(
    id: 118,
    type: .multipleChoice,
    prompt: "Pythonでよく使われる\n変数名の書き方は？",
    codeSnippet: nil,
    choices: ["snake_case（小文字とアンダースコア）", "CamelCase（先頭大文字）", "全部大文字＋記号"],
    correctAnswer: "snake_case（小文字とアンダースコア）",
    explanation: "正解は snake_case（小文字とアンダースコア） だよ！前のレッスンでも見た通り、Pythonでは user_name のように小文字とアンダースコアでつなぐ書き方が基本なんだ。「Pythonの変数名＝snake_case」と覚えておこう！（前のレッスン「変数名を理解しよう」の復習だよ）",
    xpReward: 10,
    gemReward: 1
)

private let q119 = Question(
    id: 119,
    type: .codeOutput,
    prompt: "レシートの合計金額を\n計算して表示したい。\n出力はどれ？",
    codeSnippet: "item_price = 350\nquantity = 4\ntotal = item_price * quantity\nprint(\"合計：\" + str(total) + \"円\")",
    choices: ["合計：1400円", "合計：item_price * quantity円", "エラーになる"],
    correctAnswer: "合計：1400円",
    explanation: "正解は 合計：1400円 だよ！int 同士のかけ算 350 * 4 は 1400 になり、str() で文字列に変換してから + でつなげているんだ。「単価×数量＝合計」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)


// ─────────────────────────────────────────────────────────
// MARK: - Lesson 12 · 文字列型を理解しよう
// ─────────────────────────────────────────────────────────

private let lesson12 = Lesson(
    id: 12,
    title: "文字列型を理解しよう",
    shortLabel: "文字列型",
    subtitle: "str",
    category: "変数と型",
    order: 12,
    questions: [q120, q121, q122, q123, q124, q125, q126, q127, q128, q129],
    requiredXP: 600
)

private let q120 = Question(
    id: 120,
    type: .multipleChoice,
    prompt: "文字列を表す型の名前は？",
    codeSnippet: nil,
    choices: ["str", "int", "float"],
    correctAnswer: "str",
    explanation: "正解は str だよ！\"こんにちは\" のような文字の並びは str（ストリング）型として扱われるんだ。「文字列＝str」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q121 = Question(
    id: 121,
    type: .multipleChoice,
    prompt: "文字列を作るときに\n使う記号は？",
    codeSnippet: nil,
    choices: ["クォーテーション（\" \" や ' '）", "丸かっこ（ ( ) ）", "波かっこ（ { } ）"],
    correctAnswer: "クォーテーション（\" \" や ' '）",
    explanation: "正解は クォーテーション（\" \" や ' '） だよ！\"こんにちは\" や 'こんにちは' のように、文字列はクォーテーションで囲んで作るんだ。「文字列＝クォーテーションで囲む」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q122 = Question(
    id: 122,
    type: .fillInBlank,
    prompt: "文字列同士をつなげる\n演算子は？",
    codeSnippet: "greeting = \"こんにちは\" _____ \"！\"\nprint(greeting)",
    choices: ["+", "-", "*"],
    correctAnswer: "+",
    explanation: "正解は + だよ！文字列同士は + でつなげることができるんだ。\"こんにちは\" + \"！\" は \"こんにちは！\" になるよ。「文字列の結合＝+」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q123 = Question(
    id: 123,
    type: .multipleChoice,
    prompt: "ユーザーの名前を保存する\n変数の型として適切なのは？",
    codeSnippet: nil,
    choices: ["str（例：user_name = \"花子\"）", "int（例：user_name = 12345）", "bool（例：user_name = True）"],
    correctAnswer: "str（例：user_name = \"花子\"）",
    explanation: "正解は str（例：user_name = \"花子\"） だよ！名前のような文字の並びは str で持つのが自然なんだ。「名前・文章のデータ＝str」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q124 = Question(
    id: 124,
    type: .multipleChoice,
    prompt: "メールアドレスを保存する\n変数の型として適切なのは？",
    codeSnippet: nil,
    choices: ["str（例：email = \"taro@example.com\"）", "int（例：email = 1234）", "float（例：email = 1.5）"],
    correctAnswer: "str（例：email = \"taro@example.com\"）",
    explanation: "正解は str（例：email = \"taro@example.com\"） だよ！メールアドレスは数字を含んでいても「文字の並び」として扱うので str になるんだ。「@を含む文字の並び＝str」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q125 = Question(
    id: 125,
    type: .codeOutput,
    prompt: "このコードの出力は？",
    codeSnippet: "user_name = \"太郎\"\nmessage = \"ようこそ、\" + user_name + \"さん\"\nprint(message)",
    choices: ["ようこそ、太郎さん", "ようこそ、user_nameさん", "エラーになる"],
    correctAnswer: "ようこそ、太郎さん",
    explanation: "正解は ようこそ、太郎さん だよ！+ でつなげると、変数 user_name の中身 \"太郎\" がそのまま文章に組み込まれるんだ。「文字列の結合＝中身の値がつながる」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q126 = Question(
    id: 126,
    type: .fillInBlank,
    prompt: "数値を文字列に変換して\n他の文字列とつなげたい。\n空欄に入るのは？",
    codeSnippet: "age = 16\nmessage = \"年齢は\" + _____(age) + \"歳です\"\nprint(message)",
    choices: ["str", "int", "float"],
    correctAnswer: "str",
    explanation: "正解は str だよ！文字列と数値は + で直接つなげられないから、str(age) で先に文字列に変換してからつなぐ必要があるんだ。「数値と文字をつなぐ前に＝str()で変換」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q127 = Question(
    id: 127,
    type: .codeOutput,
    prompt: "このコードを実行すると\n何が表示される？",
    codeSnippet: "item_name = \"ノート\"\nprint(\"商品名：\" + item_name)\nprint(len(item_name))",
    choices: ["商品名：ノート\n3", "商品名：ノート\nノート", "エラーになる"],
    correctAnswer: "商品名：ノート\n3",
    explanation: "正解は 商品名：ノート / 3 だよ！1行目で商品名を表示し、2行目の len(item_name) で文字数（「ノート」の3文字）が表示されるんだ。「len(文字列)＝文字数」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q128 = Question(
    id: 128,
    type: .multipleChoice,
    prompt: "値段を保存する変数として\n最も適切な型と名前は？",
    codeSnippet: nil,
    choices: ["int の price（例：price = 280）", "str の price（例：price = \"280\"）", "bool の price（例：price = True）"],
    correctAnswer: "int の price（例：price = 280）",
    explanation: "正解は int の price（例：price = 280） だよ！計算に使う値段は文字列ではなく int で持っておくのが基本なんだ。「計算する数値＝int、表示する文章＝str」と覚えておこう！（前のレッスン「数値型を理解しよう」の復習だよ）",
    xpReward: 10,
    gemReward: 1
)

private let q129 = Question(
    id: 129,
    type: .codeOutput,
    prompt: "チャットアプリの\n挨拶メッセージを\n組み立てたい。出力はどれ？",
    codeSnippet: "user_name = \"陽子\"\ngreeting = \"こんにちは、\" + user_name + \"さん！\"\nprint(greeting)",
    choices: ["こんにちは、陽子さん！", "こんにちは、user_nameさん！", "エラーになる"],
    correctAnswer: "こんにちは、陽子さん！",
    explanation: "正解は こんにちは、陽子さん！ だよ！user_name の中身 \"陽子\" が文章に組み込まれて表示されるんだ。「名前を使ったメッセージ＝文字列の結合」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)


// ─────────────────────────────────────────────────────────
// MARK: - Lesson 13 · 真偽値を理解しよう
// ─────────────────────────────────────────────────────────

private let lesson13 = Lesson(
    id: 13,
    title: "真偽値を理解しよう",
    shortLabel: "真偽値",
    subtitle: "bool",
    category: "変数と型",
    order: 13,
    questions: [q130, q131, q132, q133, q134, q135, q136, q137, q138, q139],
    requiredXP: 650
)

private let q130 = Question(
    id: 130,
    type: .multipleChoice,
    prompt: "真偽値（True / False）を\n表す型の名前は？",
    codeSnippet: nil,
    choices: ["bool", "str", "int"],
    correctAnswer: "bool",
    explanation: "正解は bool だよ！True（真）と False（偽）の2つの値だけを持つ型を bool（ブール）型と呼ぶんだ。「真偽値＝bool」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q131 = Question(
    id: 131,
    type: .multipleChoice,
    prompt: "Pythonで「真」を表す\nキーワードは？",
    codeSnippet: nil,
    choices: ["True", "true", "TRUE"],
    correctAnswer: "True",
    explanation: "正解は True だよ！Pythonでは先頭が大文字の True / False と書く決まりなんだ。小文字の true と書くとエラーになるよ。「真偽値＝先頭大文字のTrue / False」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q132 = Question(
    id: 132,
    type: .fillInBlank,
    prompt: "2つの値が等しいかどうかを\n比べる演算子は？",
    codeSnippet: "print(score _____ 100)\n# scoreが100なら True",
    choices: ["==", "=", "!="],
    correctAnswer: "==",
    explanation: "正解は == だよ！== は「等しいかどうか」を調べる比較演算子なんだ。1つの = は代入なので意味が違うから注意しよう。「等しいか比べる＝==」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q133 = Question(
    id: 133,
    type: .multipleChoice,
    prompt: "入力されたメールアドレスが\n空でないかを確認した結果を\n保存する変数として適切なのは？",
    codeSnippet: nil,
    choices: ["is_valid（例：is_valid = True）", "valid_text（例：valid_text = \"はい\"）", "valid_number（例：valid_number = 1）"],
    correctAnswer: "is_valid（例：is_valid = True）",
    explanation: "正解は is_valid（例：is_valid = True） だよ！「正しいかどうか」のような True / False の値には is_valid のような名前をつけると意味が伝わりやすいんだ。「真偽値の変数名＝is_から始めると分かりやすい」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q134 = Question(
    id: 134,
    type: .multipleChoice,
    prompt: "テストの点数が\n合格ラインを超えたかを\n調べた結果として適切なのは？",
    codeSnippet: nil,
    choices: ["score >= 60 の結果（True か False）", "score の値そのもの（例：72）", "\"合格\" という文字列"],
    correctAnswer: "score >= 60 の結果（True か False）",
    explanation: "正解は score >= 60 の結果（True か False） だよ！「超えたかどうか」を調べると、結果は True か False という真偽値になるんだ。「比較の結果＝True / False」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q135 = Question(
    id: 135,
    type: .codeOutput,
    prompt: "このコードの出力は？",
    codeSnippet: "score = 75\nis_passed = score >= 60\nprint(is_passed)",
    choices: ["True", "False", "75"],
    correctAnswer: "True",
    explanation: "正解は True だよ！75 >= 60 は正しいので、is_passed には True が入って表示されるんだ。「比較式の結果は True か False」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q136 = Question(
    id: 136,
    type: .fillInBlank,
    prompt: "年齢が20歳以上かどうかを\n調べたい。空欄に入るのは？",
    codeSnippet: "age = 17\nis_adult = age _____ 20\nprint(is_adult)",
    choices: [">=", "=>", "=="],
    correctAnswer: ">=",
    explanation: "正解は >= だよ！「以上」を表す比較演算子は >= で、左が右以上のとき True になるんだ。「以上＝>=」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q137 = Question(
    id: 137,
    type: .codeOutput,
    prompt: "このコードを実行すると\n何が表示される？",
    codeSnippet: "user_name = \"太郎\"\nis_taro = user_name == \"太郎\"\nprint(is_taro)",
    choices: ["True", "False", "太郎"],
    correctAnswer: "True",
    explanation: "正解は True だよ！user_name の中身 \"太郎\" と \"太郎\" が一致するので、== の結果は True になるんだ。「文字列同士も == で比較できる」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q138 = Question(
    id: 138,
    type: .multipleChoice,
    prompt: "数値を文字列に変換するときに\n使う関数は？",
    codeSnippet: nil,
    choices: ["str()", "int()", "bool()"],
    correctAnswer: "str()",
    explanation: "正解は str() だよ！数値を文字列に変換して文章とつなげるときに使ったね。「数値→文字列＝str()」と覚えておこう！（前のレッスン「文字列型を理解しよう」の復習だよ）",
    xpReward: 10,
    gemReward: 1
)

private let q139 = Question(
    id: 139,
    type: .codeOutput,
    prompt: "ログイン画面で、\n入力されたパスワードが\n一定の長さ以上かを\n確認したい。出力はどれ？",
    codeSnippet: "password = \"abc12345\"\nis_long_enough = len(password) >= 8\nprint(is_long_enough)",
    choices: ["True", "False", "8"],
    correctAnswer: "True",
    explanation: "正解は True だよ！len(password) は 8 になり、8 >= 8 は正しいので is_long_enough は True になるんだ。「条件を満たすか確認＝比較してbool値を作る」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)


// ─────────────────────────────────────────────────────────
// MARK: - Lesson 14 · 型変換を使おう
// ─────────────────────────────────────────────────────────

private let lesson14 = Lesson(
    id: 14,
    title: "型変換を使おう",
    shortLabel: "型変換",
    subtitle: "int / str / float",
    category: "変数と型",
    order: 14,
    questions: [q140, q141, q142, q143, q144, q145, q146, q147, q148, q149],
    requiredXP: 700
)

private let q140 = Question(
    id: 140,
    type: .multipleChoice,
    prompt: "文字列を整数に変換する\n関数は？",
    codeSnippet: nil,
    choices: ["int()", "str()", "bool()"],
    correctAnswer: "int()",
    explanation: "正解は int() だよ！int(\"100\") のように書くと、文字列の \"100\" を整数の 100 に変換できるんだ。「文字列→整数＝int()」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q141 = Question(
    id: 141,
    type: .multipleChoice,
    prompt: "数値を文字列に変換する\n関数は？",
    codeSnippet: nil,
    choices: ["str()", "int()", "float()"],
    correctAnswer: "str()",
    explanation: "正解は str() だよ！str(100) のように書くと、整数の 100 を文字列の \"100\" に変換できるんだ。「数値→文字列＝str()」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q142 = Question(
    id: 142,
    type: .fillInBlank,
    prompt: "文字列を小数に変換する\n関数は？",
    codeSnippet: "price_text = \"19.8\"\nprice = _____(price_text)\nprint(price)",
    choices: ["float", "int", "str"],
    correctAnswer: "float",
    explanation: "正解は float だよ！float(\"19.8\") のように書くと、小数を含む文字列を float 型の数値に変換できるんだ。「文字列→小数＝float()」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q143 = Question(
    id: 143,
    type: .multipleChoice,
    prompt: "フォームに入力された\n年齢の文字列 \"20\" を\n計算に使うために必要な処理は？",
    codeSnippet: nil,
    choices: ["int(\"20\") で整数に変換する", "str(\"20\") で文字列のままにする", "bool(\"20\") で真偽値に変換する"],
    correctAnswer: "int(\"20\") で整数に変換する",
    explanation: "正解は int(\"20\") で整数に変換する だよ！入力フォームの値はまず文字列として届くので、計算に使うには int() で数値に変換する必要があるんだ。「入力値はまず文字列、計算前にint()で変換」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q144 = Question(
    id: 144,
    type: .multipleChoice,
    prompt: "計算した合計金額 total を\n画面に表示する文章に\n組み込むために必要な処理は？",
    codeSnippet: nil,
    choices: ["str(total) で文字列に変換する", "int(total) で整数のままにする", "float(total) で小数に変換する"],
    correctAnswer: "str(total) で文字列に変換する",
    explanation: "正解は str(total) で文字列に変換する だよ！数値と文字列は + で直接つなげられないので、表示する前に str() で文字列に変換するんだ。「数値を文章に組み込む前に＝str()で変換」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q145 = Question(
    id: 145,
    type: .codeOutput,
    prompt: "このコードの出力は？",
    codeSnippet: "age_text = \"16\"\nage = int(age_text)\nprint(age + 4)",
    choices: ["20", "164", "エラーになる"],
    correctAnswer: "20",
    explanation: "正解は 20 だよ！int(\"16\") で文字列が整数の 16 に変換され、16 + 4 は 20 になるんだ。「文字列の数値はint()で変換してから計算する」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q146 = Question(
    id: 146,
    type: .fillInBlank,
    prompt: "計算結果を文字列に変換して\n表示したい。空欄に入るのは？",
    codeSnippet: "total = 1500\nprint(\"合計は\" + _____(total) + \"円\")",
    choices: ["str", "int", "float"],
    correctAnswer: "str",
    explanation: "正解は str だよ！数値の total を文字列に変換してから + でつなげると、エラーにならずに表示できるんだ。「文章に数値を混ぜる前に＝str()」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q147 = Question(
    id: 147,
    type: .codeOutput,
    prompt: "このコードを実行すると\n何が表示される？",
    codeSnippet: "score_text = \"88\"\nscore = int(score_text)\nis_passed = score >= 60\nprint(is_passed)",
    choices: ["True", "False", "88"],
    correctAnswer: "True",
    explanation: "正解は True だよ！\"88\" を int() で 88 に変換し、88 >= 60 は正しいので is_passed は True になるんだ。「文字列→数値→比較」という流れを思い出そう。「比較の結果＝True / False」と覚えておこう！（前のレッスン「真偽値を理解しよう」の復習だよ）",
    xpReward: 10,
    gemReward: 1
)

private let q148 = Question(
    id: 148,
    type: .multipleChoice,
    prompt: "値の型を調べるときに\n使う関数は？",
    codeSnippet: nil,
    choices: ["type()", "kind()", "class()"],
    correctAnswer: "type()",
    explanation: "正解は type() だよ！type(値) でその値が int なのか str なのかを確認できたね。「型を調べる＝type()」と覚えておこう！（前のレッスン「数値型を理解しよう」の復習だよ）",
    xpReward: 10,
    gemReward: 1
)

private let q149 = Question(
    id: 149,
    type: .codeOutput,
    prompt: "ショッピングアプリで、\n入力された個数の文字列から\n合計金額を求めたい。\n出力はどれ？",
    codeSnippet: "item_price = 250\nquantity_text = \"3\"\nquantity = int(quantity_text)\ntotal = item_price * quantity\nprint(\"合計：\" + str(total) + \"円\")",
    choices: ["合計：750円", "合計：item_price * quantity円", "エラーになる"],
    correctAnswer: "合計：750円",
    explanation: "正解は 合計：750円 だよ！\"3\" を int() で整数に変換してから単価とかけ算し、最後に str() で文字列に変換して表示しているんだ。「入力は変換して計算、結果は変換して表示」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)


// ─────────────────────────────────────────────────────────
// MARK: - Lesson 15 · Noneを理解しよう
// ─────────────────────────────────────────────────────────

private let lesson15 = Lesson(
    id: 15,
    title: "Noneを理解しよう",
    shortLabel: "None",
    subtitle: "値がない状態",
    category: "変数と型",
    order: 15,
    questions: [q150, q151, q152, q153, q154, q155, q156, q157, q158, q159],
    requiredXP: 750
)

private let q150 = Question(
    id: 150,
    type: .multipleChoice,
    prompt: "「値が何もない」ことを\n表すPythonの値は？",
    codeSnippet: nil,
    choices: ["None", "0", "\"\"（空文字）"],
    correctAnswer: "None",
    explanation: "正解は None だよ！None は「値が存在しない」「まだ何も入っていない」ことを表す特別な値なんだ。0 や空文字とは違うので注意しよう。「値がない＝None」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q151 = Question(
    id: 151,
    type: .multipleChoice,
    prompt: "None の型は？",
    codeSnippet: nil,
    choices: ["NoneType", "int", "bool"],
    correctAnswer: "NoneType",
    explanation: "正解は NoneType だよ！type(None) を調べると <class 'NoneType'> と表示されるんだ。None専用の型が用意されているんだね。「Noneの型＝NoneType」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q152 = Question(
    id: 152,
    type: .fillInBlank,
    prompt: "値が None かどうかを\n調べるときによく使う書き方は？",
    codeSnippet: "if result _____ None:\n    print(\"見つからなかった\")",
    choices: ["is", "==", "="],
    correctAnswer: "is",
    explanation: "正解は is だよ！None かどうかを調べるときは == ではなく is を使うのがPythonの作法なんだ。「Noneとの比較＝is」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q153 = Question(
    id: 153,
    type: .multipleChoice,
    prompt: "ユーザーがまだ\nニックネームを設定していない\n状態を表す初期値として\n適切なのは？",
    codeSnippet: nil,
    choices: ["nickname = None", "nickname = 0", "nickname = \"None\"（文字列）"],
    correctAnswer: "nickname = None",
    explanation: "正解は nickname = None だよ！「まだ何も設定されていない」状態を表すには、文字列の \"None\" ではなく値そのものの None を使うんだ。「未設定の初期値＝None」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q154 = Question(
    id: 154,
    type: .multipleChoice,
    prompt: "検索した商品が\n見つからなかったときの\n戻り値として適切なのは？",
    codeSnippet: nil,
    choices: ["None", "\"見つかりません\"という商品データ", "0という名前の商品"],
    correctAnswer: "None",
    explanation: "正解は None だよ！「該当するデータが存在しない」ことを表すには None を返すのが自然なんだ。呼び出し側は is None で判定できるんだったね。「見つからない＝None を返す」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q155 = Question(
    id: 155,
    type: .codeOutput,
    prompt: "このコードの出力は？",
    codeSnippet: "def find_user(user_id):\n    if user_id == 1:\n        return \"太郎\"\n    return None\n\nresult = find_user(99)\nprint(result)",
    choices: ["None", "99", "太郎"],
    correctAnswer: "None",
    explanation: "正解は None だよ！user_id が 1 ではないので if の中は実行されず、最後の return None が実行されて None が返るんだ。「見つからなかったとき＝Noneを返す」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q156 = Question(
    id: 156,
    type: .fillInBlank,
    prompt: "戻り値が None かどうかを\n調べたい。空欄に入るのは？",
    codeSnippet: "result = find_user(99)\nif result _____ None:\n    print(\"ユーザーが見つかりません\")",
    choices: ["is", "==", "in"],
    correctAnswer: "is",
    explanation: "正解は is だよ！None との比較は is None と書くのがPythonの基本ルールなんだ。「Noneかどうかの判定＝is None」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q157 = Question(
    id: 157,
    type: .codeOutput,
    prompt: "このコードを実行すると\n何が表示される？",
    codeSnippet: "def get_discount(score):\n    if score >= 80:\n        return 0.1\n\nresult = get_discount(50)\nprint(result)",
    choices: ["None", "0.1", "50"],
    correctAnswer: "None",
    explanation: "正解は None だよ！score が 80 未満なので if の中は実行されず、関数は何も return しないまま終わるんだ。何も return しない関数は自動的に None を返すんだったね。「戻り値の指定がない＝None が返る」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q158 = Question(
    id: 158,
    type: .multipleChoice,
    prompt: "0で割ったときに発生する\nエラーの名前は？",
    codeSnippet: nil,
    choices: ["ZeroDivisionError", "NoneError", "TypeError"],
    correctAnswer: "ZeroDivisionError",
    explanation: "正解は ZeroDivisionError だよ！数を 0 で割ろうとすると発生するエラーだったね。「ゼロ除算＝ZeroDivisionError」と覚えておこう！（コース0「エラーを読もう」の復習だよ）",
    xpReward: 10,
    gemReward: 1
)

private let q159 = Question(
    id: 159,
    type: .codeOutput,
    prompt: "ユーザー検索機能で、\n見つからなかったときに\n安全にメッセージを出したい。\n出力はどれ？",
    codeSnippet: "def find_user(name):\n    if name == \"花子\":\n        return \"花子さんが見つかりました\"\n    return None\n\nresult = find_user(\"次郎\")\nif result is None:\n    print(\"ユーザーが見つかりません\")\nelse:\n    print(result)",
    choices: ["ユーザーが見つかりません", "花子さんが見つかりました", "None"],
    correctAnswer: "ユーザーが見つかりません",
    explanation: "正解は ユーザーが見つかりません だよ！\"次郎\" は見つからないので関数は None を返し、is None の判定で分かりやすいメッセージを表示しているんだ。「見つからない可能性に備える＝is Noneでチェック」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)


// ─────────────────────────────────────────────────────────
// MARK: - Lesson 16 · リストと型を組み合わせよう
// ─────────────────────────────────────────────────────────

private let lesson16 = Lesson(
    id: 16,
    title: "リストと型を組み合わせよう",
    shortLabel: "リストと型",
    subtitle: "list",
    category: "変数と型",
    order: 16,
    questions: [q160, q161, q162, q163, q164, q165, q166, q167, q168, q169],
    requiredXP: 800
)

private let q160 = Question(
    id: 160,
    type: .multipleChoice,
    prompt: "リストを作るときに\n使うかっこは？",
    codeSnippet: nil,
    choices: ["[ ]（角かっこ）", "( )（丸かっこ）", "{ }（波かっこ）"],
    correctAnswer: "[ ]（角かっこ）",
    explanation: "正解は [ ]（角かっこ） だよ！scores = [80, 90, 70] のように角かっこで値を囲むとリストが作れるんだ。「リスト＝角かっこ」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q161 = Question(
    id: 161,
    type: .multipleChoice,
    prompt: "リストの中には\nどんな値を入れられる？",
    codeSnippet: nil,
    choices: ["数値や文字列など、いろいろな型の値", "数値だけ", "文字列だけ"],
    correctAnswer: "数値や文字列など、いろいろな型の値",
    explanation: "正解は 数値や文字列など、いろいろな型の値 だよ！[1, \"二\", 3.0] のように、リストには異なる型の値を混ぜて入れることもできるんだ。「リスト＝いろいろな型を入れられる入れ物」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q162 = Question(
    id: 162,
    type: .fillInBlank,
    prompt: "リストの最初の要素を\n取り出したい。空欄に入るのは？",
    codeSnippet: "item_list = [\"りんご\", \"バナナ\", \"みかん\"]\nprint(item_list[_____])",
    choices: ["0", "1", "first"],
    correctAnswer: "0",
    explanation: "正解は 0 だよ！Pythonのリストは 0 番目から数え始めるので、最初の要素は item_list[0] になるんだ。「最初の要素＝[0]」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q163 = Question(
    id: 163,
    type: .multipleChoice,
    prompt: "買い物リストの商品名を\n保存する変数名として\n適切なのは？",
    codeSnippet: nil,
    choices: ["item_list（例：item_list = [\"パン\", \"牛乳\"]）", "x（例：x = [\"パン\", \"牛乳\"]）", "data（例：data = [\"パン\", \"牛乳\"]）"],
    correctAnswer: "item_list（例：item_list = [\"パン\", \"牛乳\"]）",
    explanation: "正解は item_list（例：item_list = [\"パン\", \"牛乳\"]） だよ！「商品名のリスト」だと一目でわかる名前にすると、コードがぐっと読みやすくなるんだ。「中身がわかるリスト名＝item_list」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q164 = Question(
    id: 164,
    type: .multipleChoice,
    prompt: "テストの点数をまとめて\n保存する変数として適切なのは？",
    codeSnippet: nil,
    choices: ["score_list = [80, 95, 70]", "score_list = \"80, 95, 70\"", "score_list = 80"],
    correctAnswer: "score_list = [80, 95, 70]",
    explanation: "正解は score_list = [80, 95, 70] だよ！複数の点数をまとめて扱いたいときはリストにすると、合計や平均の計算がしやすくなるんだ。「複数のまとまった値＝リスト」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q165 = Question(
    id: 165,
    type: .codeOutput,
    prompt: "このコードの出力は？",
    codeSnippet: "item_list = [\"ノート\", \"消しゴム\", \"鉛筆\"]\nprint(len(item_list))\nprint(type(item_list))",
    choices: ["3\n<class 'list'>", "3\n<class 'str'>", "list\n3"],
    correctAnswer: "3\n<class 'list'>",
    explanation: "正解は 3 / <class 'list'> だよ！len() で要素数の 3 が、type() で型を表す <class 'list'> が表示されるんだ。「リストの個数＝len()、型の確認＝type()」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q166 = Question(
    id: 166,
    type: .fillInBlank,
    prompt: "リストに新しい商品名を\n追加したい。空欄に入るのは？",
    codeSnippet: "item_list = [\"ノート\", \"消しゴム\"]\nitem_list._____(\"鉛筆\")\nprint(item_list)",
    choices: ["append", "add", "insert"],
    correctAnswer: "append",
    explanation: "正解は append だよ！リストの末尾に値を追加するメソッドは append() なんだ。「末尾に追加＝append()」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q167 = Question(
    id: 167,
    type: .codeOutput,
    prompt: "このコードを実行すると\n何が表示される？",
    codeSnippet: "score_list = [70, 85, 90]\nprint(score_list[1])\nprint(type(score_list[1]))",
    choices: ["85\n<class 'int'>", "70\n<class 'list'>", "[70, 85, 90]\n<class 'int'>"],
    correctAnswer: "85\n<class 'int'>",
    explanation: "正解は 85 / <class 'int'> だよ！score_list[1] は2番目の要素である 85 を取り出し、それは int 型なんだ。「リストの中の値も、それぞれ自分の型を持っている」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q168 = Question(
    id: 168,
    type: .multipleChoice,
    prompt: "「値が何もない」ことを\n表すPythonの値は？",
    codeSnippet: nil,
    choices: ["None", "0", "\"\"（空文字）"],
    correctAnswer: "None",
    explanation: "正解は None だよ！「まだ値がない」状態を表す特別な値だったね。「値がない＝None」と覚えておこう！（前のレッスン「Noneを理解しよう」の復習だよ）",
    xpReward: 10,
    gemReward: 1
)

private let q169 = Question(
    id: 169,
    type: .codeOutput,
    prompt: "レシートアプリで、\n商品の値段リストから\n合計金額を求めたい。\n出力はどれ？",
    codeSnippet: "price_list = [120, 350, 980]\ntotal = price_list[0] + price_list[1] + price_list[2]\nprint(\"合計：\" + str(total) + \"円\")",
    choices: ["合計：1450円", "合計：120350980円", "エラーになる"],
    correctAnswer: "合計：1450円",
    explanation: "正解は 合計：1450円 だよ！リストの各要素を取り出して足し算し、120 + 350 + 980 で 1450 になるんだ。「複数の値段をまとめる＝リストで合計を計算」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)


// ─────────────────────────────────────────────────────────
// MARK: - Lesson 17 · 辞書と型を組み合わせよう
// ─────────────────────────────────────────────────────────

private let lesson17 = Lesson(
    id: 17,
    title: "辞書と型を組み合わせよう",
    shortLabel: "辞書と型",
    subtitle: "dict",
    category: "変数と型",
    order: 17,
    questions: [q170, q171, q172, q173, q174, q175, q176, q177, q178, q179],
    requiredXP: 850
)

private let q170 = Question(
    id: 170,
    type: .multipleChoice,
    prompt: "辞書を作るときに\n使うかっこは？",
    codeSnippet: nil,
    choices: ["{ }（波かっこ）", "[ ]（角かっこ）", "( )（丸かっこ）"],
    correctAnswer: "{ }（波かっこ）",
    explanation: "正解は { }（波かっこ） だよ！user = {\"name\": \"太郎\", \"age\": 16} のように波かっこでキーと値の組を囲むと辞書が作れるんだ。「辞書＝波かっこ」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q171 = Question(
    id: 171,
    type: .multipleChoice,
    prompt: "辞書はどんな構造で\nデータを持っている？",
    codeSnippet: nil,
    choices: ["キーと値のペア", "番号と値のペア（リストと同じ）", "値だけの並び"],
    correctAnswer: "キーと値のペア",
    explanation: "正解は キーと値のペア だよ！{\"name\": \"太郎\"} の \"name\" がキー、\"太郎\" が値で、キーを使って値を取り出すんだ。「辞書＝キーと値のペア」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q172 = Question(
    id: 172,
    type: .fillInBlank,
    prompt: "辞書でキーと値を\n区切るときに使う記号は？",
    codeSnippet: "user = {\"name\"_____ \"花子\", \"age\": 20}",
    choices: [":", "=", ","],
    correctAnswer: ":",
    explanation: "正解は : だよ！{\"name\": \"花子\"} のように、キーと値の間はコロンで区切るんだ。「キーと値の区切り＝:」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q173 = Question(
    id: 173,
    type: .multipleChoice,
    prompt: "ユーザー情報をまとめて\n保存する変数として適切なのは？",
    codeSnippet: nil,
    choices: ["user = {\"name\": \"太郎\", \"age\": 16}", "user = [\"太郎\", 16]", "user = \"太郎,16\""],
    correctAnswer: "user = {\"name\": \"太郎\", \"age\": 16}",
    explanation: "正解は user = {\"name\": \"太郎\", \"age\": 16} だよ！「名前は太郎、年齢は16」のように項目名と値の組をまとめるなら、辞書で持つと何が何の値かが一目でわかるんだ。「項目名つきのデータ＝辞書」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q174 = Question(
    id: 174,
    type: .multipleChoice,
    prompt: "辞書 user の中の\n年齢（数値）を取り出す\n書き方として正しいのは？",
    codeSnippet: nil,
    choices: ["user[\"age\"]", "user.age", "user(age)"],
    correctAnswer: "user[\"age\"]",
    explanation: "正解は user[\"age\"] だよ！辞書の値はキーを角かっこで指定して取り出すんだ。user[\"age\"] は int 型の 16 を返すよ。「辞書から値を取り出す＝[キー]」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q175 = Question(
    id: 175,
    type: .codeOutput,
    prompt: "このコードの出力は？",
    codeSnippet: "user = {\"name\": \"花子\", \"age\": 20}\nprint(user[\"name\"])\nprint(type(user[\"age\"]))",
    choices: ["花子\n<class 'int'>", "name\n<class 'str'>", "花子\n<class 'str'>"],
    correctAnswer: "花子\n<class 'int'>",
    explanation: "正解は 花子 / <class 'int'> だよ！user[\"name\"] は \"花子\"、user[\"age\"] は int 型の 20 になるので type() の結果は <class 'int'> なんだ。「辞書の値も、それぞれ自分の型を持っている」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q176 = Question(
    id: 176,
    type: .fillInBlank,
    prompt: "存在しないキーを指定すると\n発生するエラーの名前は？",
    codeSnippet: "user = {\"name\": \"太郎\"}\nprint(user[\"age\"])\n# _____: 'age'",
    choices: ["KeyError", "NameError", "IndexError"],
    correctAnswer: "KeyError",
    explanation: "正解は KeyError だよ！辞書に存在しないキーを指定すると KeyError が発生するんだ。「存在しないキー＝KeyError」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q177 = Question(
    id: 177,
    type: .codeOutput,
    prompt: "このコードを実行すると\n何が表示される？",
    codeSnippet: "user = {\"name\": \"陽子\", \"score\": 92, \"is_member\": True}\nprint(user[\"score\"], user[\"is_member\"])",
    choices: ["92 True", "score is_member", "92 is_member"],
    correctAnswer: "92 True",
    explanation: "正解は 92 True だよ！辞書には数値や真偽値などいろいろな型の値を持たせることができ、それぞれの中身がそのまま表示されるんだ。「辞書の値はint・str・boolなど何でもよい」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q178 = Question(
    id: 178,
    type: .multipleChoice,
    prompt: "リストの末尾に\n値を追加するメソッドは？",
    codeSnippet: nil,
    choices: ["append()", "add()", "push()"],
    correctAnswer: "append()",
    explanation: "正解は append() だよ！item_list.append(\"鉛筆\") のようにリストの最後に値を加えるときに使うんだったね。「末尾に追加＝append()」と覚えておこう！（前のレッスン「リストと型を組み合わせよう」の復習だよ）",
    xpReward: 10,
    gemReward: 1
)

private let q179 = Question(
    id: 179,
    type: .codeOutput,
    prompt: "会員アプリで、\nユーザー情報からプロフィール\nメッセージを作りたい。\n出力はどれ？",
    codeSnippet: "user = {\"name\": \"美咲\", \"age\": 19, \"is_member\": True}\nmessage = user[\"name\"] + \"さん（\" + str(user[\"age\"]) + \"歳・会員：\" + str(user[\"is_member\"]) + \"）\"\nprint(message)",
    choices: ["美咲さん（19歳・会員：True）", "nameさん（age歳・会員：is_member）", "エラーになる"],
    correctAnswer: "美咲さん（19歳・会員：True）",
    explanation: "正解は 美咲さん（19歳・会員：True） だよ！辞書から取り出した str・int・bool の値をそれぞれ str() で文字列に変換し、+ でつなげてメッセージを組み立てているんだ。「複数の型を組み合わせる＝それぞれstr()で変換してから結合」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)


// ─────────────────────────────────────────────────────────
// MARK: - Lesson 18 · 型エラーを読もう
// ─────────────────────────────────────────────────────────

private let lesson18 = Lesson(
    id: 18,
    title: "型エラーを読もう",
    shortLabel: "型エラー",
    subtitle: "TypeError",
    category: "変数と型",
    order: 18,
    questions: [q180, q181, q182, q183, q184, q185, q186, q187, q188, q189],
    requiredXP: 900
)

private let q180 = Question(
    id: 180,
    type: .multipleChoice,
    prompt: "型が合わない操作をしたときに\n発生するエラーの名前は？",
    codeSnippet: nil,
    choices: ["TypeError", "ValueError", "KeyError"],
    correctAnswer: "TypeError",
    explanation: "正解は TypeError だよ！文字列と数値を + でつなごうとするなど、型が合わない操作をすると TypeError が発生するんだ。「型の不一致＝TypeError」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q181 = Question(
    id: 181,
    type: .multipleChoice,
    prompt: "次のうち TypeError が\n発生するのはどれ？",
    codeSnippet: nil,
    choices: ["\"合計：\" + 1500", "\"合計：\" + str(1500)", "\"合計：\" + \"1500円\""],
    correctAnswer: "\"合計：\" + 1500",
    explanation: "正解は \"合計：\" + 1500 だよ！文字列と整数を + で直接つなげることはできず、TypeError が発生するんだ。str(1500) のように変換すればつなげられるんだったね。「str ＋ int を直接 + ＝ TypeError」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q182 = Question(
    id: 182,
    type: .fillInBlank,
    prompt: "次のエラーメッセージの\n空欄に入るエラー名は？",
    codeSnippet: "print(\"年齢：\" + 16)\n# _____: can only concatenate str (not \"int\") to str",
    choices: ["TypeError", "NameError", "KeyError"],
    correctAnswer: "TypeError",
    explanation: "正解は TypeError だよ！\"can only concatenate str ... to str\" は「strにはstrしかつなげられない」という意味の TypeError のメッセージなんだ。「型の説明が出てくるエラー＝TypeError」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q183 = Question(
    id: 183,
    type: .multipleChoice,
    prompt: "TypeErrorを避けて\n価格を文章に組み込むには\nどうすればよい？",
    codeSnippet: nil,
    choices: ["str(price) で文字列に変換してからつなげる", "price をそのまま + でつなげる", "price の前にスペースを入れる"],
    correctAnswer: "str(price) で文字列に変換してからつなげる",
    explanation: "正解は str(price) で文字列に変換してからつなげる だよ！数値をそのまま文字列とつなげようとすると TypeError になるので、str() で型をそろえる必要があるんだ。「型エラー対策＝str()で型をそろえてから操作する」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q184 = Question(
    id: 184,
    type: .multipleChoice,
    prompt: "次のうち、原因が\n型の不一致（TypeError）と\n考えられるのはどれ？",
    codeSnippet: nil,
    choices: ["\"得点は\" + score を実行したらエラーになった", "存在しないキーを指定したらエラーになった", "リストの範囲外を指定したらエラーになった"],
    correctAnswer: "\"得点は\" + score を実行したらエラーになった",
    explanation: "正解は \"得点は\" + score を実行したらエラーになった だよ！文字列と数値を + でつなごうとして起きるのは TypeError なんだ。存在しないキーは KeyError、範囲外は IndexError だったね。「文字列＋数値のエラー＝TypeError」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q185 = Question(
    id: 185,
    type: .codeOutput,
    prompt: "このコードの出力は？",
    codeSnippet: "try:\n    message = \"残り\" + 5 + \"個\"\nexcept TypeError:\n    message = \"型が違うので表示できません\"\nprint(message)",
    choices: ["型が違うので表示できません", "残り5個", "エラーで停止する"],
    correctAnswer: "型が違うので表示できません",
    explanation: "正解は 型が違うので表示できません だよ！\"残り\" + 5 で文字列と整数を直接つなごうとして TypeError が発生し、except のメッセージが表示されるんだ。「型エラーに備える＝try/exceptで捕まえる」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q186 = Question(
    id: 186,
    type: .fillInBlank,
    prompt: "型を変換してエラーを防ぎたい。\n空欄に入るのは？",
    codeSnippet: "stock = 5\nprint(\"残り\" + _____(stock) + \"個\")",
    choices: ["str", "int", "bool"],
    correctAnswer: "str",
    explanation: "正解は str だよ！数値の stock を str() で文字列に変換してからつなげれば、TypeError を防いで正しく表示できるんだ。「数値を文章に混ぜる前に＝str()」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q187 = Question(
    id: 187,
    type: .codeOutput,
    prompt: "このコードを実行すると\n何が表示される？",
    codeSnippet: "user_age = \"20\"\ntry:\n    result = user_age + 1\nexcept TypeError:\n    result = int(user_age) + 1\nprint(result)",
    choices: ["21", "201", "エラーで停止する"],
    correctAnswer: "21",
    explanation: "正解は 21 だよ！\"20\" + 1 は str と int の演算で TypeError になり、except 内で int(user_age) + 1 が実行されて 21 になるんだ。「型エラーに備える＝int()で変換してから計算」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q188 = Question(
    id: 188,
    type: .multipleChoice,
    prompt: "存在しないキーを\n指定したときに発生する\nエラーの名前は？",
    codeSnippet: nil,
    choices: ["KeyError", "TypeError", "IndexError"],
    correctAnswer: "KeyError",
    explanation: "正解は KeyError だよ！辞書にないキーを指定すると発生するエラーだったね。「存在しないキー＝KeyError」と覚えておこう！（前のレッスン「辞書と型を組み合わせよう」の復習だよ）",
    xpReward: 10,
    gemReward: 1
)

private let q189 = Question(
    id: 189,
    type: .codeOutput,
    prompt: "注文フォームで、\n入力された個数と単価から\n合計を安全に計算したい。\n出力はどれ？",
    codeSnippet: "item_price = 200\nquantity_text = \"3\"\ntry:\n    total = item_price + quantity_text\nexcept TypeError:\n    total = item_price * int(quantity_text)\nprint(\"合計：\" + str(total) + \"円\")",
    choices: ["合計：600円", "合計：2003円", "エラーで停止する"],
    correctAnswer: "合計：600円",
    explanation: "正解は 合計：600円 だよ！item_price + quantity_text は int と str の演算で TypeError になり、except 内で int に変換してかけ算することで 200 * 3 = 600 が求まるんだ。「型エラーを想定した対処＝変換してから処理を続ける」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)


// ─────────────────────────────────────────────────────────
// MARK: - Lesson 19 · 変数と型の総復習
// ─────────────────────────────────────────────────────────

private let lesson19 = Lesson(
    id: 19,
    title: "変数と型の総復習",
    shortLabel: "総復習",
    subtitle: "コース1まとめ",
    category: "変数と型",
    order: 19,
    questions: [q190, q191, q192, q193, q194, q195, q196, q197, q198, q199],
    requiredXP: 950
)

private let q190 = Question(
    id: 190,
    type: .multipleChoice,
    prompt: "ユーザーの年齢を保存する\n変数名として最も適切なのは？",
    codeSnippet: nil,
    choices: ["age", "a", "data1"],
    correctAnswer: "age",
    explanation: "正解は age だよ！コース1の最初に学んだ通り、何のデータかひと目でわかる名前をつけるのが大切なんだ。「中身がわかる名前＝age」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q191 = Question(
    id: 191,
    type: .multipleChoice,
    prompt: "小数を表す型の名前は？",
    codeSnippet: nil,
    choices: ["float", "int", "str"],
    correctAnswer: "float",
    explanation: "正解は float だよ！3.14 のような小数は float 型として扱われるんだったね。「小数＝float」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q192 = Question(
    id: 192,
    type: .fillInBlank,
    prompt: "文字列同士をつなげる\n演算子は？",
    codeSnippet: "message = \"こんにちは、\" _____ user_name\nprint(message)",
    choices: ["+", "-", "and"],
    correctAnswer: "+",
    explanation: "正解は + だよ！文字列同士は + でつなげることができるんだったね。「文字列の結合＝+」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q193 = Question(
    id: 193,
    type: .multipleChoice,
    prompt: "比較した結果として\n得られる値の型は？",
    codeSnippet: nil,
    choices: ["bool（True か False）", "int（0 か 1）", "str（\"True\" か \"False\"）"],
    correctAnswer: "bool（True か False）",
    explanation: "正解は bool（True か False） だよ！score >= 60 のような比較式の結果は、bool 型の True か False になるんだったね。「比較の結果＝bool」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q194 = Question(
    id: 194,
    type: .multipleChoice,
    prompt: "文字列を整数に変換する\n関数は？",
    codeSnippet: nil,
    choices: ["int()", "str()", "float()"],
    correctAnswer: "int()",
    explanation: "正解は int() だよ！int(\"20\") のように、文字列を整数に変換するときに使う関数だったね。「文字列→整数＝int()」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q195 = Question(
    id: 195,
    type: .codeOutput,
    prompt: "このコードの出力は？",
    codeSnippet: "result = None\nif result is None:\n    print(\"まだ値が設定されていません\")\nelse:\n    print(result)",
    choices: ["まだ値が設定されていません", "None", "エラーになる"],
    correctAnswer: "まだ値が設定されていません",
    explanation: "正解は まだ値が設定されていません だよ！result が None なので is None の条件が True になり、if の中の print が実行されるんだ。「Noneかどうかの判定＝is None」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q196 = Question(
    id: 196,
    type: .fillInBlank,
    prompt: "リストの最初の要素を\n取り出したい。空欄に入るのは？",
    codeSnippet: "score_list = [80, 95, 70]\nprint(score_list[_____])",
    choices: ["0", "1", "first"],
    correctAnswer: "0",
    explanation: "正解は 0 だよ！リストは 0 番目から数えるので、最初の要素は score_list[0] になるんだったね。「最初の要素＝[0]」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q197 = Question(
    id: 197,
    type: .codeOutput,
    prompt: "このコードを実行すると\n何が表示される？",
    codeSnippet: "user = {\"name\": \"健太\", \"age\": 14}\nmessage = user[\"name\"] + \"（\" + str(user[\"age\"]) + \"歳）\"\nprint(message)",
    choices: ["健太（14歳）", "name（age歳）", "エラーになる"],
    correctAnswer: "健太（14歳）",
    explanation: "正解は 健太（14歳） だよ！辞書から取り出した str の名前と、str() で変換した int の年齢を + でつなげてメッセージを組み立てているんだ。「辞書＋型変換＋文字列結合」を組み合わせて表示する、と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q198 = Question(
    id: 198,
    type: .multipleChoice,
    prompt: "型が合わない操作をしたときに\n発生するエラーの名前は？",
    codeSnippet: nil,
    choices: ["TypeError", "KeyError", "ZeroDivisionError"],
    correctAnswer: "TypeError",
    explanation: "正解は TypeError だよ！文字列と数値を直接 + でつなごうとするなど、型が合わない操作で発生するエラーだったね。「型の不一致＝TypeError」と覚えておこう！（前のレッスン「型エラーを読もう」の復習だよ）",
    xpReward: 10,
    gemReward: 1
)

private let q199 = Question(
    id: 199,
    type: .codeOutput,
    prompt: "プロフィール登録フォームで、\n入力値を整理して\nまとめて表示したい。\n出力はどれ？",
    codeSnippet: "user_name = \"あかり\"\nage_text = \"15\"\nage = int(age_text)\nis_teen = age < 20\nprofile = user_name + \"さん（\" + str(age) + \"歳・10代：\" + str(is_teen) + \"）\"\nprint(profile)",
    choices: ["あかりさん（15歳・10代：True）", "あかりさん（age_text歳・10代：is_teen）", "エラーになる"],
    correctAnswer: "あかりさん（15歳・10代：True）",
    explanation: "正解は あかりさん（15歳・10代：True） だよ！文字列の変換、数値への変換、比較によるbool値の生成、文字列の結合――コース1で学んだ型の扱いをすべて組み合わせて1つのメッセージを作っているんだ。「変数と型の基本＝変換して、そろえて、組み合わせる」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)
