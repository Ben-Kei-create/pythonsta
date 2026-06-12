//
//  PythonConditionals.swift
//  pythonsta
//
//  Created by 茂木史明 on 2026/06/12.
//
//  Course: 条件分岐
//  Course ID: 3
//  Lesson ID range:   30–39  (10 lessons at full scale — COMPLETE)
//  Lesson order range: 30–39 (globally unique; drives unlock sequencing)
//  Question ID range: 300–399 (100 questions at full scale — COMPLETE)
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

enum PythonConditionalsCourse {
    static let course = Course(
        id: 3,
        title: "条件分岐",
        subtitle: "ifで処理を分ける力をつけよう",
        lessons: [lesson30, lesson31, lesson32, lesson33, lesson34, lesson35, lesson36, lesson37, lesson38, lesson39]
    )
}


// ─────────────────────────────────────────────────────────
// MARK: - Lesson 30 · if文の基本を理解しよう
// ─────────────────────────────────────────────────────────

private let lesson30 = Lesson(
    id: 30,
    title: "if文の基本を理解しよう",
    shortLabel: "if文の基本",
    subtitle: "条件が成立したら実行",
    category: "条件分岐",
    order: 30,
    questions: [q300, q301, q302, q303, q304, q305, q306, q307, q308, q309],
    requiredXP: 1500
)

private let q300 = Question(
    id: 300,
    type: .multipleChoice,
    prompt: "条件が True のときだけ\n処理を実行する文は？",
    codeSnippet: nil,
    choices: ["if文", "for文", "print文"],
    correctAnswer: "if文",
    explanation: "正解は if文 だよ！if は「もし条件が True なら、ブロックの中の処理を実行する」という構文なんだ。「条件付きの実行＝if文」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q301 = Question(
    id: 301,
    type: .multipleChoice,
    prompt: "if文の条件式の後に\n必要な記号は？",
    codeSnippet: nil,
    choices: ["：（コロン）", "；（セミコロン）", "，（カンマ）"],
    correctAnswer: "：（コロン）",
    explanation: "正解は ：（コロン） だよ！if 条件式: のように、条件式の最後にはコロンが必要なんだ。コロンを忘れるとエラーになるよ。「if文の最後＝コロン」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q302 = Question(
    id: 302,
    type: .fillInBlank,
    prompt: "if文の中の処理は\n行の先頭を揃える必要がある。\n空欄に入るのは？",
    codeSnippet: "if score >= 60:\n_____print(\"合格です\")\n# 行の先頭に必要なもの",
    choices: ["インデント（半角スペース4つなど）", "コロン", "カンマ"],
    correctAnswer: "インデント（半角スペース4つなど）",
    explanation: "正解は インデント（半角スペース4つなど） だよ！if のブロックの中の行は、先頭にインデント（字下げ）が必要なんだ。インデントがそろっていないとエラーになるよ。「ブロックの中＝インデントを揃える」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q303 = Question(
    id: 303,
    type: .multipleChoice,
    prompt: "テストの点数が\n60点以上なら「合格です」と\n表示する処理として\n適切なのは？",
    codeSnippet: nil,
    choices: ["if score >= 60:\n    print(\"合格です\")", "if score >= 60\n    print(\"合格です\")", "if score >= 60:\nprint(\"合格です\")"],
    correctAnswer: "if score >= 60:\n    print(\"合格です\")",
    explanation: "正解は if score >= 60:\\n    print(\"合格です\") だよ！条件式の後にコロンを書き、次の行をインデントしてブロックにする必要があるんだ。「if 条件式: の次の行はインデント」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q304 = Question(
    id: 304,
    type: .multipleChoice,
    prompt: "在庫が0個のときだけ\n「在庫切れです」と\n表示する処理として\n適切なのは？",
    codeSnippet: nil,
    choices: ["if stock == 0:\n    print(\"在庫切れです\")", "if stock = 0:\n    print(\"在庫切れです\")", "if stock == 0\n    print(\"在庫切れです\")"],
    correctAnswer: "if stock == 0:\n    print(\"在庫切れです\")",
    explanation: "正解は if stock == 0:\\n    print(\"在庫切れです\") だよ！比較には == を使い、条件式の最後にコロンを書くのがif文の基本形なんだ。「比較は==、最後はコロン」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q305 = Question(
    id: 305,
    type: .codeOutput,
    prompt: "このコードの出力は？",
    codeSnippet: "score = 80\nif score >= 60:\n    print(\"合格です\")",
    choices: ["合格です", "何も表示されない", "エラーになる"],
    correctAnswer: "合格です",
    explanation: "正解は 合格です だよ！score は 80 で 80 >= 60 は True なので、if のブロックの中の print が実行されるんだ。「条件がTrue＝ブロックを実行」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q306 = Question(
    id: 306,
    type: .fillInBlank,
    prompt: "気温が30度以上なら\n「暑いです」と表示したい。\n空欄に入るのは？",
    codeSnippet: "temperature = 32\nif temperature >= 30_____\n    print(\"暑いです\")",
    choices: [":", ";", ","],
    correctAnswer: ":",
    explanation: "正解は : だよ！if の条件式の最後には必ずコロンが必要なんだ。これを忘れると構文エラーになるよ。「if文の最後＝コロン」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q307 = Question(
    id: 307,
    type: .codeOutput,
    prompt: "このコードを実行すると\n何が表示される？",
    codeSnippet: "stock = 0\nif stock == 0:\n    print(\"在庫切れです\")\nprint(\"確認しました\")",
    choices: ["在庫切れです\n確認しました", "確認しました", "在庫切れです"],
    correctAnswer: "在庫切れです\n確認しました",
    explanation: "正解は 在庫切れです / 確認しました だよ！stock は 0 なので if の条件が True になり「在庫切れです」が表示され、その後インデントのない print(\"確認しました\") はifの外なので常に実行されるんだ。「インデントのある行だけがifの中」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q308 = Question(
    id: 308,
    type: .multipleChoice,
    prompt: "0で割ったときに発生する\nエラーの名前は？",
    codeSnippet: nil,
    choices: ["ZeroDivisionError", "TypeError", "IndexError"],
    correctAnswer: "ZeroDivisionError",
    explanation: "正解は ZeroDivisionError だよ！数を0で割ろうとすると発生するエラーだったね。「ゼロ除算＝ZeroDivisionError」と覚えておこう！（コース2「演算子の総復習」の復習だよ）",
    xpReward: 10,
    gemReward: 1
)

