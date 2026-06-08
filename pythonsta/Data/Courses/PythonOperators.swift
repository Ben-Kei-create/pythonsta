//
//  PythonOperators.swift
//  pythonsta
//
//  Created by 茂木史明 on 2026/06/08.
//
//  Course: 演算子
//  Course ID: 2
//  Lesson ID range:   20–29  (10 lessons at full scale — COMPLETE)
//  Lesson order range: 20–29 (globally unique; drives unlock sequencing)
//  Question ID range: 200–299 (100 questions at full scale — COMPLETE)
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

enum PythonOperatorsCourse {
    static let course = Course(
        id: 2,
        title: "演算子",
        subtitle: "計算と判定の道具を身につけよう",
        lessons: [lesson20, lesson21, lesson22, lesson23, lesson24, lesson25, lesson26, lesson27, lesson28, lesson29]
    )
}


// ─────────────────────────────────────────────────────────
// MARK: - Lesson 20 · 算術演算子を使おう
// ─────────────────────────────────────────────────────────

private let lesson20 = Lesson(
    id: 20,
    title: "算術演算子を使おう",
    shortLabel: "算術演算子",
    subtitle: "+ - * /",
    category: "演算子",
    order: 20,
    questions: [q200, q201, q202, q203, q204, q205, q206, q207, q208, q209],
    requiredXP: 1000
)

private let q200 = Question(
    id: 200,
    type: .multipleChoice,
    prompt: "わり算の商を小数で\n返す演算子は？",
    codeSnippet: nil,
    choices: ["/", "//", "%"],
    correctAnswer: "/",
    explanation: "正解は / だよ！/ は割り算をして小数（float）の結果を返す演算子なんだ。10 / 3 は 3.333... になるよ。「小数のわり算＝/」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q201 = Question(
    id: 201,
    type: .multipleChoice,
    prompt: "わり算の商を整数部分だけ\n返す演算子は？",
    codeSnippet: nil,
    choices: ["//", "/", "%"],
    correctAnswer: "//",
    explanation: "正解は // だよ！// は割り算した結果の整数部分だけを返す演算子なんだ。10 // 3 は 3 になるよ。「整数部分だけのわり算＝//」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q202 = Question(
    id: 202,
    type: .fillInBlank,
    prompt: "べき乗（累乗）を計算する\n演算子は？",
    codeSnippet: "print(2 _____ 3)\n# 2の3乗 → 8",
    choices: ["**", "^", "*"],
    correctAnswer: "**",
    explanation: "正解は ** だよ！2 ** 3 は「2の3乗」を意味し、結果は 8 になるんだ。^ ではないので注意しよう。「べき乗＝**」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q203 = Question(
    id: 203,
    type: .multipleChoice,
    prompt: "商品の単価と個数から\n合計金額を求める計算として\n適切なのは？",
    codeSnippet: nil,
    choices: ["item_price * quantity", "item_price + quantity", "item_price // quantity"],
    correctAnswer: "item_price * quantity",
    explanation: "正解は item_price * quantity だよ！「単価 × 個数」で合計金額が求まるので、かけ算の * を使うのが自然なんだ。「合計金額＝単価×個数」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q204 = Question(
    id: 204,
    type: .multipleChoice,
    prompt: "ある数が偶数かどうかを\n調べる方法として適切なのは？",
    codeSnippet: nil,
    choices: ["score % 2 == 0", "score / 2 == 0", "score // 2 == 0"],
    correctAnswer: "score % 2 == 0",
    explanation: "正解は score % 2 == 0 だよ！% は割り算の余りを求める演算子で、2で割った余りが 0 なら偶数だと判定できるんだ。「余りを求める＝%、偶数判定＝余りが0」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q205 = Question(
    id: 205,
    type: .codeOutput,
    prompt: "このコードの出力は？",
    codeSnippet: "price = 1000\ndiscount = 300\ntotal = price - discount\nprint(total)",
    choices: ["700", "1300", "300000"],
    correctAnswer: "700",
    explanation: "正解は 700 だよ！- は引き算の演算子なので、1000 から 300 を引いた 700 が total に入るんだ。「割引後の金額＝価格－割引額」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q206 = Question(
    id: 206,
    type: .fillInBlank,
    prompt: "合計金額を人数で割って\n一人あたりの金額を求めたい。\n空欄に入るのは？",
    codeSnippet: "total = 3000\nmember_count = 4\nprice_per_person = total _____ member_count\nprint(price_per_person)",
    choices: ["/", "*", "%"],
    correctAnswer: "/",
    explanation: "正解は / だよ！「合計 ÷ 人数」で一人あたりの金額が求まるので、わり算の / を使うんだ。「一人あたりの金額＝合計÷人数」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q207 = Question(
    id: 207,
    type: .codeOutput,
    prompt: "このコードを実行すると\n何が表示される？",
    codeSnippet: "stock = 17\nbox_size = 5\nfull_boxes = stock // box_size\nremainder = stock % box_size\nprint(full_boxes, remainder)",
    choices: ["3 2", "3.4 2", "17 5"],
    correctAnswer: "3 2",
    explanation: "正解は 3 2 だよ！17 // 5 は「17個を5個ずつの箱に詰めたとき満杯になる箱の数」の 3、17 % 5 は「あまりの個数」の 2 になるんだ。「//＝箱の数、%＝あまり」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q208 = Question(
    id: 208,
    type: .multipleChoice,
    prompt: "0で割ったときに発生する\nエラーの名前は？",
    codeSnippet: nil,
    choices: ["ZeroDivisionError", "TypeError", "ValueError"],
    correctAnswer: "ZeroDivisionError",
    explanation: "正解は ZeroDivisionError だよ！数を 0 で割ろうとすると Python はこのエラーを出すんだったね。「ゼロ除算＝ZeroDivisionError」と覚えておこう！（コース0「エラーを読もう」の復習だよ）",
    xpReward: 10,
    gemReward: 1
)

private let q209 = Question(
    id: 209,
    type: .codeOutput,
    prompt: "レジアプリで、\n支払い金額からおつりの\n紙幣・硬貨の枚数を\n求めたい。出力はどれ？",
    codeSnippet: "payment = 1000\nprice = 380\nchange = payment - price\nbills_500 = change // 500\nrest = change % 500\nprint(bills_500, rest)",
    choices: ["1 120", "1.24 0", "620 0"],
    correctAnswer: "1 120",
    explanation: "正解は 1 120 だよ！おつり 620 円のうち、500円硬貨は 620 // 500 で 1枚、残りは 620 % 500 で 120円になるんだ。「割引後やお釣りの計算＝引き算と//・%の組み合わせ」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)


// ─────────────────────────────────────────────────────────
// MARK: - Lesson 21 · 比較演算子を使おう
// ─────────────────────────────────────────────────────────

private let lesson21 = Lesson(
    id: 21,
    title: "比較演算子を使おう",
    shortLabel: "比較演算子",
    subtitle: "== != < >",
    category: "演算子",
    order: 21,
    questions: [q210, q211, q212, q213, q214, q215, q216, q217, q218, q219],
    requiredXP: 1050
)

private let q210 = Question(
    id: 210,
    type: .multipleChoice,
    prompt: "2つの値が等しいかを\n調べる演算子は？",
    codeSnippet: nil,
    choices: ["==", "=", "!="],
    correctAnswer: "==",
    explanation: "正解は == だよ！== は「左右が等しいか」を調べて True か False を返す演算子なんだ。1つの = は代入なので意味が違うから注意しよう。「等しいか比べる＝==」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q211 = Question(
    id: 211,
    type: .multipleChoice,
    prompt: "2つの値が等しくないかを\n調べる演算子は？",
    codeSnippet: nil,
    choices: ["!=", "==", "<>"],
    correctAnswer: "!=",
    explanation: "正解は != だよ！!= は「左右が等しくないか」を調べる演算子なんだ。score != 0 は「scoreが0でなければTrue」になるよ。「等しくないか比べる＝!=」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q212 = Question(
    id: 212,
    type: .fillInBlank,
    prompt: "「以上」を表す\n比較演算子は？",
    codeSnippet: "is_adult = age _____ 20\nprint(is_adult)",
    choices: [">=", "=>", ">"],
    correctAnswer: ">=",
    explanation: "正解は >= だよ！>= は「左が右以上であれば True」になる演算子なんだ。順番を逆にした => はエラーになるので注意しよう。「以上＝>=」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q213 = Question(
    id: 213,
    type: .multipleChoice,
    prompt: "テストが合格ラインを\n超えたかを判定する式として\n適切なのは？",
    codeSnippet: nil,
    choices: ["score >= 60", "score = 60", "score >> 60"],
    correctAnswer: "score >= 60",
    explanation: "正解は score >= 60 だよ！「60点以上なら合格」を調べるには、比較演算子の >= を使って is_passed = score >= 60 のように書くんだ。「合格判定＝比較演算子で式を作る」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q214 = Question(
    id: 214,
    type: .multipleChoice,
    prompt: "20歳未満かどうかを\n判定する式として適切なのは？",
    codeSnippet: nil,
    choices: ["age < 20", "age > 20", "age <= 19.9"],
    correctAnswer: "age < 20",
    explanation: "正解は age < 20 だよ！「20歳未満」は「20より小さい」という意味なので、比較演算子の < を使うのが自然なんだ。「未満＝<」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q215 = Question(
    id: 215,
    type: .codeOutput,
    prompt: "このコードの出力は？",
    codeSnippet: "user_name = \"太郎\"\nis_taro = user_name == \"太郎\"\nprint(is_taro)",
    choices: ["True", "False", "太郎"],
    correctAnswer: "True",
    explanation: "正解は True だよ！user_name の中身 \"太郎\" と \"太郎\" が一致するので == の結果は True になるんだ。「文字列同士も==で比較できる」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q216 = Question(
    id: 216,
    type: .fillInBlank,
    prompt: "在庫が残っているかを\n調べたい。空欄に入るのは？",
    codeSnippet: "stock = 0\nis_in_stock = stock _____ 0\nprint(is_in_stock)",
    choices: [">", "<", "=="],
    correctAnswer: ">",
    explanation: "正解は > だよ！「在庫が0より多い＝在庫がある」という条件なので、比較演算子の > を使うんだ。「より大きい＝>」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q217 = Question(
    id: 217,
    type: .codeOutput,
    prompt: "このコードを実行すると\n何が表示される？",
    codeSnippet: "price_a = 1200\nprice_b = 980\nis_a_expensive = price_a > price_b\nprint(is_a_expensive)",
    choices: ["True", "False", "1200"],
    correctAnswer: "True",
    explanation: "正解は True だよ！1200 は 980 より大きいので、price_a > price_b の結果は True になるんだ。「比較式の結果は常にTrueかFalse」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q218 = Question(
    id: 218,
    type: .multipleChoice,
    prompt: "べき乗（累乗）を計算する\n演算子は？",
    codeSnippet: nil,
    choices: ["**", "^", "//"],
    correctAnswer: "**",
    explanation: "正解は ** だよ！2 ** 3 のように書いて累乗を計算する演算子だったね。「べき乗＝**」と覚えておこう！（前のレッスン「算術演算子を使おう」の復習だよ）",
    xpReward: 10,
    gemReward: 1
)

private let q219 = Question(
    id: 219,
    type: .codeOutput,
    prompt: "在庫管理アプリで、\n商品が残っているかを\n判定して表示したい。\n出力はどれ？",
    codeSnippet: "item_name = \"ノート\"\nstock = 3\nis_in_stock = stock > 0\nif is_in_stock:\n    print(item_name + \"は在庫があります\")\nelse:\n    print(item_name + \"は在庫切れです\")",
    choices: ["ノートは在庫があります", "ノートは在庫切れです", "True"],
    correctAnswer: "ノートは在庫があります",
    explanation: "正解は ノートは在庫があります だよ！stock が 3 で 3 > 0 は True なので、is_in_stock が True になり if のブロックが実行されるんだ。「在庫の有無を判定＝比較演算子で式を作りif分岐に使う」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)


// ─────────────────────────────────────────────────────────
// MARK: - Lesson 22 · 論理演算子を使おう
// ─────────────────────────────────────────────────────────

private let lesson22 = Lesson(
    id: 22,
    title: "論理演算子を使おう",
    shortLabel: "論理演算子",
    subtitle: "and / or / not",
    category: "演算子",
    order: 22,
    questions: [q220, q221, q222, q223, q224, q225, q226, q227, q228, q229],
    requiredXP: 1100
)

private let q220 = Question(
    id: 220,
    type: .multipleChoice,
    prompt: "2つの条件が\n両方とも True のときだけ\nTrue になる演算子は？",
    codeSnippet: nil,
    choices: ["and", "or", "not"],
    correctAnswer: "and",
    explanation: "正解は and だよ！and は左右の条件が両方とも True のときだけ全体が True になる演算子なんだ。「両方とも満たす＝and」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q221 = Question(
    id: 221,
    type: .multipleChoice,
    prompt: "2つの条件の\nどちらか一方でも True なら\nTrue になる演算子は？",
    codeSnippet: nil,
    choices: ["or", "and", "not"],
    correctAnswer: "or",
    explanation: "正解は or だよ！or は左右どちらか一方でも True であれば全体が True になる演算子なんだ。「どちらかを満たす＝or」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q222 = Question(
    id: 222,
    type: .fillInBlank,
    prompt: "条件を反転させる演算子は？",
    codeSnippet: "is_minor = _____ is_adult\nprint(is_minor)",
    choices: ["not", "no", "!"],
    correctAnswer: "not",
    explanation: "正解は not だよ！not は True と False を入れ替える演算子で、not True は False、not False は True になるんだ。「反転させる＝not」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q223 = Question(
    id: 223,
    type: .multipleChoice,
    prompt: "「18歳以上で、\nかつチケットを持っている人」\nだけが入場できる条件として\n適切なのは？",
    codeSnippet: nil,
    choices: ["age >= 18 and has_ticket", "age >= 18 or has_ticket", "not age >= 18"],
    correctAnswer: "age >= 18 and has_ticket",
    explanation: "正解は age >= 18 and has_ticket だよ！「両方の条件を満たす」必要があるので and を使うのが正解なんだ。「すべて満たす必要がある＝and」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q224 = Question(
    id: 224,
    type: .multipleChoice,
    prompt: "「会員である、または\n合計金額が5000円以上」\nのどちらかで割引になる条件\nとして適切なのは？",
    codeSnippet: nil,
    choices: ["is_member or total >= 5000", "is_member and total >= 5000", "not is_member"],
    correctAnswer: "is_member or total >= 5000",
    explanation: "正解は is_member or total >= 5000 だよ！「どちらか一方を満たせばよい」という条件なので or を使うのが正解なんだ。「いずれか満たせばよい＝or」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q225 = Question(
    id: 225,
    type: .codeOutput,
    prompt: "このコードの出力は？",
    codeSnippet: "has_id = True\nis_adult = False\ncan_enter = has_id and is_adult\nprint(can_enter)",
    choices: ["False", "True", "エラーになる"],
    correctAnswer: "False",
    explanation: "正解は False だよ！and は両方とも True のときだけ True になるけれど、is_adult が False なので can_enter は False になるんだ。「andは片方でもFalseなら全体がFalse」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q226 = Question(
    id: 226,
    type: .fillInBlank,
    prompt: "「会員でない人」を\n判定したい。空欄に入るのは？",
    codeSnippet: "is_member = False\nis_not_member = _____ is_member\nprint(is_not_member)",
    choices: ["not", "and", "or"],
    correctAnswer: "not",
    explanation: "正解は not だよ！not is_member と書くと is_member の値を反転させられるんだ。is_member が False なら not is_member は True になるよ。「反転させる＝not」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q227 = Question(
    id: 227,
    type: .codeOutput,
    prompt: "このコードを実行すると\n何が表示される？",
    codeSnippet: "has_coupon = False\nis_member = True\ncan_get_discount = has_coupon or is_member\nprint(can_get_discount)",
    choices: ["True", "False", "None"],
    correctAnswer: "True",
    explanation: "正解は True だよ！or は片方でも True であれば全体が True になり、is_member が True なので can_get_discount は True になるんだ。「orは片方でもTrueなら全体がTrue」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q228 = Question(
    id: 228,
    type: .multipleChoice,
    prompt: "「20歳未満かどうか」を\n判定する式として適切なのは？",
    codeSnippet: nil,
    choices: ["age < 20", "age > 20", "age == 20"],
    correctAnswer: "age < 20",
    explanation: "正解は age < 20 だよ！「未満」は「より小さい」という意味なので比較演算子の < を使うんだったね。「未満＝<」と覚えておこう！（前のレッスン「比較演算子を使おう」の復習だよ）",
    xpReward: 10,
    gemReward: 1
)

private let q229 = Question(
    id: 229,
    type: .codeOutput,
    prompt: "ログイン機能で、\nユーザー名とパスワードの\n両方が正しいかを\n確認したい。出力はどれ？",
    codeSnippet: "user_name = \"taro\"\npassword = \"abc123\"\nis_name_ok = user_name == \"taro\"\nis_password_ok = password == \"abc123\"\ncan_login = is_name_ok and is_password_ok\nprint(can_login)",
    choices: ["True", "False", "taro abc123"],
    correctAnswer: "True",
    explanation: "正解は True だよ！ユーザー名とパスワードの両方の比較結果が True なので、and でつないだ can_login も True になるんだ。「複数の条件をすべて満たすか確認＝andでつなぐ」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)


// ─────────────────────────────────────────────────────────
// MARK: - Lesson 23 · 代入演算子を使おう
// ─────────────────────────────────────────────────────────

private let lesson23 = Lesson(
    id: 23,
    title: "代入演算子を使おう",
    shortLabel: "代入演算子",
    subtitle: "+= -= *=",
    category: "演算子",
    order: 23,
    questions: [q230, q231, q232, q233, q234, q235, q236, q237, q238, q239],
    requiredXP: 1150
)

private let q230 = Question(
    id: 230,
    type: .multipleChoice,
    prompt: "total = total + 100 と\n同じ意味になる書き方は？",
    codeSnippet: nil,
    choices: ["total += 100", "total =+ 100", "total ++ 100"],
    correctAnswer: "total += 100",
    explanation: "正解は total += 100 だよ！+= は「左の変数に右の値を足して、また左の変数に代入する」という意味の短縮した書き方なんだ。「+= ＝足してから代入」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q231 = Question(
    id: 231,
    type: .multipleChoice,
    prompt: "score -= 10 を\n実行すると、score の値は\nどうなる？",
    codeSnippet: nil,
    choices: ["10 だけ減る", "10 だけ増える", "10 倍になる"],
    correctAnswer: "10 だけ減る",
    explanation: "正解は 10 だけ減る だよ！-= は「左の変数から右の値を引いて、また左の変数に代入する」という意味なんだ。score -= 10 は score = score - 10 と同じだよ。「-= ＝引いてから代入」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q232 = Question(
    id: 232,
    type: .fillInBlank,
    prompt: "値を2倍にして代入する\n演算子は？",
    codeSnippet: "price _____ 2\nprint(price)",
    choices: ["*=", "**=", "+="],
    correctAnswer: "*=",
    explanation: "正解は *= だよ！*= は「左の変数に右の値をかけて、また左の変数に代入する」という意味なんだ。price *= 2 は price = price * 2 と同じだよ。「*= ＝かけてから代入」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q233 = Question(
    id: 233,
    type: .multipleChoice,
    prompt: "買い物かごに商品を\n追加するたびに合計金額を\n増やしていく処理として\n適切なのは？",
    codeSnippet: nil,
    choices: ["total += item_price", "total == item_price", "total -= item_price"],
    correctAnswer: "total += item_price",
    explanation: "正解は total += item_price だよ！商品を追加するたびに合計に値段を足していくので、+= を使って累計するのが自然な書き方なんだ。「累計を増やす＝+=」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q234 = Question(
    id: 234,
    type: .multipleChoice,
    prompt: "テストで間違えるたびに\nスコアを減らしていく処理\\として適切なのは？",
    codeSnippet: nil,
    choices: ["score -= penalty", "score += penalty", "score *= penalty"],
    correctAnswer: "score -= penalty",
    explanation: "正解は score -= penalty だよ！間違えるたびに減点したい場合は、現在のスコアから罰点を引いて代入する -= を使うのが自然なんだ。「累計を減らす＝-=」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q235 = Question(
    id: 235,
    type: .codeOutput,
    prompt: "このコードの出力は？",
    codeSnippet: "total = 0\ntotal += 300\ntotal += 450\nprint(total)",
    choices: ["750", "300450", "450"],
    correctAnswer: "750",
    explanation: "正解は 750 だよ！total に 0 から 300 を足して 300、さらに 450 を足して 750 になるんだ。「+=を繰り返す＝値を積み上げていく」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q236 = Question(
    id: 236,
    type: .fillInBlank,
    prompt: "ポイントを2倍にする\nキャンペーン中の処理として\n空欄に入るのは？",
    codeSnippet: "points = 150\npoints _____ 2\nprint(points)",
    choices: ["*=", "+=", "-="],
    correctAnswer: "*=",
    explanation: "正解は *= だよ！現在のポイントを2倍にして代入したいので *= を使うんだ。points *= 2 で 150 が 300 になるよ。「2倍にする＝*=」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q237 = Question(
    id: 237,
    type: .codeOutput,
    prompt: "このコードを実行すると\n何が表示される？",
    codeSnippet: "stock = 20\nstock -= 3\nstock -= 5\nprint(stock)",
    choices: ["12", "20", "-8"],
    correctAnswer: "12",
    explanation: "正解は 12 だよ！在庫 20 から 3 個、さらに 5 個減って 20 - 3 - 5 で 12 になるんだ。「-=を繰り返す＝値を減らしていく」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q238 = Question(
    id: 238,
    type: .multipleChoice,
    prompt: "2つの条件が\n両方とも True のときだけ\nTrue になる演算子は？",
    codeSnippet: nil,
    choices: ["and", "or", "not"],
    correctAnswer: "and",
    explanation: "正解は and だよ！両方とも True のときだけ全体が True になる演算子だったね。「両方とも満たす＝and」と覚えておこう！（前のレッスン「論理演算子を使おう」の復習だよ）",
    xpReward: 10,
    gemReward: 1
)

private let q239 = Question(
    id: 239,
    type: .codeOutput,
    prompt: "ショッピングアプリで、\nかごに入れた商品の合計金額を\n計算して表示したい。\n出力はどれ？",
    codeSnippet: "total = 0\ntotal += 480\ntotal += 1200\ntotal += 350\nprint(\"合計：\" + str(total) + \"円\")",
    choices: ["合計：2030円", "合計：4801200350円", "エラーになる"],
    correctAnswer: "合計：2030円",
    explanation: "正解は 合計：2030円 だよ！0 から始めて 480、1200、350 を順番に += で足していくと合計は 2030 になるんだ。「商品を追加するたびに合計を更新する＝+=で累計する」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)


// ─────────────────────────────────────────────────────────
// MARK: - Lesson 24 · 演算子の優先順位を理解しよう
// ─────────────────────────────────────────────────────────

private let lesson24 = Lesson(
    id: 24,
    title: "演算子の優先順位を理解しよう",
    shortLabel: "優先順位",
    subtitle: "() の活用",
    category: "演算子",
    order: 24,
    questions: [q240, q241, q242, q243, q244, q245, q246, q247, q248, q249],
    requiredXP: 1200
)

private let q240 = Question(
    id: 240,
    type: .multipleChoice,
    prompt: "次のうち、計算が\n先に行われるのはどっち？\n2 + 3 * 4",
    codeSnippet: nil,
    choices: ["3 * 4 が先（かけ算が先）", "2 + 3 が先（左から順に）", "どちらが先でも結果は同じ"],
    correctAnswer: "3 * 4 が先（かけ算が先）",
    explanation: "正解は 3 * 4 が先（かけ算が先） だよ！Pythonでは * や / は + や - より優先順位が高く、先に計算されるんだ。2 + 3 * 4 は 2 + 12 で 14 になるよ。「かけ算・わり算は足し算・引き算より先」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q241 = Question(
    id: 241,
    type: .multipleChoice,
    prompt: "計算の順番を\n自分で指定したいときに\n使う記号は？",
    codeSnippet: nil,
    choices: ["( )（丸かっこ）", "[ ]（角かっこ）", "{ }（波かっこ）"],
    correctAnswer: "( )（丸かっこ）",
    explanation: "正解は ( )（丸かっこ） だよ！(2 + 3) * 4 のように丸かっこで囲むと、その部分を先に計算させることができるんだ。「計算の順番を指定＝丸かっこ」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q242 = Question(
    id: 242,
    type: .fillInBlank,
    prompt: "先に足し算をしてから\nかけ算をしたい。\n空欄に入るのは？",
    codeSnippet: "result = _____(2 + 3)_____ * 4\nprint(result)\n# 20 にしたい",
    choices: ["(", ")", "[]"],
    correctAnswer: "(",
    explanation: "正解は ( だよ！(2 + 3) * 4 のように丸かっこで囲むと、先に 2 + 3 が計算されて 5 になり、5 * 4 で 20 になるんだ。「先に計算したい部分＝丸かっこで囲む」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q243 = Question(
    id: 243,
    type: .multipleChoice,
    prompt: "商品の合計金額に\n消費税（10%）を加えた\n支払い金額を求める式として\n正しいのは？",
    codeSnippet: nil,
    choices: ["total_price * (1 + 0.1)", "total_price * 1 + 0.1", "total_price + 1 * 0.1"],
    correctAnswer: "total_price * (1 + 0.1)",
    explanation: "正解は total_price * (1 + 0.1) だよ！「税込み＝合計金額 × (1 + 税率)」という計算をしたいので、丸かっこで先に 1 + 0.1 を計算させる必要があるんだ。「税込み計算＝丸かっこで税率の式をまとめる」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q244 = Question(
    id: 244,
    type: .multipleChoice,
    prompt: "3教科の点数の合計を\n3で割って平均点を求める式\nとして正しいのは？",
    codeSnippet: nil,
    choices: ["(score_1 + score_2 + score_3) / 3", "score_1 + score_2 + score_3 / 3", "score_1 + (score_2 + score_3) / 3"],
    correctAnswer: "(score_1 + score_2 + score_3) / 3",
    explanation: "正解は (score_1 + score_2 + score_3) / 3 だよ！平均点は「合計を人数（科目数）で割る」ので、先に3科目の合計を丸かっこでまとめてから割る必要があるんだ。「平均＝(合計)÷個数」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q245 = Question(
    id: 245,
    type: .codeOutput,
    prompt: "このコードの出力は？",
    codeSnippet: "result = 2 + 3 * 4\nprint(result)",
    choices: ["14", "20", "9"],
    correctAnswer: "14",
    explanation: "正解は 14 だよ！* はかけ算が先に計算されるので 3 * 4 が先に 12 になり、2 + 12 で 14 になるんだ。「演算子の優先順位＝かけ算・わり算が先」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q246 = Question(
    id: 246,
    type: .fillInBlank,
    prompt: "先にかっこの中を計算させて\n結果を 20 にしたい。\n空欄に入るのは？",
    codeSnippet: "result = (2 _____ 3) * 4\nprint(result)\n# 20 にしたい",
    choices: ["+", "*", "-"],
    correctAnswer: "+",
    explanation: "正解は + だよ！(2 + 3) * 4 とすると、先に 2 + 3 が計算されて 5 になり、5 * 4 で 20 になるんだ。「丸かっこの中が最優先で計算される」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q247 = Question(
    id: 247,
    type: .codeOutput,
    prompt: "このコードを実行すると\n何が表示される？",
    codeSnippet: "item_price = 800\ntax_rate = 0.1\ntotal = item_price * (1 + tax_rate)\nprint(total)",
    choices: ["880.0", "80.800000000000004", "808.0"],
    correctAnswer: "880.0",
    explanation: "正解は 880.0 だよ！丸かっこの中の 1 + 0.1 が先に計算されて 1.1 になり、800 * 1.1 で 880.0 になるんだ。「税込み価格＝単価×(1＋税率)」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q248 = Question(
    id: 248,
    type: .multipleChoice,
    prompt: "total = total + 100 と\n同じ意味になる書き方は？",
    codeSnippet: nil,
    choices: ["total += 100", "total == 100", "total =+ 100"],
    correctAnswer: "total += 100",
    explanation: "正解は total += 100 だよ！「足してから代入する」を短く書ける代入演算子だったね。「+= ＝足してから代入」と覚えておこう！（前のレッスン「代入演算子を使おう」の復習だよ）",
    xpReward: 10,
    gemReward: 1
)

private let q249 = Question(
    id: 249,
    type: .codeOutput,
    prompt: "セール価格を計算したい。\n「合計金額から割引額を引き、\nさらに送料を足す」処理の\n出力はどれ？",
    codeSnippet: "total_price = 3000\ndiscount = 500\nshipping_fee = 300\nfinal_price = (total_price - discount) + shipping_fee\nprint(\"支払い金額：\" + str(final_price) + \"円\")",
    choices: ["支払い金額：2800円", "支払い金額：2200円", "支払い金額：3800円"],
    correctAnswer: "支払い金額：2800円",
    explanation: "正解は 支払い金額：2800円 だよ！丸かっこで「合計金額－割引額」を先にまとめて 2500 にし、それに送料 300 を足すことで 2800 になるんだ。「複数の計算を組み合わせるときは丸かっこで順番を明確にする」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)


// ─────────────────────────────────────────────────────────
// MARK: - Lesson 25 · 文字列の演算子を使おう
// ─────────────────────────────────────────────────────────

private let lesson25 = Lesson(
    id: 25,
    title: "文字列の演算子を使おう",
    shortLabel: "文字列演算子",
    subtitle: "+ * in",
    category: "演算子",
    order: 25,
    questions: [q250, q251, q252, q253, q254, q255, q256, q257, q258, q259],
    requiredXP: 1250
)

private let q250 = Question(
    id: 250,
    type: .multipleChoice,
    prompt: "文字列同士をつなげる\n演算子は？",
    codeSnippet: nil,
    choices: ["+", "-", "&"],
    correctAnswer: "+",
    explanation: "正解は + だよ！\"こんにちは\" + \"！\" のように、文字列同士は + でつなげることができるんだったね。「文字列の結合＝+」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q251 = Question(
    id: 251,
    type: .multipleChoice,
    prompt: "\"-\" * 5 を実行すると\n結果はどうなる？",
    codeSnippet: nil,
    choices: ["\"-----\"（- が5回繰り返される）", "-5（マイナス5という数値になる）", "エラーになる"],
    correctAnswer: "\"-----\"（- が5回繰り返される）",
    explanation: "正解は \"-----\"（- が5回繰り返される） だよ！文字列に対して * で数をかけると、その文字列を指定した回数だけ繰り返した新しい文字列ができるんだ。「文字列×数＝繰り返し」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q252 = Question(
    id: 252,
    type: .fillInBlank,
    prompt: "文字列の中に特定の文字が\n含まれるか調べる演算子は？",
    codeSnippet: "has_at = \"@\" _____ email\nprint(has_at)",
    choices: ["in", "==", "+"],
    correctAnswer: "in",
    explanation: "正解は in だよ！\"@\" in email のように書くと、email の中に \"@\" が含まれているかを調べられるんだ。「含まれているか確認＝in」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q253 = Question(
    id: 253,
    type: .multipleChoice,
    prompt: "メールアドレスの形式が\n正しそうかを簡易的に\n確認する方法として適切なのは？",
    codeSnippet: nil,
    choices: ["\"@\" in email", "\"@\" + email", "\"@\" * email"],
    correctAnswer: "\"@\" in email",
    explanation: "正解は \"@\" in email だよ！in 演算子を使うと、文字列の中に \"@\" が含まれているかを調べて True / False で結果を得られるんだ。「文字が含まれているか調べる＝in」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q254 = Question(
    id: 254,
    type: .multipleChoice,
    prompt: "ユーザー名を使って\n挨拶メッセージを\n組み立てる式として適切なのは？",
    codeSnippet: nil,
    choices: ["\"こんにちは、\" + user_name + \"さん\"", "\"こんにちは、\" * user_name", "\"こんにちは、\" in user_name"],
    correctAnswer: "\"こんにちは、\" + user_name + \"さん\"",
    explanation: "正解は \"こんにちは、\" + user_name + \"さん\" だよ！複数の文字列を順番につなげてメッセージを組み立てたいときは + を使うのが基本なんだ。「文章の組み立て＝+でつなげる」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q255 = Question(
    id: 255,
    type: .codeOutput,
    prompt: "このコードの出力は？",
    codeSnippet: "line = \"=\" * 10\nprint(line)",
    choices: ["==========", "=10", "エラーになる"],
    correctAnswer: "==========",
    explanation: "正解は ========== だよ！\"=\" * 10 は \"=\" を10回繰り返した文字列になるので、= が10個並んだ \"==========\" が表示されるんだ。「文字列×数＝同じ文字の繰り返し」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q256 = Question(
    id: 256,
    type: .fillInBlank,
    prompt: "ユーザー名がメッセージに\n含まれているかを調べたい。\n空欄に入るのは？",
    codeSnippet: "message = \"花子さん、こんにちは\"\nis_mentioned = user_name _____ message\nprint(is_mentioned)",
    choices: ["in", "==", "is"],
    correctAnswer: "in",
    explanation: "正解は in だよ！user_name in message と書くと、message の中に user_name の文字列が含まれているかを調べられるんだ。「含まれるか調べる＝in」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q257 = Question(
    id: 257,
    type: .codeOutput,
    prompt: "このコードを実行すると\n何が表示される？",
    codeSnippet: "user_name = \"陽子\"\ngreeting = \"ようこそ、\" + user_name + \"さん！\"\nseparator = \"-\" * len(greeting)\nprint(greeting)\nprint(separator)",
    choices: ["ようこそ、陽子さん！\n----------------", "ようこそ、陽子さん！\nlen(greeting)", "エラーになる"],
    correctAnswer: "ようこそ、陽子さん！\n----------------",
    explanation: "正解は ようこそ、陽子さん！ / ---------------- だよ！1行目は文字列の結合でメッセージを作り、2行目は \"-\" を greeting の文字数だけ繰り返して同じ長さの区切り線を作っているんだ。「文字列演算子を組み合わせる＝表示を整える」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q258 = Question(
    id: 258,
    type: .multipleChoice,
    prompt: "次のうち、計算が\n先に行われるのはどっち？\n2 + 3 * 4",
    codeSnippet: nil,
    choices: ["3 * 4 が先（かけ算が先）", "2 + 3 が先（左から順に）", "どちらが先でも結果は同じ"],
    correctAnswer: "3 * 4 が先（かけ算が先）",
    explanation: "正解は 3 * 4 が先（かけ算が先） だよ！かけ算は足し算より優先順位が高く先に計算されるんだったね。「かけ算・わり算は足し算・引き算より先」と覚えておこう！（前のレッスン「演算子の優先順位を理解しよう」の復習だよ）",
    xpReward: 10,
    gemReward: 1
)

private let q259 = Question(
    id: 259,
    type: .codeOutput,
    prompt: "レシートアプリで、\n商品名と区切り線を使って\n見やすいレシートの一部を\n作りたい。出力はどれ？",
    codeSnippet: "item_name = \"コーヒー\"\nprice = 480\nline = item_name + \" ... \" + str(price) + \"円\"\nborder = \"-\" * 16\nprint(border)\nprint(line)\nprint(border)",
    choices: ["----------------\nコーヒー ... 480円\n----------------", "コーヒー ... 480円\n----------------\n----------------", "エラーになる"],
    correctAnswer: "----------------\nコーヒー ... 480円\n----------------",
    explanation: "正解は ---------------- / コーヒー ... 480円 / ---------------- だよ！\"-\" * 16 で区切り線を作り、商品名と価格を + でつなげた行をその間にはさんで表示しているんだ。「区切り線つきの表示＝文字列の結合(+)と繰り返し(*)を組み合わせる」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)


// ─────────────────────────────────────────────────────────
// MARK: - Lesson 26 · リストの演算子を使おう
// ─────────────────────────────────────────────────────────

private let lesson26 = Lesson(
    id: 26,
    title: "リストの演算子を使おう",
    shortLabel: "リスト演算子",
    subtitle: "+ * in",
    category: "演算子",
    order: 26,
    questions: [q260, q261, q262, q263, q264, q265, q266, q267, q268, q269],
    requiredXP: 1300
)

private let q260 = Question(
    id: 260,
    type: .multipleChoice,
    prompt: "2つのリストを\nつなげる演算子は？",
    codeSnippet: nil,
    choices: ["+", "&", "and"],
    correctAnswer: "+",
    explanation: "正解は + だよ！[1, 2] + [3, 4] のように書くと、2つのリストをつなげた新しいリスト [1, 2, 3, 4] ができるんだ。「リストの結合＝+」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q261 = Question(
    id: 261,
    type: .multipleChoice,
    prompt: "[0] * 3 を実行すると\n結果はどうなる？",
    codeSnippet: nil,
    choices: ["[0, 0, 0]（0が3つ並んだリスト）", "[0, 3]（0と3のリスト）", "0（数値の0になる）"],
    correctAnswer: "[0, 0, 0]（0が3つ並んだリスト）",
    explanation: "正解は [0, 0, 0]（0が3つ並んだリスト） だよ！リストに対して * で数をかけると、そのリストを指定回数だけ繰り返してつなげた新しいリストができるんだ。「リスト×数＝繰り返し」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q262 = Question(
    id: 262,
    type: .fillInBlank,
    prompt: "リストの中に特定の値が\n含まれているか調べる演算子は？",
    codeSnippet: "has_apple = \"りんご\" _____ item_list\nprint(has_apple)",
    choices: ["in", "==", "+"],
    correctAnswer: "in",
    explanation: "正解は in だよ！\"りんご\" in item_list のように書くと、item_list の中に \"りんご\" が含まれているかを調べられるんだ。「リスト内に値があるか確認＝in」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q263 = Question(
    id: 263,
    type: .multipleChoice,
    prompt: "2つの買い物リストを\n1つにまとめる処理として\n適切なのは？",
    codeSnippet: nil,
    choices: ["item_list + extra_list", "item_list * extra_list", "item_list == extra_list"],
    correctAnswer: "item_list + extra_list",
    explanation: "正解は item_list + extra_list だよ！2つのリストをまとめて1つのリストにしたいときは + を使うのが基本なんだ。「複数のリストをまとめる＝+で結合」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q264 = Question(
    id: 264,
    type: .multipleChoice,
    prompt: "買い物リストに特定の商品\n（例：\"牛乳\"）が入っているかを\n調べる式として適切なのは？",
    codeSnippet: nil,
    choices: ["\"牛乳\" in item_list", "\"牛乳\" == item_list", "\"牛乳\" * item_list"],
    correctAnswer: "\"牛乳\" in item_list",
    explanation: "正解は \"牛乳\" in item_list だよ！in 演算子を使うと、リストの中に指定した値が含まれているかを True / False で調べられるんだ。「リストの中身を確認＝in」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q265 = Question(
    id: 265,
    type: .codeOutput,
    prompt: "このコードの出力は？",
    codeSnippet: "morning_list = [\"パン\", \"牛乳\"]\nevening_list = [\"卵\", \"野菜\"]\nfull_list = morning_list + evening_list\nprint(full_list)",
    choices: ["['パン', '牛乳', '卵', '野菜']", "['パン', '牛乳']['卵', '野菜']", "エラーになる"],
    correctAnswer: "['パン', '牛乳', '卵', '野菜']",
    explanation: "正解は ['パン', '牛乳', '卵', '野菜'] だよ！+ で2つのリストをつなげると、すべての要素を順番に含んだ1つの新しいリストができるんだ。「リスト＋リスト＝要素を全部つなげた新しいリスト」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q266 = Question(
    id: 266,
    type: .fillInBlank,
    prompt: "希望商品のリストの中に\n探している商品があるかを\n調べたい。空欄に入るのは？",
    codeSnippet: "wish_list = [\"ノート\", \"消しゴム\", \"鉛筆\"]\nis_wished = item_name _____ wish_list\nprint(is_wished)",
    choices: ["in", "is", "=="],
    correctAnswer: "in",
    explanation: "正解は in だよ！item_name in wish_list と書くと、wish_list の中に item_name と同じ値が含まれているかを調べられるんだ。「含まれるか調べる＝in」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q267 = Question(
    id: 267,
    type: .codeOutput,
    prompt: "このコードを実行すると\n何が表示される？",
    codeSnippet: "score_list = [80, 90]\nrepeated = score_list * 2\nprint(repeated)\nprint(len(repeated))",
    choices: ["[80, 90, 80, 90]\n4", "[160, 180]\n2", "[80, 90]\n2"],
    correctAnswer: "[80, 90, 80, 90]\n4",
    explanation: "正解は [80, 90, 80, 90] / 4 だよ！リストに * で数をかけると、リストの中身そのものが繰り返されるんだ（要素同士がかけ算されるわけではないよ）。len() で数えると要素数は 4 になるね。「リスト×数＝中身を繰り返す」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q268 = Question(
    id: 268,
    type: .multipleChoice,
    prompt: "文字列の中に特定の文字が\n含まれるか調べる演算子は？",
    codeSnippet: nil,
    choices: ["in", "==", "+"],
    correctAnswer: "in",
    explanation: "正解は in だよ！\"@\" in email のように、文字列の中に特定の文字が含まれているか調べる演算子だったね。「含まれているか確認＝in」と覚えておこう！（前のレッスン「文字列の演算子を使おう」の復習だよ）",
    xpReward: 10,
    gemReward: 1
)

private let q269 = Question(
    id: 269,
    type: .codeOutput,
    prompt: "献立アプリで、\n午前と午後の買い物リストを\n結合して全体のリストを\n表示したい。出力はどれ？",
    codeSnippet: "morning_list = [\"パン\", \"卵\"]\nafternoon_list = [\"野菜\", \"肉\", \"魚\"]\nfull_list = morning_list + afternoon_list\nprint(\"買い物リスト：\" + str(full_list))\nprint(\"合計\" + str(len(full_list)) + \"点\")",
    choices: ["買い物リスト：['パン', '卵', '野菜', '肉', '魚']\n合計5点", "買い物リスト：['パン', '卵']['野菜', '肉', '魚']\n合計2点", "エラーになる"],
    correctAnswer: "買い物リスト：['パン', '卵', '野菜', '肉', '魚']\n合計5点",
    explanation: "正解は 買い物リスト：['パン', '卵', '野菜', '肉', '魚'] / 合計5点 だよ！+ で2つのリストを結合し、len() で要素数を数えて表示しているんだ。「複数のリストをまとめて件数を数える＝+で結合してlen()で数える」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)


// ─────────────────────────────────────────────────────────
// MARK: - Lesson 27 · 複合条件を組み立てよう
// ─────────────────────────────────────────────────────────

private let lesson27 = Lesson(
    id: 27,
    title: "複合条件を組み立てよう",
    shortLabel: "複合条件",
    subtitle: "比較＋論理演算子",
    category: "演算子",
    order: 27,
    questions: [q270, q271, q272, q273, q274, q275, q276, q277, q278, q279],
    requiredXP: 1350
)

private let q270 = Question(
    id: 270,
    type: .multipleChoice,
    prompt: "「点数が80点以上で、\nかつ出席率が90%以上」\nという条件を組み立てる\n演算子は？",
    codeSnippet: nil,
    choices: ["and（両方とも満たす必要がある）", "or（どちらか一方でよい）", "not（条件を反転させる）"],
    correctAnswer: "and（両方とも満たす必要がある）",
    explanation: "正解は and（両方とも満たす必要がある） だよ！「～で、かつ～」という条件は、両方を満たす必要があるので and で2つの比較式をつなぐんだ。「両方とも満たす＝and」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q271 = Question(
    id: 271,
    type: .multipleChoice,
    prompt: "「会員である、または\n誕生日月である」という\n条件を組み立てる演算子は？",
    codeSnippet: nil,
    choices: ["or（どちらか一方でよい）", "and（両方とも満たす必要がある）", "not（条件を反転させる）"],
    correctAnswer: "or（どちらか一方でよい）",
    explanation: "正解は or（どちらか一方でよい） だよ！「～、または～」という条件は、どちらか一方を満たせばよいので or で比較式をつなぐんだ。「いずれか満たせばよい＝or」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q272 = Question(
    id: 272,
    type: .fillInBlank,
    prompt: "「18歳以上で、\nかつ身分証を持っている」\n条件を組み立てたい。\n空欄に入るのは？",
    codeSnippet: "is_eligible = (age >= 18) _____ has_id\nprint(is_eligible)",
    choices: ["and", "or", "not"],
    correctAnswer: "and",
    explanation: "正解は and だよ！「年齢の条件」と「身分証の条件」の両方を満たす必要があるので and でつなぐんだ。「すべての条件を満たす必要がある＝and」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q273 = Question(
    id: 273,
    type: .multipleChoice,
    prompt: "「16歳以上で、\nかつ保護者の同意がある」\n人だけ申し込める条件として\n適切なのは？",
    codeSnippet: nil,
    choices: ["age >= 16 and has_consent", "age >= 16 or has_consent", "not (age >= 16)"],
    correctAnswer: "age >= 16 and has_consent",
    explanation: "正解は age >= 16 and has_consent だよ！「年齢の条件」と「同意の条件」を両方満たす必要があるので and でつなぐのが正しいんだ。「2つの条件を両方満たす＝and」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q274 = Question(
    id: 274,
    type: .multipleChoice,
    prompt: "「会員である、または\n購入金額が5000円以上」\nなら割引が受けられる条件\nとして適切なのは？",
    codeSnippet: nil,
    choices: ["is_member or total >= 5000", "is_member and total >= 5000", "not is_member"],
    correctAnswer: "is_member or total >= 5000",
    explanation: "正解は is_member or total >= 5000 だよ！「会員」「金額条件」のどちらか一方を満たせば割引になるので or でつなぐのが正しいんだ。「どちらかを満たせばよい＝or」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q275 = Question(
    id: 275,
    type: .codeOutput,
    prompt: "このコードの出力は？",
    codeSnippet: "age = 17\nhas_id = True\nis_eligible = age >= 18 and has_id\nprint(is_eligible)",
    choices: ["False", "True", "17"],
    correctAnswer: "False",
    explanation: "正解は False だよ！age >= 18 は 17 >= 18 で False になり、and は両方とも True のときしか True にならないので、is_eligible は False になるんだ。「andは1つでもFalseがあれば全体がFalse」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q276 = Question(
    id: 276,
    type: .fillInBlank,
    prompt: "「在庫があり、\nかつ価格が予算以内」\nの商品を見つけたい。\n空欄に入るのは？",
    codeSnippet: "can_buy = (stock > 0) _____ (price <= budget)\nprint(can_buy)",
    choices: ["and", "or", "not"],
    correctAnswer: "and",
    explanation: "正解は and だよ！「在庫の条件」と「価格の条件」を両方満たしていないと買えないので and でつなぐんだ。「両方の条件を確認する＝and」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q277 = Question(
    id: 277,
    type: .codeOutput,
    prompt: "このコードを実行すると\n何が表示される？",
    codeSnippet: "is_member = False\ntotal = 6000\ncan_get_discount = is_member or total >= 5000\nprint(can_get_discount)",
    choices: ["True", "False", "6000"],
    correctAnswer: "True",
    explanation: "正解は True だよ！is_member は False だけど total >= 5000 が True なので、or の結果は True になるんだ。「orは1つでもTrueがあれば全体がTrue」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q278 = Question(
    id: 278,
    type: .multipleChoice,
    prompt: "2つのリストを\nつなげる演算子は？",
    codeSnippet: nil,
    choices: ["+", "&", "and"],
    correctAnswer: "+",
    explanation: "正解は + だよ！[1, 2] + [3, 4] のように、2つのリストをつなげて新しいリストを作る演算子だったね。「リストの結合＝+」と覚えておこう！（前のレッスン「リストの演算子を使おう」の復習だよ）",
    xpReward: 10,
    gemReward: 1
)

private let q279 = Question(
    id: 279,
    type: .codeOutput,
    prompt: "会員アプリで、\n「会員かつ合計金額が\n3000円以上」のときだけ\n特別割引のメッセージを\n出したい。出力はどれ？",
    codeSnippet: "is_member = True\ntotal = 4500\nis_special_discount = is_member and total >= 3000\nif is_special_discount:\n    print(\"特別割引が適用されます\")\nelse:\n    print(\"通常価格です\")",
    choices: ["特別割引が適用されます", "通常価格です", "True"],
    correctAnswer: "特別割引が適用されます",
    explanation: "正解は 特別割引が適用されます だよ！is_member が True で total >= 3000 も True なので、and でつないだ is_special_discount は True になり if のブロックが実行されるんだ。「複数の条件を組み合わせて判定する＝and/orで式を組み立ててifにつなげる」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)


// ─────────────────────────────────────────────────────────
// MARK: - Lesson 28 · 演算子の落とし穴を読もう
// ─────────────────────────────────────────────────────────

private let lesson28 = Lesson(
    id: 28,
    title: "演算子の落とし穴を読もう",
    shortLabel: "落とし穴",
    subtitle: "= と == の違い",
    category: "演算子",
    order: 28,
    questions: [q280, q281, q282, q283, q284, q285, q286, q287, q288, q289],
    requiredXP: 1400
)

private let q280 = Question(
    id: 280,
    type: .multipleChoice,
    prompt: "if user_age = 20: と書くと\nどうなる？",
    codeSnippet: nil,
    choices: ["構文エラーになる（比較には==を使う）", "正しく比較できる", "user_ageが20に書き換わる"],
    correctAnswer: "構文エラーになる（比較には==を使う）",
    explanation: "正解は 構文エラーになる（比較には==を使う） だよ！if の条件式の中で = を使うと「代入」になってしまい、Pythonでは構文エラーになるんだ。比較したいときは == を使う必要があるよ。「比較は==、代入は=」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q281 = Question(
    id: 281,
    type: .multipleChoice,
    prompt: "10 / 2 を計算すると\n結果の型は？",
    codeSnippet: nil,
    choices: ["float（5.0）", "int（5）", "str（\"5\"）"],
    correctAnswer: "float（5.0）",
    explanation: "正解は float（5.0） だよ！/ で割り算をすると、割り切れる場合でも結果は必ず float 型になるんだ。整数の結果が欲しいときは // を使うんだったね。「/ の結果は常にfloat」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q282 = Question(
    id: 282,
    type: .fillInBlank,
    prompt: "2つの値が等しいかを\n調べたい。空欄に入るのは？",
    codeSnippet: "if user_age _____ 20:\n    print(\"20歳です\")",
    choices: ["==", "=", "is"],
    correctAnswer: "==",
    explanation: "正解は == だよ！「等しいか調べる」ときは == を使うんだ。= は代入専用の記号なので、比較には使えないことに注意しよう。「比較＝==」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q283 = Question(
    id: 283,
    type: .multipleChoice,
    prompt: "次のコードのバグは\nどこにある？\nif user_age = 20:\n    print(\"20歳です\")",
    codeSnippet: nil,
    choices: ["= が == であるべき（代入と比較を混同している）", "20 が \"20\" であるべき", "if が while であるべき"],
    correctAnswer: "= が == であるべき（代入と比較を混同している）",
    explanation: "正解は = が == であるべき（代入と比較を混同している） だよ！比較したいのに代入の記号 = を使ってしまっているのが原因なんだ。if user_age == 20: と書けば正しく動くよ。「= と == を混同しない」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q284 = Question(
    id: 284,
    type: .multipleChoice,
    prompt: "次のコードのバグは\nどこにある？\nprice = 500\nprint(\"価格は\" + price + \"円\")",
    codeSnippet: nil,
    choices: ["price が int なので、+ で文字列とつなぐ前に str() で変換する必要がある", "\"価格は\" の文字数が間違っている", "print の引数の順番が逆である"],
    correctAnswer: "price が int なので、+ で文字列とつなぐ前に str() で変換する必要がある",
    explanation: "正解は price が int なので、+ で文字列とつなぐ前に str() で変換する必要がある だよ！文字列と数値は + で直接つなげられず TypeError になるので、str(price) のように変換してからつなぐ必要があるんだ。「型の違うものをつなぐ前に＝str()で変換」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q285 = Question(
    id: 285,
    type: .codeOutput,
    prompt: "このコードの出力は？",
    codeSnippet: "total = 10\ncount = 3\naverage = total / count\nprint(average)",
    choices: ["3.3333333333333335", "3", "3.0"],
    correctAnswer: "3.3333333333333335",
    explanation: "正解は 3.3333333333333335 だよ！/ は割り切れない場合は小数の結果を返し、コンピュータの計算の都合で長い小数になることがあるんだ。整数だけが欲しい場合は // を使う必要があるよ。「/ の結果は小数になりうる」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q286 = Question(
    id: 286,
    type: .fillInBlank,
    prompt: "次のコードを正しく\n動くように直したい。\n空欄に入るのは？",
    codeSnippet: "if score _____ 100:\n    print(\"満点です\")\n# 構文エラーを直したい（=では動かない）",
    choices: ["==", "=", "<>"],
    correctAnswer: "==",
    explanation: "正解は == だよ！if の条件式で値を比較するときは == を使う必要があるんだ。= のままだと構文エラーになってしまうよ。「条件式の中での比較＝==」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q287 = Question(
    id: 287,
    type: .codeOutput,
    prompt: "このコードを実行すると\n何が表示される？",
    codeSnippet: "stock = 7\ntry:\n    print(\"在庫：\" + stock + \"個\")\nexcept TypeError:\n    print(\"在庫：\" + str(stock) + \"個\")",
    choices: ["在庫：7個", "在庫：stock個", "エラーで停止する"],
    correctAnswer: "在庫：7個",
    explanation: "正解は 在庫：7個 だよ！\"在庫：\" + stock は str と int の演算で TypeError になり、except 内で str(stock) に変換してからつなげることで正しく表示できるんだ。「型エラーを想定して変換で対処する」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q288 = Question(
    id: 288,
    type: .multipleChoice,
    prompt: "「点数が80点以上で、\nかつ出席率が90%以上」\nという条件を組み立てる\n演算子は？",
    codeSnippet: nil,
    choices: ["and（両方とも満たす必要がある）", "or（どちらか一方でよい）", "not（条件を反転させる）"],
    correctAnswer: "and（両方とも満たす必要がある）",
    explanation: "正解は and（両方とも満たす必要がある） だよ！「～で、かつ～」のように両方を満たす条件は and で組み立てるんだったね。「両方とも満たす＝and」と覚えておこう！（前のレッスン「複合条件を組み立てよう」の復習だよ）",
    xpReward: 10,
    gemReward: 1
)

private let q289 = Question(
    id: 289,
    type: .codeOutput,
    prompt: "次のコードのバグを\n直して実行すると、\n出力はどれ？\n（= を == に直した場合）",
    codeSnippet: "price = 1200\nif price == 1000:\n    print(\"セール価格です\")\nelse:\n    print(\"通常価格です\")",
    choices: ["通常価格です", "セール価格です", "構文エラーで停止する（修正前のまま）"],
    correctAnswer: "通常価格です",
    explanation: "正解は 通常価格です だよ！修正前は if price = 1000: が構文エラーになってしまうけれど、== に直して比較すれば、price は 1200 で 1000 と等しくないので else の「通常価格です」が表示されるんだ。「= と == の取り違えはよくある落とし穴」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)


// ─────────────────────────────────────────────────────────
// MARK: - Lesson 29 · 演算子の総復習
// ─────────────────────────────────────────────────────────

private let lesson29 = Lesson(
    id: 29,
    title: "演算子の総復習",
    shortLabel: "総復習",
    subtitle: "コース2まとめ",
    category: "演算子",
    order: 29,
    questions: [q290, q291, q292, q293, q294, q295, q296, q297, q298, q299],
    requiredXP: 1450
)

private let q290 = Question(
    id: 290,
    type: .multipleChoice,
    prompt: "わり算の商を整数部分だけ\n返す演算子は？",
    codeSnippet: nil,
    choices: ["//", "/", "%"],
    correctAnswer: "//",
    explanation: "正解は // だよ！コース2の最初に学んだ通り、// は割り算の結果の整数部分だけを返す演算子だったね。「整数部分だけのわり算＝//」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q291 = Question(
    id: 291,
    type: .multipleChoice,
    prompt: "2つの値が等しいかを\n調べる演算子は？",
    codeSnippet: nil,
    choices: ["==", "=", "!="],
    correctAnswer: "==",
    explanation: "正解は == だよ！比較に使うのは == で、= は代入専用なんだったね。「等しいか比べる＝==」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q292 = Question(
    id: 292,
    type: .fillInBlank,
    prompt: "2つの条件が\n両方とも True のときだけ\nTrue になる演算子は？",
    codeSnippet: "is_eligible = (age >= 18) _____ has_id",
    choices: ["and", "or", "not"],
    correctAnswer: "and",
    explanation: "正解は and だよ！両方とも True のときだけ全体が True になる論理演算子だったね。「両方とも満たす＝and」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q293 = Question(
    id: 293,
    type: .multipleChoice,
    prompt: "total = total + 100 を\n短く書く代入演算子は？",
    codeSnippet: nil,
    choices: ["total += 100", "total == 100", "total =+ 100"],
    correctAnswer: "total += 100",
    explanation: "正解は total += 100 だよ！「足してから代入する」をまとめて書ける代入演算子だったね。「+= ＝足してから代入」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q294 = Question(
    id: 294,
    type: .multipleChoice,
    prompt: "2 + 3 * 4 を計算すると\n結果はどうなる？",
    codeSnippet: nil,
    choices: ["14（かけ算が先に計算される）", "20（左から順に計算される）", "9（足し算が先に計算される）"],
    correctAnswer: "14（かけ算が先に計算される）",
    explanation: "正解は 14（かけ算が先に計算される） だよ！* は + よりも優先順位が高いので、3 * 4 が先に計算されて 12、それに 2 を足して 14 になるんだ。「かけ算・わり算は足し算・引き算より先」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q295 = Question(
    id: 295,
    type: .codeOutput,
    prompt: "このコードの出力は？",
    codeSnippet: "user_name = \"陽子\"\nline = \"-\" * 8\nprint(line)\nprint(\"こんにちは、\" + user_name + \"さん\")\nprint(line)",
    choices: ["--------\nこんにちは、陽子さん\n--------", "こんにちは、陽子さん\n--------\n--------", "エラーになる"],
    correctAnswer: "--------\nこんにちは、陽子さん\n--------",
    explanation: "正解は -------- / こんにちは、陽子さん / -------- だよ！文字列の繰り返し（*）と結合（+）を組み合わせて、区切り線つきのメッセージを作っているんだ。「文字列演算子の組み合わせ＝表示を整える」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q296 = Question(
    id: 296,
    type: .fillInBlank,
    prompt: "リストの中に特定の値が\n含まれているか調べる演算子は？",
    codeSnippet: "is_wished = item_name _____ wish_list\nprint(is_wished)",
    choices: ["in", "is", "=="],
    correctAnswer: "in",
    explanation: "正解は in だよ！リストや文字列の中に指定した値が含まれているかを調べる演算子だったね。「含まれるか調べる＝in」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q297 = Question(
    id: 297,
    type: .codeOutput,
    prompt: "このコードを実行すると\n何が表示される？",
    codeSnippet: "is_member = True\ntotal = 2000\nis_special_discount = is_member and total >= 3000\nprint(is_special_discount)",
    choices: ["False", "True", "2000"],
    correctAnswer: "False",
    explanation: "正解は False だよ！is_member は True だけど total >= 3000 は 2000 >= 3000 で False になり、and は両方とも True でないと True にならないので結果は False になるんだ。「複合条件は1つずつ確認してから組み合わせを判断する」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)

private let q298 = Question(
    id: 298,
    type: .multipleChoice,
    prompt: "if user_age = 20: と書くと\nどうなる？",
    codeSnippet: nil,
    choices: ["構文エラーになる（比較には==を使う）", "正しく比較できる", "user_ageが20に書き換わる"],
    correctAnswer: "構文エラーになる（比較には==を使う）",
    explanation: "正解は 構文エラーになる（比較には==を使う） だよ！比較に = を使うと構文エラーになる、というのは演算子のよくある落とし穴だったね。「比較は==、代入は=」と覚えておこう！（前のレッスン「演算子の落とし穴を読もう」の復習だよ）",
    xpReward: 10,
    gemReward: 1
)

private let q299 = Question(
    id: 299,
    type: .codeOutput,
    prompt: "ポイント会員アプリで、\n購入金額・会員フラグ・\n割引条件をまとめて\n判定し、最終金額を\n計算したい。出力はどれ？",
    codeSnippet: "total_price = 4000\nis_member = True\nis_special_discount = is_member and total_price >= 3000\nif is_special_discount:\n    final_price = total_price - (total_price // 10)\nelse:\n    final_price = total_price\nprint(\"支払い金額：\" + str(final_price) + \"円\")",
    choices: ["支払い金額：3600円", "支払い金額：4000円", "支払い金額：400円"],
    correctAnswer: "支払い金額：3600円",
    explanation: "正解は 支払い金額：3600円 だよ！is_special_discount は True になるので、total_price から total_price // 10（10%引き分の400円）を引いた 3600 円が最終金額になるんだ。「比較・論理・算術・代入演算子を組み合わせて条件と計算を組み立てる」と覚えておこう！",
    xpReward: 10,
    gemReward: 1
)