private let q309 = Question(
    id: 309,
    type: .codeOutput,
    prompt: "ログイン画面で、\nパスワードの文字数が\n8文字以上なら\n「パスワードは有効です」と\n表示したい。出力はどれ？",
    codeSnippet: "password = \"abcdefgh\"\nlength = len(password)\nif length >= 8:\n    print(\"パスワードは有効です\")",
    choices: ["パスワードは有効です", "何も表示されない", "8"],
    correctAnswer: "パスワードは有効です",
    explanation: "正解は パスワードは有効です だよ！password は8文字なので len(password) は 8 になり、8 >= 8 は True なので if のブロックが実行されるんだ。「文字数のチェック＝len()とifを組み合わせる」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)


// ─────────────────────────────────────────────────────────
// MARK: - Lesson 31 · elseを使おう
// ─────────────────────────────────────────────────────────

private let lesson31 = Lesson(
    id: 31,
    title: "elseを使おう",
    shortLabel: "else",
    subtitle: "条件が成立しないとき",
    category: "条件分岐",
    order: 31,
    questions: [q310, q311, q312, q313, q314, q315, q316, q317, q318, q319],
    requiredXP: 1550
)

private let q310 = Question(
    id: 310,
    type: .multipleChoice,
    prompt: "if の条件が False のときに\n実行されるブロックを\n指定するキーワードは？",
    codeSnippet: nil,
    choices: ["else", "elif", "and"],
    correctAnswer: "else",
    explanation: "正解は else だよ！else は「if の条件が False のときに実行する処理」をまとめるためのキーワードなんだ。「条件が成立しない場合＝else」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q311 = Question(
    id: 311,
    type: .multipleChoice,
    prompt: "else の後に\n必要な記号は？",
    codeSnippet: nil,
    choices: ["：（コロン）", "（）（丸かっこ）", "；（セミコロン）"],
    correctAnswer: "：（コロン）",
    explanation: "正解は ：（コロン） だよ！else: のように、else の後にもコロンが必要なんだ。else は条件式を書かず、そのままコロンを書くのがポイントだよ。「elseの後＝すぐにコロン」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q312 = Question(
    id: 312,
    type: .fillInBlank,
    prompt: "点数が60点以上なら\n「合格です」、\nそうでなければ\n「不合格です」と\n表示したい。空欄に入るのは？",
    codeSnippet: "score = 40\nif score >= 60:\n    print(\"合格です\")\n_____:\n    print(\"不合格です\")",
    choices: ["else", "elif", "and"],
    correctAnswer: "else",
    explanation: "正解は else だよ！if の条件が False だったときに実行する処理を else: の下にまとめて書くんだ。「それ以外の場合＝else」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q313 = Question(
    id: 313,
    type: .multipleChoice,
    prompt: "在庫が1個以上あれば\n「購入できます」、\nなければ「売り切れです」と\n表示する処理として\n適切なのは？",
    codeSnippet: nil,
    choices: ["if stock >= 1:\n    print(\"購入できます\")\nelse:\n    print(\"売り切れです\")", "if stock >= 1:\n    print(\"購入できます\")\nif stock < 1:\n    print(\"売り切れです\")", "if stock >= 1:\n    print(\"購入できます\")\nelse\n    print(\"売り切れです\")"],
    correctAnswer: "if stock >= 1:\n    print(\"購入できます\")\nelse:\n    print(\"売り切れです\")",
    explanation: "正解は if stock >= 1: ... else: ... だよ！「条件が成立しない場合」をまとめて書けるので else を使うのが自然なんだ。「if と else はセットで使う」と覚えておこう！（2番目の選択肢でも動作は同じだが、else の方が読みやすく意図が明確になるよ）",
    xpReward: 10,
    gemReward: 1
)

private let q314 = Question(
    id: 314,
    type: .multipleChoice,
    prompt: "ログイン処理で、\nパスワードが一致したら\n「ログイン成功」、\n一致しなければ\n「ログイン失敗」と\n表示する処理として\n適切なのは？",
    codeSnippet: nil,
    choices: ["if password == correct_password:\n    print(\"ログイン成功\")\nelse:\n    print(\"ログイン失敗\")", "if password = correct_password:\n    print(\"ログイン成功\")\nelse:\n    print(\"ログイン失敗\")", "if password == correct_password:\n    print(\"ログイン成功\")\nelif:\n    print(\"ログイン失敗\")"],
    correctAnswer: "if password == correct_password:\n    print(\"ログイン成功\")\nelse:\n    print(\"ログイン失敗\")",
    explanation: "正解は if password == correct_password: ... else: ... だよ！比較には == を使い、一致しない場合の処理は else: にまとめるのが基本なんだ。「二択の分岐＝if と else」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q315 = Question(
    id: 315,
    type: .codeOutput,
    prompt: "このコードの出力は？",
    codeSnippet: "age = 15\nif age >= 18:\n    print(\"大人です\")\nelse:\n    print(\"未成年です\")",
    choices: ["未成年です", "大人です", "何も表示されない"],
    correctAnswer: "未成年です",
    explanation: "正解は 未成年です だよ！age は 15 で 15 >= 18 は False なので、if のブロックは実行されず else のブロックが実行されるんだ。「ifがFalseならelseが実行される」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q316 = Question(
    id: 316,
    type: .fillInBlank,
    prompt: "在庫数が0なら\n「在庫切れ」、\nそうでなければ\n「在庫あり」と\n表示したい。空欄に入るのは？",
    codeSnippet: "stock = 5\nif stock == 0:\n    print(\"在庫切れ\")\n_____:\n    print(\"在庫あり\")",
    choices: ["else", "elif", "or"],
    correctAnswer: "else",
    explanation: "正解は else だよ！if の条件（在庫が0）が False のとき、つまり在庫があるときの処理を else: の下に書くんだ。「条件以外のすべての場合＝else」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q317 = Question(
    id: 317,
    type: .codeOutput,
    prompt: "このコードを実行すると\n何が表示される？",
    codeSnippet: "temperature = 18\nif temperature >= 25:\n    print(\"暑いです\")\nelse:\n    print(\"涼しいです\")",
    choices: ["涼しいです", "暑いです", "18"],
    correctAnswer: "涼しいです",
    explanation: "正解は 涼しいです だよ！temperature は 18 で 18 >= 25 は False なので、else のブロックが実行されて「涼しいです」が表示されるんだ。「if が False なら else 側が実行される」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q318 = Question(
    id: 318,
    type: .multipleChoice,
    prompt: "if user_age = 20: と書くと\nどうなる？",
    codeSnippet: nil,
    choices: ["構文エラーになる（比較には==を使う）", "正しく比較できる", "user_ageが20に書き換わる"],
    correctAnswer: "構文エラーになる（比較には==を使う）",
    explanation: "正解は 構文エラーになる（比較には==を使う） だよ！比較に = を使うと構文エラーになる、というのは演算子のよくある落とし穴だったね。「比較は==、代入は=」と覚えておこう！（コース2「演算子の落とし穴を読もう」の復習だよ）",
    xpReward: 10,
    gemReward: 1
)

private let q319 = Question(
    id: 319,
    type: .codeOutput,
    prompt: "ショップアプリで、\n会員かどうかによって\n表示するメッセージを\n切り替えたい。出力はどれ？",
    codeSnippet: "is_member = False\nif is_member:\n    print(\"会員様、いつもありがとうございます\")\nelse:\n    print(\"会員登録でお得な特典がもらえます\")",
    choices: ["会員登録でお得な特典がもらえます", "会員様、いつもありがとうございます", "False"],
    correctAnswer: "会員登録でお得な特典がもらえます",
    explanation: "正解は 会員登録でお得な特典がもらえます だよ！is_member は False なので if の条件は成立せず、else のブロックが実行されるんだ。「真偽値そのものをif条件に使うこともできる」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)


// ─────────────────────────────────────────────────────────
// MARK: - Lesson 32 · elifを使おう
// ─────────────────────────────────────────────────────────

private let lesson32 = Lesson(
    id: 32,
    title: "elifを使おう",
    shortLabel: "elif",
    subtitle: "複数の条件を順番に",
    category: "条件分岐",
    order: 32,
    questions: [q320, q321, q322, q323, q324, q325, q326, q327, q328, q329],
    requiredXP: 1600
)

private let q320 = Question(
    id: 320,
    type: .multipleChoice,
    prompt: "複数の条件を\n順番に確認したいときに\n使うキーワードは？",
    codeSnippet: nil,
    choices: ["elif", "else", "and"],
    correctAnswer: "elif",
    explanation: "正解は elif だよ！elif は「else if」の意味で、最初のifがFalseだったときに、さらに別の条件を確認できるんだ。「追加の条件を確認＝elif」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q321 = Question(
    id: 321,
    type: .multipleChoice,
    prompt: "if, elif, else の\n実行される順番として\n正しいのは？",
    codeSnippet: nil,
    choices: ["上から順に条件を確認し、最初にTrueになったブロックだけ実行される", "すべてのブロックが必ず実行される", "下から順に条件を確認する"],
    correctAnswer: "上から順に条件を確認し、最初にTrueになったブロックだけ実行される",
    explanation: "正解は 上から順に条件を確認し、最初にTrueになったブロックだけ実行される だよ！if → elif → elif → else の順に確認していき、最初に条件が成立したブロックだけが実行されて、残りは無視されるんだ。「最初にTrueになったところだけ実行」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q322 = Question(
    id: 322,
    type: .fillInBlank,
    prompt: "点数が90点以上なら\"A\"、\n70点以上なら\"B\"、\nそれ以外なら\"C\"と\n表示したい。空欄に入るのは？",
    codeSnippet: "score = 75\nif score >= 90:\n    print(\"A\")\n_____ score >= 70:\n    print(\"B\")\nelse:\n    print(\"C\")",
    choices: ["elif", "else if", "and"],
    correctAnswer: "elif",
    explanation: "正解は elif だよ！Pythonでは「else if」をまとめて elif と書くんだ。elif の後にも条件式とコロンが必要だよ。「2つ目以降の条件＝elif」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q323 = Question(
    id: 323,
    type: .multipleChoice,
    prompt: "テストの点数によって\nA・B・Cの3段階で\n評価する処理として\n適切なのは？",
    codeSnippet: nil,
    choices: ["if score >= 90:\n    grade = \"A\"\nelif score >= 70:\n    grade = \"B\"\nelse:\n    grade = \"C\"", "if score >= 90:\n    grade = \"A\"\nif score >= 70:\n    grade = \"B\"\nif score < 70:\n    grade = \"C\"", "if score >= 90:\n    grade = \"A\"\nelse score >= 70:\n    grade = \"B\"\nelse:\n    grade = \"C\""],
    correctAnswer: "if score >= 90:\n    grade = \"A\"\nelif score >= 70:\n    grade = \"B\"\nelse:\n    grade = \"C\"",
    explanation: "正解は if ... elif ... else ... だよ！3段階の評価のように複数の条件を順番に確認するときは、if と elif と else を組み合わせるのが正しいんだ。「3つ以上に分けたい＝elifを使う」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q324 = Question(
    id: 324,
    type: .multipleChoice,
    prompt: "気温によって\n「暑い」「ふつう」「寒い」の\n3つに分ける処理として\n適切なのは？",
    codeSnippet: nil,
    choices: ["if temperature >= 30:\n    print(\"暑い\")\nelif temperature >= 15:\n    print(\"ふつう\")\nelse:\n    print(\"寒い\")", "if temperature >= 30:\n    print(\"暑い\")\nelif temperature <= 15:\n    print(\"ふつう\")\nelif:\n    print(\"寒い\")", "if temperature >= 30 and temperature >= 15:\n    print(\"暑い\")\nelse:\n    print(\"寒い\")"],
    correctAnswer: "if temperature >= 30:\n    print(\"暑い\")\nelif temperature >= 15:\n    print(\"ふつう\")\nelse:\n    print(\"寒い\")",
    explanation: "正解は if ... elif ... else ... だよ！温度を3段階に分けるには、まず一番条件が厳しい「30度以上」から確認し、次に「15度以上」、最後にそれ以外をelseでまとめるのが自然なんだ。「段階分け＝条件の厳しい順にif, elif, elseを並べる」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q325 = Question(
    id: 325,
    type: .codeOutput,
    prompt: "このコードの出力は？",
    codeSnippet: "score = 85\nif score >= 90:\n    print(\"A\")\nelif score >= 70:\n    print(\"B\")\nelse:\n    print(\"C\")",
    choices: ["B", "A", "C"],
    correctAnswer: "B",
    explanation: "正解は B だよ！score は 85 で、最初の score >= 90 は False だけど、elif の score >= 70 は True になるので \"B\" が表示されるんだ。「最初にTrueになったブロックだけ実行される」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q326 = Question(
    id: 326,
    type: .fillInBlank,
    prompt: "在庫数が0なら\"売り切れ\"、\n5個未満なら\"残りわずか\"、\nそれ以外なら\"在庫あり\"と\n表示したい。空欄に入るのは？",
    codeSnippet: "stock = 3\nif stock == 0:\n    print(\"売り切れ\")\n_____ stock < 5:\n    print(\"残りわずか\")\nelse:\n    print(\"在庫あり\")",
    choices: ["elif", "else", "if"],
    correctAnswer: "elif",
    explanation: "正解は elif だよ！最初のif（在庫が0）がFalseのときに、さらに別の条件（5個未満）を確認したいので elif を使うんだ。「if の次に別の条件を確認＝elif」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q327 = Question(
    id: 327,
    type: .codeOutput,
    prompt: "このコードを実行すると\n何が表示される？",
    codeSnippet: "temperature = 10\nif temperature >= 30:\n    print(\"暑い\")\nelif temperature >= 15:\n    print(\"ふつう\")\nelse:\n    print(\"寒い\")",
    choices: ["寒い", "ふつう", "暑い"],
    correctAnswer: "寒い",
    explanation: "正解は 寒い だよ！temperature は 10 で、temperature >= 30 も temperature >= 15 もどちらも False なので、最後の else のブロックが実行されるんだ。「すべての条件がFalseならelseが実行される」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q328 = Question(
    id: 328,
    type: .multipleChoice,
    prompt: "if の条件が False のときに\n実行されるブロックを\n指定するキーワードは？",
    codeSnippet: nil,
    choices: ["else", "elif", "and"],
    correctAnswer: "else",
    explanation: "正解は else だよ！if の条件が成立しないときの処理をまとめるキーワードだったね。「条件が成立しない場合＝else」と覚えておこう！（前のレッスン「elseを使おう」の復習だよ）",
    xpReward: 10,
    gemReward: 1
)

private let q329 = Question(
    id: 329,
    type: .codeOutput,
    prompt: "配送料金アプリで、\n購入金額に応じて\n配送料を3段階で\n決めたい。出力はどれ？",
    codeSnippet: "total_price = 2500\nif total_price >= 5000:\n    shipping_fee = 0\nelif total_price >= 2000:\n    shipping_fee = 200\nelse:\n    shipping_fee = 500\nprint(\"配送料：\" + str(shipping_fee) + \"円\")",
    choices: ["配送料：200円", "配送料：0円", "配送料：500円"],
    correctAnswer: "配送料：200円",
    explanation: "正解は 配送料：200円 だよ！total_price は 2500 で、5000以上ではないけれど2000以上なので elif のブロックが実行され、shipping_fee は 200 になるんだ。「複数段階の料金設定＝if, elif, elseで条件を順に確認」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)


// ─────────────────────────────────────────────────────────
// MARK: - Lesson 33 · 比較と条件を組み合わせよう
// ─────────────────────────────────────────────────────────

private let lesson33 = Lesson(
    id: 33,
    title: "比較と条件を組み合わせよう",
    shortLabel: "比較と条件",
    subtitle: "比較演算子で分岐",
    category: "条件分岐",
    order: 33,
    questions: [q330, q331, q332, q333, q334, q335, q336, q337, q338, q339],
    requiredXP: 1650
)

private let q330 = Question(
    id: 330,
    type: .multipleChoice,
    prompt: "2つの値が等しいかを\n調べる演算子は？",
    codeSnippet: nil,
    choices: ["==", "=", "!="],
    correctAnswer: "==",
    explanation: "正解は == だよ！if文の条件式の中で「等しいか」を調べるときは == を使うんだ。「等しいか比べる＝==」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q331 = Question(
    id: 331,
    type: .multipleChoice,
    prompt: "「20歳以上」を表す\n条件式として正しいのは？",
    codeSnippet: nil,
    choices: ["age >= 20", "age > 20", "age =20"],
    correctAnswer: "age >= 20",
    explanation: "正解は age >= 20 だよ！「以上」は「その値を含む」という意味なので >= を使うんだ。20より大きい（含まない）を表す > とは違うので注意しよう。「以上＝>=」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q332 = Question(
    id: 332,
    type: .fillInBlank,
    prompt: "残り時間が0より\n大きいあいだは\nゲームを続けたい。\n空欄に入るのは？",
    codeSnippet: "time_left = 30\nif time_left _____ 0:\n    print(\"ゲーム続行中\")",
    choices: [">", "<", "=="],
    correctAnswer: ">",
    explanation: "正解は > だよ！「残り時間が0より大きい」を表すには比較演算子の > を使うんだ。「より大きい＝>」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q333 = Question(
    id: 333,
    type: .multipleChoice,
    prompt: "パスワードの文字数が\n8文字未満なら\n警告を出したい。\n条件式として正しいのは？",
    codeSnippet: nil,
    choices: ["len(password) < 8", "len(password) > 8", "len(password) = 8"],
    correctAnswer: "len(password) < 8",
    explanation: "正解は len(password) < 8 だよ！「8文字未満」は「8より小さい」という意味なので < を使うんだ。len() で文字列の長さを取得できることも確認しておこう。「未満＝<」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q334 = Question(
    id: 334,
    type: .multipleChoice,
    prompt: "在庫数が\nちょうど0個のときだけ\n「在庫切れ」と\n表示したい。条件式として\n正しいのは？",
    codeSnippet: nil,
    choices: ["stock == 0", "stock = 0", "stock != 0"],
    correctAnswer: "stock == 0",
    explanation: "正解は stock == 0 だよ！「ちょうど0個」は「等しい」という意味なので == を使うんだ。!= は「等しくない」という意味になり、結果が逆になってしまうので注意しよう。「等しいか確認＝==」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q335 = Question(
    id: 335,
    type: .codeOutput,
    prompt: "このコードの出力は？",
    codeSnippet: "temperature = 35\nif temperature >= 35:\n    print(\"猛暑です\")\nelif temperature >= 25:\n    print(\"暑いです\")\nelse:\n    print(\"快適です\")",
    choices: ["猛暑です", "暑いです", "快適です"],
    correctAnswer: "猛暑です",
    explanation: "正解は 猛暑です だよ！temperature は 35 で 35 >= 35 は True なので、最初の if のブロックが実行されて「猛暑です」が表示されるんだ。「条件は上から順に確認し、最初にTrueになったところで止まる」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q336 = Question(
    id: 336,
    type: .fillInBlank,
    prompt: "年齢が65歳以上なら\n「シニア料金」と\n表示したい。空欄に入るのは？",
    codeSnippet: "age = 70\nif age _____ 65:\n    print(\"シニア料金\")",
    choices: [">=", "<=", "=="],
    correctAnswer: ">=",
    explanation: "正解は >= だよ！「65歳以上」は「65を含めてそれより大きい」という意味なので >= を使うんだ。「以上＝>=」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q337 = Question(
    id: 337,
    type: .codeOutput,
    prompt: "このコードを実行すると\n何が表示される？",
    codeSnippet: "price = 980\nbudget = 1000\nif price <= budget:\n    print(\"購入できます\")\nelse:\n    print(\"予算を超えています\")",
    choices: ["購入できます", "予算を超えています", "980"],
    correctAnswer: "購入できます",
    explanation: "正解は 購入できます だよ！price は 980 で budget は 1000、980 <= 1000 は True なので if のブロックが実行されるんだ。「予算内かどうか＝価格 <= 予算」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q338 = Question(
    id: 338,
    type: .multipleChoice,
    prompt: "複数の条件を\n順番に確認したいときに\n使うキーワードは？",
    codeSnippet: nil,
    choices: ["elif", "else", "and"],
    correctAnswer: "elif",
    explanation: "正解は elif だよ！最初のifがFalseのとき、さらに別の条件を確認できるキーワードだったね。「追加の条件を確認＝elif」と覚えておこう！（前のレッスン「elifを使おう」の復習だよ）",
    xpReward: 10,
    gemReward: 1
)

private let q339 = Question(
    id: 339,
    type: .codeOutput,
    prompt: "体温チェックアプリで、\n体温に応じて\nメッセージを\n3段階で出したい。\n出力はどれ？",
    codeSnippet: "body_temp = 37.8\nif body_temp >= 38.0:\n    print(\"発熱の可能性があります\")\nelif body_temp >= 37.0:\n    print(\"少し高めです\")\nelse:\n    print(\"平熱です\")",
    choices: ["少し高めです", "発熱の可能性があります", "平熱です"],
    correctAnswer: "少し高めです",
    explanation: "正解は 少し高めです だよ！body_temp は 37.8 で、38.0以上ではないけれど37.0以上なので elif のブロックが実行されるんだ。「数値の比較で段階を判定する＝if, elif, elseを組み合わせる」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)


// ─────────────────────────────────────────────────────────
// MARK: - Lesson 34 · and / or と条件分岐
// ─────────────────────────────────────────────────────────

private let lesson34 = Lesson(
    id: 34,
    title: "and / or と条件分岐",
    shortLabel: "and/orと分岐",
    subtitle: "複数条件をifで使う",
    category: "条件分岐",
    order: 34,
    questions: [q340, q341, q342, q343, q344, q345, q346, q347, q348, q349],
    requiredXP: 1700
)

private let q340 = Question(
    id: 340,
    type: .multipleChoice,
    prompt: "「会員で、かつ\n合計金額が3000円以上」\nのときだけ割引する\n条件式として正しいのは？",
    codeSnippet: nil,
    choices: ["is_member and total >= 3000", "is_member or total >= 3000", "is_member == total >= 3000"],
    correctAnswer: "is_member and total >= 3000",
    explanation: "正解は is_member and total >= 3000 だよ！「会員」と「金額条件」を両方満たす必要があるので and でつなぐんだ。「両方とも満たす＝and」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q341 = Question(
    id: 341,
    type: .multipleChoice,
    prompt: "「クーポンを持っている、\nまたは会員である」場合に\n割引する条件式として\n正しいのは？",
    codeSnippet: nil,
    choices: ["has_coupon or is_member", "has_coupon and is_member", "not has_coupon"],
    correctAnswer: "has_coupon or is_member",
    explanation: "正解は has_coupon or is_member だよ！「どちらか一方を満たせばよい」という条件は or でつなぐんだ。「いずれか満たせばよい＝or」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q342 = Question(
    id: 342,
    type: .fillInBlank,
    prompt: "年齢が18歳以上で、\nかつ身分証を持っているなら\n入場できる。\n空欄に入るのは？",
    codeSnippet: "if age >= 18 _____ has_id:\n    print(\"入場できます\")\nelse:\n    print(\"入場できません\")",
    choices: ["and", "or", "not"],
    correctAnswer: "and",
    explanation: "正解は and だよ！「年齢」と「身分証」の両方の条件を満たす必要があるので and でつなぐんだ。「すべて満たす必要がある＝and」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q343 = Question(
    id: 343,
    type: .multipleChoice,
    prompt: "ログイン処理で、\n「ユーザー名が一致し、\nかつパスワードも一致する」\nときにログイン成功とする\n条件式として正しいのは？",
    codeSnippet: nil,
    choices: ["if user_name == correct_name and password == correct_password:", "if user_name == correct_name or password == correct_password:", "if user_name == correct_name, password == correct_password:"],
    correctAnswer: "if user_name == correct_name and password == correct_password:",
    explanation: "正解は if user_name == correct_name and password == correct_password: だよ！両方が一致していないとログインを許可してはいけないので and を使うのが正しいんだ。「両方の条件を確認する認証＝and」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q344 = Question(
    id: 344,
    type: .multipleChoice,
    prompt: "在庫があり\n（stock > 0）、\nかつ予算内\n（price <= budget）の\n商品だけを買いたい。\n条件式として正しいのは？",
    codeSnippet: nil,
    choices: ["stock > 0 and price <= budget", "stock > 0 or price <= budget", "stock > 0 and price >= budget"],
    correctAnswer: "stock > 0 and price <= budget",
    explanation: "正解は stock > 0 and price <= budget だよ！「在庫がある」かつ「予算内」の両方を満たす必要があるので and を使うんだ。「両方の条件を確認＝and」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q345 = Question(
    id: 345,
    type: .codeOutput,
    prompt: "このコードの出力は？",
    codeSnippet: "age = 20\nhas_id = False\nif age >= 18 and has_id:\n    print(\"入場できます\")\nelse:\n    print(\"入場できません\")",
    choices: ["入場できません", "入場できます", "20"],
    correctAnswer: "入場できません",
    explanation: "正解は 入場できません だよ！age >= 18 は True だけど has_id は False なので、and の結果は False になり、else のブロックが実行されるんだ。「andは片方でもFalseなら全体がFalse」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q346 = Question(
    id: 346,
    type: .fillInBlank,
    prompt: "会員でない人だけに\n「会員登録のご案内」を\n表示したい。\n空欄に入るのは？",
    codeSnippet: "is_member = False\nif _____ is_member:\n    print(\"会員登録のご案内\")",
    choices: ["not", "and", "or"],
    correctAnswer: "not",
    explanation: "正解は not だよ！is_member が False のときに表示したいので、not is_member（つまりTrue）をif の条件にするんだ。「条件を反転させる＝not」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q347 = Question(
    id: 347,
    type: .codeOutput,
    prompt: "このコードを実行すると\n何が表示される？",
    codeSnippet: "is_member = False\ntotal_price = 6000\nif is_member or total_price >= 5000:\n    print(\"割引が適用されます\")\nelse:\n    print(\"通常価格です\")",
    choices: ["割引が適用されます", "通常価格です", "False"],
    correctAnswer: "割引が適用されます",
    explanation: "正解は 割引が適用されます だよ！is_member は False だけど total_price >= 5000 は True なので、or の結果は True になり if のブロックが実行されるんだ。「orは片方でもTrueなら全体がTrue」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q348 = Question(
    id: 348,
    type: .multipleChoice,
    prompt: "2つの値が等しいかを\n調べる演算子は？",
    codeSnippet: nil,
    choices: ["==", "=", "!="],
    correctAnswer: "==",
    explanation: "正解は == だよ！比較に使うのは == で、= は代入専用なんだったね。「等しいか比べる＝==」と覚えておこう！（前のレッスン「比較と条件を組み合わせよう」の復習だよ）",
    xpReward: 10,
    gemReward: 1
)

private let q349 = Question(
    id: 349,
    type: .codeOutput,
    prompt: "イベント受付アプリで、\n「学生証を持っている、\nまたは年齢が65歳以上」\nの人は割引料金にしたい。\n出力はどれ？",
    codeSnippet: "has_student_id = False\nage = 70\nif has_student_id or age >= 65:\n    fee = 500\nelse:\n    fee = 1000\nprint(\"参加費：\" + str(fee) + \"円\")",
    choices: ["参加費：500円", "参加費：1000円", "参加費：0円"],
    correctAnswer: "参加費：500円",
    explanation: "正解は 参加費：500円 だよ！has_student_id は False だけど age >= 65 は True なので、or の結果は True になり fee は 500 になるんだ。「複数の条件をorでつないで割引判定する」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)


// ─────────────────────────────────────────────────────────
// MARK: - Lesson 35 · ネストしたifを読もう
// ─────────────────────────────────────────────────────────

private let lesson35 = Lesson(
    id: 35,
    title: "ネストしたifを読もう",
    shortLabel: "ネストif",
    subtitle: "ifの中にif",
    category: "条件分岐",
    order: 35,
    questions: [q350, q351, q352, q353, q354, q355, q356, q357, q358, q359],
    requiredXP: 1750
)

private let q350 = Question(
    id: 350,
    type: .multipleChoice,
    prompt: "if のブロックの中に\nさらに別の if を書くことを\n何と呼ぶ？",
    codeSnippet: nil,
    choices: ["ネスト（入れ子）", "ループ", "リスト"],
    correctAnswer: "ネスト（入れ子）",
    explanation: "正解は ネスト（入れ子） だよ！if の中にさらに if を書くことを「ネスト（入れ子）」と呼ぶんだ。外側の条件がTrueのときだけ、内側の条件がチェックされるよ。「ifの中のif＝ネスト」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q351 = Question(
    id: 351,
    type: .multipleChoice,
    prompt: "ネストしたifを書くとき、\n内側のifのインデントは\n外側のifと比べて\nどうなる？",
    codeSnippet: nil,
    choices: ["さらに深くする（多めにインデントする）", "外側と同じインデントにする", "インデントしない"],
    correctAnswer: "さらに深くする（多めにインデントする）",
    explanation: "正解は さらに深くする（多めにインデントする） だよ！内側のブロックは外側のブロックよりもさらにインデントを増やす必要があるんだ。インデントの深さで、どのifに属しているかが決まるよ。「内側のブロック＝さらにインデント」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q352 = Question(
    id: 352,
    type: .fillInBlank,
    prompt: "会員であり、\nさらにその中で\nポイントが100以上なら\n特典を表示したい。\n空欄に入るのは？",
    codeSnippet: "if is_member:\n    if points >= 100:\n        print(\"特典をプレゼント！\")\n    _____:\n        print(\"もう少しでポイント特典です\")",
    choices: ["else", "elif", "and"],
    correctAnswer: "else",
    explanation: "正解は else だよ！内側のif（points >= 100）に対応するelseなので、内側のifと同じインデントの深さで書く必要があるんだ。「内側のifには内側のelse」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q353 = Question(
    id: 353,
    type: .multipleChoice,
    prompt: "「会員である場合、\nさらにその中でポイントが\n1000以上ならVIP扱いにする」\n処理として正しいのは？",
    codeSnippet: nil,
    choices: ["if is_member:\n    if points >= 1000:\n        print(\"VIPです\")", "if is_member:\nif points >= 1000:\n    print(\"VIPです\")", "if is_member and if points >= 1000:\n    print(\"VIPです\")"],
    correctAnswer: "if is_member:\n    if points >= 1000:\n        print(\"VIPです\")",
    explanation: "正解は if is_member: ... if points >= 1000: ... だよ！外側のifの中に、さらにインデントを深くした内側のifを書くのがネストの正しい形なんだ。「外側のブロックの中に内側のif全体を書く」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q354 = Question(
    id: 354,
    type: .multipleChoice,
    prompt: "次のコードで\n\"特別価格です\"が\n表示される条件は？\nif is_member:\n    if total >= 5000:\n        print(\"特別価格です\")",
    codeSnippet: nil,
    choices: ["is_member が True で、かつ total が 5000 以上のとき", "is_member が True のときだけ（totalは関係ない）", "total が 5000 以上のときだけ（is_memberは関係ない）"],
    correctAnswer: "is_member が True で、かつ total が 5000 以上のとき",
    explanation: "正解は is_member が True で、かつ total が 5000 以上のとき だよ！ネストしたifでは、外側の条件がTrueの場合のみ内側の条件が確認されるので、両方がTrueのときだけ最も内側の処理が実行されるんだ。「ネストは両方の条件を満たす必要がある」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q355 = Question(
    id: 355,
    type: .codeOutput,
    prompt: "このコードの出力は？",
    codeSnippet: "is_member = True\npoints = 1500\nif is_member:\n    if points >= 1000:\n        print(\"VIPです\")\n    else:\n        print(\"一般会員です\")\nelse:\n    print(\"非会員です\")",
    choices: ["VIPです", "一般会員です", "非会員です"],
    correctAnswer: "VIPです",
    explanation: "正解は VIPです だよ！is_member が True なので内側のifが確認され、points は 1500 で 1000以上なので「VIPです」が表示されるんだ。「外側がTrueのときだけ内側のifが評価される」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q356 = Question(
    id: 356,
    type: .fillInBlank,
    prompt: "ログイン済みかどうか、\nさらにその中で\n管理者かどうかを\n確認したい。\n空欄に入るのは？",
    codeSnippet: "if is_logged_in:\n    _____ is_admin:\n        print(\"管理画面へ\")\n    else:\n        print(\"ユーザー画面へ\")\nelse:\n    print(\"ログインしてください\")",
    choices: ["if", "elif", "for"],
    correctAnswer: "if",
    explanation: "正解は if だよ！外側のif（ログイン済みか）の中に、さらに別の条件（管理者かどうか）を確認するために内側の if を書くんだ。「ifの中にもifを書ける＝ネスト」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q357 = Question(
    id: 357,
    type: .codeOutput,
    prompt: "このコードを実行すると\n何が表示される？",
    codeSnippet: "is_logged_in = True\nis_admin = False\nif is_logged_in:\n    if is_admin:\n        print(\"管理画面へ\")\n    else:\n        print(\"ユーザー画面へ\")\nelse:\n    print(\"ログインしてください\")",
    choices: ["ユーザー画面へ", "管理画面へ", "ログインしてください"],
    correctAnswer: "ユーザー画面へ",
    explanation: "正解は ユーザー画面へ だよ！is_logged_in が True なので内側のifが確認され、is_admin は False なので内側の else が実行されるんだ。「外側True・内側Falseならネストのelseが実行される」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q358 = Question(
    id: 358,
    type: .multipleChoice,
    prompt: "「クーポンを持っている、\nまたは会員である」場合に\n割引する条件式として\n正しいのは？",
    codeSnippet: nil,
    choices: ["has_coupon or is_member", "has_coupon and is_member", "not has_coupon"],
    correctAnswer: "has_coupon or is_member",
    explanation: "正解は has_coupon or is_member だよ！どちらか一方を満たせばよい条件は or でつなぐんだったね。「いずれか満たせばよい＝or」と覚えておこう！（前のレッスン「and / or と条件分岐」の復習だよ）",
    xpReward: 10,
    gemReward: 1
)

private let q359 = Question(
    id: 359,
    type: .codeOutput,
    prompt: "ゲームのアイテム購入で、\n「ログインしていて、さらに\nコインが足りる場合だけ」\n購入できるようにしたい。\n出力はどれ？",
    codeSnippet: "is_logged_in = True\ncoins = 50\nitem_cost = 80\nif is_logged_in:\n    if coins >= item_cost:\n        print(\"購入しました\")\n    else:\n        print(\"コインが不足しています\")\nelse:\n    print(\"ログインしてください\")",
    choices: ["コインが不足しています", "購入しました", "ログインしてください"],
    correctAnswer: "コインが不足しています",
    explanation: "正解は コインが不足しています だよ！is_logged_in は True なので内側のifが確認され、coins（50）は item_cost（80）より少ないので内側のelseが実行されるんだ。「ネストしたifで段階的に条件を確認する」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)


// ─────────────────────────────────────────────────────────
// MARK: - Lesson 36 · 条件分岐で入力を判定しよう
// ─────────────────────────────────────────────────────────

private let lesson36 = Lesson(
    id: 36,
    title: "条件分岐で入力を判定しよう",
    shortLabel: "入力の判定",
    subtitle: "input()と条件分岐",
    category: "条件分岐",
    order: 36,
    questions: [q360, q361, q362, q363, q364, q365, q366, q367, q368, q369],
    requiredXP: 1800
)

private let q360 = Question(
    id: 360,
    type: .multipleChoice,
    prompt: "ユーザーからの入力を\n受け取る関数は？",
    codeSnippet: nil,
    choices: ["input()", "print()", "len()"],
    correctAnswer: "input()",
    explanation: "正解は input() だよ！input() はユーザーがキーボードで入力した内容を文字列として受け取る関数なんだ。「入力を受け取る＝input()」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q361 = Question(
    id: 361,
    type: .multipleChoice,
    prompt: "input() で受け取った値の\n型は？",
    codeSnippet: nil,
    choices: ["str（文字列）", "int（整数）", "float（小数）"],
    correctAnswer: "str（文字列）",
    explanation: "正解は str（文字列） だよ！input() はどんな入力をしても必ず文字列（str型）として受け取るんだ。数値として使いたい場合は int() や float() で変換が必要だよ。「input()の結果＝常にstr」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q362 = Question(
    id: 362,
    type: .fillInBlank,
    prompt: "入力された文字列を\n整数に変換したい。\n空欄に入るのは？",
    codeSnippet: "age_text = input(\"年齢を入力してください：\")\nage = _____(age_text)\nprint(age + 1)",
    choices: ["int", "str", "len"],
    correctAnswer: "int",
    explanation: "正解は int だよ！int() を使うと、数字の文字列を整数（int型）に変換できるんだ。これをしないと、文字列のまま足し算しようとしてエラーになるよ。「文字列を整数に変換＝int()」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q363 = Question(
    id: 363,
    type: .multipleChoice,
    prompt: "入力された文字列が\n\"yes\"かどうかを\n判定する条件式として\n正しいのは？",
    codeSnippet: nil,
    choices: ["answer == \"yes\"", "answer = \"yes\"", "answer >= \"yes\""],
    correctAnswer: "answer == \"yes\"",
    explanation: "正解は answer == \"yes\" だよ！文字列同士が等しいかを調べるには == を使うんだ。「文字列の比較も==」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q364 = Question(
    id: 364,
    type: .multipleChoice,
    prompt: "入力された年齢（文字列）を\n整数に変換して\n20歳以上かを判定する\n処理として正しいのは？",
    codeSnippet: nil,
    choices: ["age = int(input(\"年齢：\"))\nif age >= 20:\n    print(\"成人です\")", "age = input(\"年齢：\")\nif age >= 20:\n    print(\"成人です\")", "age = int(input(\"年齢：\"))\nif age >= \"20\":\n    print(\"成人です\")"],
    correctAnswer: "age = int(input(\"年齢：\"))\nif age >= 20:\n    print(\"成人です\")",
    explanation: "正解は age = int(input(\"年齢：\")) ... if age >= 20: だよ！input()の結果は文字列なので、数値として比較する前に int() で変換する必要があるんだ。「数値として使う前にint()で変換」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q365 = Question(
    id: 365,
    type: .codeOutput,
    prompt: "このコードの出力は？\n（入力として \"15\" が\n与えられたとする）",
    codeSnippet: "age_text = \"15\"\nage = int(age_text)\nif age >= 18:\n    print(\"成人です\")\nelse:\n    print(\"未成年です\")",
    choices: ["未成年です", "成人です", "15"],
    correctAnswer: "未成年です",
    explanation: "正解は 未成年です だよ！age_text \"15\" を int() で整数の 15 に変換し、15 >= 18 は False なので else のブロックが実行されるんだ。「input()の値はint()で数値に変換して比較する」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q366 = Question(
    id: 366,
    type: .fillInBlank,
    prompt: "クイズで、\n答えが\"Python\"と\n一致するか調べたい。\n空欄に入るのは？",
    codeSnippet: "answer = \"Python\"\ncorrect_answer = \"Python\"\nif answer _____ correct_answer:\n    print(\"正解です\")\nelse:\n    print(\"不正解です\")",
    choices: ["==", "=", "is"],
    correctAnswer: "==",
    explanation: "正解は == だよ！2つの文字列が一致しているかを調べるには == を使うんだ。「文字列の比較＝==」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q367 = Question(
    id: 367,
    type: .codeOutput,
    prompt: "このコードを実行すると\n何が表示される？\n（answerは\"python\"とする）",
    codeSnippet: "answer = \"python\"\ncorrect_answer = \"Python\"\nif answer == correct_answer:\n    print(\"正解です\")\nelse:\n    print(\"不正解です\")",
    choices: ["不正解です", "正解です", "エラーになる"],
    correctAnswer: "不正解です",
    explanation: "正解は 不正解です だよ！\"python\"（小文字）と \"Python\"（大文字始まり）は違う文字列として扱われるので == は False になり、else が実行されるんだ。「文字列の比較は大文字・小文字も区別される」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q368 = Question(
    id: 368,
    type: .multipleChoice,
    prompt: "if のブロックの中に\nさらに別の if を書くことを\n何と呼ぶ？",
    codeSnippet: nil,
    choices: ["ネスト（入れ子）", "ループ", "リスト"],
    correctAnswer: "ネスト（入れ子）",
    explanation: "正解は ネスト（入れ子） だよ！外側のifの条件がTrueのときだけ、内側のifが確認されるんだったね。「ifの中のif＝ネスト」と覚えておこう！（前のレッスン「ネストしたifを読もう」の復習だよ）",
    xpReward: 10,
    gemReward: 1
)

private let q369 = Question(
    id: 369,
    type: .codeOutput,
    prompt: "年齢入力アプリで、\n入力された年齢を\nもとに「子供」「大人」\n「シニア」を判定したい。\n出力はどれ？\n（入力は\"68\"とする）",
    codeSnippet: "age_text = \"68\"\nage = int(age_text)\nif age < 18:\n    print(\"子供\")\nelif age < 65:\n    print(\"大人\")\nelse:\n    print(\"シニア\")",
    choices: ["シニア", "大人", "子供"],
    correctAnswer: "シニア",
    explanation: "正解は シニア だよ！\"68\" を int() で 68 に変換し、18未満でも65未満でもないので、elseのブロックが実行されて \"シニア\" が表示されるんだ。「文字列の入力をint()で変換してから段階判定する」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)


// ─────────────────────────────────────────────────────────
// MARK: - Lesson 37 · 条件分岐とリストを組み合わせよう
// ─────────────────────────────────────────────────────────

private let lesson37 = Lesson(
    id: 37,
    title: "条件分岐とリストを組み合わせよう",
    shortLabel: "条件分岐とリスト",
    subtitle: "in と if",
    category: "条件分岐",
    order: 37,
    questions: [q370, q371, q372, q373, q374, q375, q376, q377, q378, q379],
    requiredXP: 1850
)

private let q370 = Question(
    id: 370,
    type: .multipleChoice,
    prompt: "リストの中に\n特定の値が含まれているかを\n調べる演算子は？",
    codeSnippet: nil,
    choices: ["in", "==", "is"],
    correctAnswer: "in",
    explanation: "正解は in だよ！\"りんご\" in item_list のように書くと、item_list の中に \"りんご\" が含まれているかを True / False で調べられるんだ。「含まれているか調べる＝in」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q371 = Question(
    id: 371,
    type: .multipleChoice,
    prompt: "買い物リストに\n\"牛乳\"が含まれているかを\nif文で確認する処理として\n正しいのは？",
    codeSnippet: nil,
    choices: ["if \"牛乳\" in item_list:\n    print(\"牛乳はリストにあります\")", "if \"牛乳\" == item_list:\n    print(\"牛乳はリストにあります\")", "if item_list in \"牛乳\":\n    print(\"牛乳はリストにあります\")"],
    correctAnswer: "if \"牛乳\" in item_list:\n    print(\"牛乳はリストにあります\")",
    explanation: "正解は if \"牛乳\" in item_list: だよ！in 演算子を使うと、リストの中に指定した値が含まれているかをif文の条件として使えるんだ。「リストの中身を確認＝in をifで使う」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q372 = Question(
    id: 372,
    type: .fillInBlank,
    prompt: "リストが空かどうかを\n判定したい。\n空欄に入るのは？",
    codeSnippet: "item_list = []\nif len(item_list) _____ 0:\n    print(\"リストは空です\")",
    choices: ["==", "in", "is"],
    correctAnswer: "==",
    explanation: "正解は == だよ！len(item_list) でリストの要素数を取得し、それが 0 と等しいかを == で確認すれば、リストが空かどうかを判定できるんだ。「リストが空＝len()が0」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q373 = Question(
    id: 373,
    type: .multipleChoice,
    prompt: "禁止ワードのリストに\n入力されたメッセージが\n含まれていたら\n警告を出す処理として\n正しいのは？",
    codeSnippet: nil,
    choices: ["if message in banned_words:\n    print(\"警告：禁止ワードです\")", "if banned_words in message:\n    print(\"警告：禁止ワードです\")", "if message == banned_words:\n    print(\"警告：禁止ワードです\")"],
    correctAnswer: "if message in banned_words:\n    print(\"警告：禁止ワードです\")",
    explanation: "正解は if message in banned_words: だよ！message が banned_words（リスト）の中に含まれているかを in で調べるのが正しいんだ。順番を逆にすると意味が変わってしまうので注意しよう。「値 in リスト の順番」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q374 = Question(
    id: 374,
    type: .multipleChoice,
    prompt: "ショッピングリストが\n空でない場合だけ\n「リストに商品があります」と\n表示する処理として\n正しいのは？",
    codeSnippet: nil,
    choices: ["if len(item_list) > 0:\n    print(\"リストに商品があります\")", "if len(item_list) > 0:\nprint(\"リストに商品があります\")", "if item_list > 0:\n    print(\"リストに商品があります\")"],
    correctAnswer: "if len(item_list) > 0:\n    print(\"リストに商品があります\")",
    explanation: "正解は if len(item_list) > 0: だよ！リストの要素数が0より大きいかを len() で調べることで、リストが空でないかを判定できるんだ。「リストが空でない＝len()が0より大きい」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q375 = Question(
    id: 375,
    type: .codeOutput,
    prompt: "このコードの出力は？",
    codeSnippet: "item_list = [\"りんご\", \"バナナ\", \"みかん\"]\nif \"バナナ\" in item_list:\n    print(\"バナナはリストにあります\")\nelse:\n    print(\"バナナはリストにありません\")",
    choices: ["バナナはリストにあります", "バナナはリストにありません", "True"],
    correctAnswer: "バナナはリストにあります",
    explanation: "正解は バナナはリストにあります だよ！item_list の中に \"バナナ\" が含まれているので \"バナナ\" in item_list は True になり、if のブロックが実行されるんだ。「inで含まれているかを確認しifで分岐する」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q376 = Question(
    id: 376,
    type: .fillInBlank,
    prompt: "在庫リストに商品名が\n含まれていなければ\n「取り扱いがありません」と\n表示したい。\n空欄に入るのは？",
    codeSnippet: "stock_list = [\"ノート\", \"消しゴム\"]\nitem_name = \"鉛筆\"\nif item_name _____ stock_list:\n    print(\"取り扱いがありません\")",
    choices: ["not in", "in", "not"],
    correctAnswer: "not in",
    explanation: "正解は not in だよ！\"鉛筆\" が stock_list の中に含まれていないことを調べるには not in を使うんだ。not in は in の反対で、含まれていなければ True になるよ。「含まれていない＝not in」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q377 = Question(
    id: 377,
    type: .codeOutput,
    prompt: "このコードを実行すると\n何が表示される？",
    codeSnippet: "stock_list = [\"ノート\", \"消しゴム\"]\nitem_name = \"鉛筆\"\nif item_name not in stock_list:\n    print(\"取り扱いがありません\")\nelse:\n    print(\"在庫があります\")",
    choices: ["取り扱いがありません", "在庫があります", "鉛筆"],
    correctAnswer: "取り扱いがありません",
    explanation: "正解は 取り扱いがありません だよ！\"鉛筆\" は stock_list に含まれていないので item_name not in stock_list は True になり、if のブロックが実行されるんだ。「not in は含まれていないときにTrue」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q378 = Question(
    id: 378,
    type: .multipleChoice,
    prompt: "input() で受け取った値の\n型は？",
    codeSnippet: nil,
    choices: ["str（文字列）", "int（整数）", "float（小数）"],
    correctAnswer: "str（文字列）",
    explanation: "正解は str（文字列） だよ！input() の戻り値はどんな入力でも常に文字列（str型）になるんだったね。「input()の結果＝常にstr」と覚えておこう！（前のレッスン「条件分岐で入力を判定しよう」の復習だよ）",
    xpReward: 10,
    gemReward: 1
)

private let q379 = Question(
    id: 379,
    type: .codeOutput,
    prompt: "アレルギーチェックアプリで、\n料理の材料リストに\nアレルゲンが含まれて\nいないかを確認したい。\n出力はどれ？",
    codeSnippet: "ingredients = [\"小麦\", \"卵\", \"牛乳\"]\nallergen = \"卵\"\nif allergen in ingredients:\n    print(\"この料理にはアレルゲンが含まれています\")\nelse:\n    print(\"この料理は安全です\")",
    choices: ["この料理にはアレルゲンが含まれています", "この料理は安全です", "卵"],
    correctAnswer: "この料理にはアレルゲンが含まれています",
    explanation: "正解は この料理にはアレルゲンが含まれています だよ！ingredients の中に \"卵\" が含まれているので、allergen in ingredients は True になり if のブロックが実行されるんだ。「リストの中身を確認して安全性を判定する＝in とif」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)


// ─────────────────────────────────────────────────────────
// MARK: - Lesson 38 · 条件分岐の落とし穴を読もう
// ─────────────────────────────────────────────────────────

private let lesson38 = Lesson(
    id: 38,
    title: "条件分岐の落とし穴を読もう",
    shortLabel: "落とし穴",
    subtitle: "elifの順序ミス",
    category: "条件分岐",
    order: 38,
    questions: [q380, q381, q382, q383, q384, q385, q386, q387, q388, q389],
    requiredXP: 1900
)

private let q380 = Question(
    id: 380,
    type: .multipleChoice,
    prompt: "次のコードのバグは\nどこにある？\nscore = 95\nif score >= 60:\n    print(\"合格\")\nelif score >= 90:\n    print(\"優秀\")",
    codeSnippet: nil,
    choices: ["条件の順序が逆で、score >= 90 が先に来るべき", "比較演算子が間違っている", "print の引数が間違っている"],
    correctAnswer: "条件の順序が逆で、score >= 90 が先に来るべき",
    explanation: "正解は 条件の順序が逆で、score >= 90 が先に来るべき だよ！score が95でも、最初の if score >= 60: が先にTrueになって \"合格\" が表示され、elif の \"優秀\" は永遠に実行されないんだ。条件の厳しい順（数値が大きい順）に並べる必要があるよ。「elifは厳しい条件から先に書く」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q381 = Question(
    id: 381,
    type: .multipleChoice,
    prompt: "if文の中で\nインデントがずれていると\n何が起こる？",
    codeSnippet: nil,
    choices: ["IndentationError（インデントエラー）が発生する", "自動的に修正されて実行される", "何も起きず正常に動く"],
    correctAnswer: "IndentationError（インデントエラー）が発生する",
    explanation: "正解は IndentationError（インデントエラー） だよ！Pythonはインデントの深さでブロックの範囲を判断するので、インデントがずれているとエラーになるんだ。「インデントのずれ＝IndentationError」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q382 = Question(
    id: 382,
    type: .fillInBlank,
    prompt: "次のコードのバグを\n直したい。\nelifで90点以上を\n先に確認するように\n並び順を直すには、\n空欄をどう入れ替える？",
    codeSnippet: "score = 95\nif score >= _____:\n    print(\"優秀\")\nelif score >= 60:\n    print(\"合格\")\n# 正しい順序にしたい",
    choices: ["90", "60", "100"],
    correctAnswer: "90",
    explanation: "正解は 90 だよ！score >= 90 を先に確認することで、95点のときに正しく \"優秀\" が表示されるようになるんだ。条件の数値が大きい（厳しい）方を先に書くのが正解だよ。「厳しい条件を先に書く」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q383 = Question(
    id: 383,
    type: .multipleChoice,
    prompt: "次のコードのバグは\nどこにある？\nstock = 5\nif stock = 0:\n    print(\"在庫切れ\")\nelse:\n    print(\"在庫あり\")",
    codeSnippet: nil,
    choices: ["= が == であるべき（比較と代入を混同している）", "stock の値が間違っている", "else が elif であるべき"],
    correctAnswer: "= が == であるべき（比較と代入を混同している）",
    explanation: "正解は = が == であるべき（比較と代入を混同している） だよ！if の条件式で値を比較したいのに = （代入）を使ってしまっているので構文エラーになるんだ。「比較は==、代入は=」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q384 = Question(
    id: 384,
    type: .multipleChoice,
    prompt: "次のコードのバグは\nどこにある？\nage_text = \"20\"\nif age_text >= 18:\n    print(\"成人です\")",
    codeSnippet: nil,
    choices: ["age_text が文字列のまま比較されている（int()で変換が必要）", "18 が \"18\" であるべき", ">= が <= であるべき"],
    correctAnswer: "age_text が文字列のまま比較されている（int()で変換が必要）",
    explanation: "正解は age_text が文字列のまま比較されている（int()で変換が必要） だよ！age_text は文字列なので、数値の 18 と比較するには int(age_text) のように整数に変換する必要があるんだ。文字列と数値を比較しようとするとエラーになるよ。「input()の値はint()で変換してから比較する」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q385 = Question(
    id: 385,
    type: .codeOutput,
    prompt: "このコードの出力は？\n（条件の順序に注意）",
    codeSnippet: "temperature = 35\nif temperature >= 0:\n    print(\"普通の気温です\")\nelif temperature >= 30:\n    print(\"暑いです\")",
    choices: ["普通の気温です", "暑いです", "何も表示されない"],
    correctAnswer: "普通の気温です",
    explanation: "正解は 普通の気温です だよ！temperature は 35 だけど、最初の if temperature >= 0: が先にTrueになってしまうので、本来表示したかった \"暑いです\" は実行されないんだ。「条件の順序ミスで意図しない分岐になる」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q386 = Question(
    id: 386,
    type: .fillInBlank,
    prompt: "次のコードのバグを\n直したい。\nelseブロックの行が\nインデントされていない。\n空欄に入るのは？",
    codeSnippet: "score = 40\nif score >= 60:\n    print(\"合格\")\nelse:\n_____print(\"不合格\")",
    choices: ["インデント（半角スペース4つなど）", "コロン", "セミコロン"],
    correctAnswer: "インデント（半角スペース4つなど）",
    explanation: "正解は インデント（半角スペース4つなど） だよ！else: の中の行も、if のブロックと同様にインデントが必要なんだ。インデントがないと IndentationError になってしまうよ。「ブロックの中は必ずインデント」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q387 = Question(
    id: 387,
    type: .codeOutput,
    prompt: "このコードを実行すると\n何が表示される？\n（==の代わりに=を\n使うとどうなるか）",
    codeSnippet: "score = 100\nif score == 100:\n    print(\"満点です\")\nelse:\n    print(\"満点ではありません\")",
    choices: ["満点です", "満点ではありません", "構文エラーになる"],
    correctAnswer: "満点です",
    explanation: "正解は 満点です だよ！この問題では正しく == が使われているので、score が 100 と一致して \"満点です\" が表示されるんだ。if score = 100: のように = を使うと構文エラーになってしまうので、== と = の違いを意識しておこう。「比較は==、代入は=」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q388 = Question(
    id: 388,
    type: .multipleChoice,
    prompt: "リストの中に\n特定の値が含まれているかを\n調べる演算子は？",
    codeSnippet: nil,
    choices: ["in", "==", "is"],
    correctAnswer: "in",
    explanation: "正解は in だよ！リストや文字列の中に指定した値が含まれているかを調べる演算子だったね。「含まれているか調べる＝in」と覚えておこう！（前のレッスン「条件分岐とリストを組み合わせよう」の復習だよ）",
    xpReward: 10,
    gemReward: 1
)

private let q389 = Question(
    id: 389,
    type: .codeOutput,
    prompt: "クーポン適用アプリで、\n割引条件の順序ミスを\n含むコードを実行すると\nどうなる？\n出力はどれ？",
    codeSnippet: "total_price = 12000\nif total_price >= 1000:\n    discount_rate = 0.05\nelif total_price >= 10000:\n    discount_rate = 0.20\nprint(\"割引率：\" + str(discount_rate))",
    choices: ["割引率：0.05", "割引率：0.2", "割引率：0"],
    correctAnswer: "割引率：0.05",
    explanation: "正解は 割引率：0.05 だよ！total_price は 12000 で本来は20%引きを期待しているけれど、最初の if total_price >= 1000: が先にTrueになってしまい、elif の20%引きは実行されないんだ。「条件は厳しい順（金額が大きい順）に並べる必要がある」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)


// ─────────────────────────────────────────────────────────
// MARK: - Lesson 39 · 条件分岐の総復習
// ─────────────────────────────────────────────────────────

private let lesson39 = Lesson(
    id: 39,
    title: "条件分岐の総復習",
    shortLabel: "総復習",
    subtitle: "コース3まとめ",
    category: "条件分岐",
    order: 39,
    questions: [q390, q391, q392, q393, q394, q395, q396, q397, q398, q399],
    requiredXP: 1950
)

private let q390 = Question(
    id: 390,
    type: .multipleChoice,
    prompt: "条件が True のときだけ\n処理を実行する文は？",
    codeSnippet: nil,
    choices: ["if文", "for文", "print文"],
    correctAnswer: "if文",
    explanation: "正解は if文 だよ！コース3の最初に学んだ、条件付きで処理を実行する基本の構文だったね。「条件付きの実行＝if文」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q391 = Question(
    id: 391,
    type: .multipleChoice,
    prompt: "if の条件が False のときに\n実行されるブロックを\n指定するキーワードは？",
    codeSnippet: nil,
    choices: ["else", "elif", "and"],
    correctAnswer: "else",
    explanation: "正解は else だよ！if の条件が成立しないときの処理をまとめるキーワードだったね。「条件が成立しない場合＝else」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q392 = Question(
    id: 392,
    type: .fillInBlank,
    prompt: "複数の条件を\n順番に確認したいときに\n使うキーワードは？",
    codeSnippet: "if score >= 90:\n    grade = \"A\"\n_____ score >= 70:\n    grade = \"B\"\nelse:\n    grade = \"C\"",
    choices: ["elif", "else if", "and"],
    correctAnswer: "elif",
    explanation: "正解は elif だよ！最初のifがFalseのときに、さらに別の条件を確認できるキーワードだったね。「追加の条件を確認＝elif」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q393 = Question(
    id: 393,
    type: .multipleChoice,
    prompt: "「会員で、かつ\n合計金額が3000円以上」\nのときだけ割引する\n条件式として正しいのは？",
    codeSnippet: nil,
    choices: ["is_member and total >= 3000", "is_member or total >= 3000", "is_member == total >= 3000"],
    correctAnswer: "is_member and total >= 3000",
    explanation: "正解は is_member and total >= 3000 だよ！両方の条件を満たす必要があるので and でつなぐんだったね。「両方とも満たす＝and」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q394 = Question(
    id: 394,
    type: .multipleChoice,
    prompt: "if のブロックの中に\nさらに別の if を書くことを\n何と呼ぶ？",
    codeSnippet: nil,
    choices: ["ネスト（入れ子）", "ループ", "リスト"],
    correctAnswer: "ネスト（入れ子）",
    explanation: "正解は ネスト（入れ子） だよ！外側の条件がTrueのときだけ、内側のifが確認されるんだったね。「ifの中のif＝ネスト」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q395 = Question(
    id: 395,
    type: .codeOutput,
    prompt: "このコードの出力は？",
    codeSnippet: "age_text = \"17\"\nage = int(age_text)\nif age >= 18:\n    print(\"成人です\")\nelse:\n    print(\"未成年です\")",
    choices: ["未成年です", "成人です", "17"],
    correctAnswer: "未成年です",
    explanation: "正解は 未成年です だよ！\"17\" を int() で整数の 17 に変換し、17 >= 18 は False なので else のブロックが実行されるんだ。「input()の値はint()で数値に変換して比較する」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q396 = Question(
    id: 396,
    type: .fillInBlank,
    prompt: "買い物リストに\n\"牛乳\"が含まれているかを\n調べたい。空欄に入るのは？",
    codeSnippet: "item_list = [\"パン\", \"牛乳\", \"卵\"]\nif \"牛乳\" _____ item_list:\n    print(\"牛乳はリストにあります\")",
    choices: ["in", "==", "is"],
    correctAnswer: "in",
    explanation: "正解は in だよ！リストの中に特定の値が含まれているかを調べる演算子だったね。「含まれているか調べる＝in」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q397 = Question(
    id: 397,
    type: .codeOutput,
    prompt: "このコードを実行すると\n何が表示される？\n（条件の順序ミスに注意）",
    codeSnippet: "score = 85\nif score >= 60:\n    print(\"合格\")\nelif score >= 80:\n    print(\"優秀な合格\")",
    choices: ["合格", "優秀な合格", "何も表示されない"],
    correctAnswer: "合格",
    explanation: "正解は 合格 だよ！score は 85 で \"優秀な合格\" を期待しているけれど、最初の if score >= 60: が先にTrueになるので \"合格\" が表示され、elif は実行されないんだ。「条件は厳しい順に並べる必要がある」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q398 = Question(
    id: 398,
    type: .multipleChoice,
    prompt: "次のコードのバグは\nどこにある？\nif user_age = 20:\n    print(\"20歳です\")",
    codeSnippet: nil,
    choices: ["= が == であるべき（代入と比較を混同している）", "20 が \"20\" であるべき", "if が while であるべき"],
    correctAnswer: "= が == であるべき（代入と比較を混同している）",
    explanation: "正解は = が == であるべき（代入と比較を混同している） だよ！比較したいのに代入の記号 = を使ってしまっているのが原因だったね。「比較は==、代入は=」と覚えておこう！（前のレッスン「条件分岐の落とし穴を読もう」の復習だよ）",
    xpReward: 10,
    gemReward: 1
)

private let q399 = Question(
    id: 399,
    type: .codeOutput,
    prompt: "健康診断アプリで、\nBMIの値に応じて\n判定メッセージを\n表示したい。出力はどれ？\n（bmiは22.5とする）",
    codeSnippet: "bmi = 22.5\nif bmi < 18.5:\n    result = \"低体重\"\nelif bmi < 25.0:\n    result = \"普通体重\"\nelif bmi < 30.0:\n    result = \"肥満（1度）\"\nelse:\n    result = \"肥満（2度以上）\"\nprint(\"判定：\" + result)",
    choices: ["判定：普通体重", "判定：低体重", "判定：肥満（1度）"],
    correctAnswer: "判定：普通体重",
    explanation: "正解は 判定：普通体重 だよ！bmi は 22.5 で、18.5未満ではないけれど25.0未満なので2番目のelifで \"普通体重\" になるんだ。「複数段階の判定＝条件の厳しい順（小さい順）にif, elif, elseを並べる」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)
