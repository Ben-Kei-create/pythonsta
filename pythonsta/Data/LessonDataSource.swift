//
//  LessonDataSource.swift
//  pythonsta
//
//  Created by 茂木史明 on 2026/06/05.
//
//  ═══════════════════════════════════════════════════════════════════════
//  CURRICULUM SCALE TARGET
//  ═══════════════════════════════════════════════════════════════════════
//  Target lessons:   130
//  Target questions: 1300  (≈ 10 questions per lesson)
//  Session design:   1 lesson ≈ 10 questions ≈ 8–15 minutes
//  Daily goal:       10 questions (≈ 1 lesson) — soft goal only; no cap
//                    Users may continue learning indefinitely after goal
//  Curriculum time:  ≈ 130 active days at 10 questions/day
//  Outcome:          Learners can read and write practical Python code
//                    used in real-world projects.
//
//  CURRENT STATE
//  Lessons:   30 (of 130 target; orders 0–29 — Course 0 Python基礎 COMPLETE,
//             Course 1 変数と型 COMPLETE, Course 2 演算子 COMPLETE)
//  Questions: 300 (of 1300 target; 10 per lesson)
//
//  CONTENT EXHAUSTION BEHAVIOR
//  After completing all 30 lessons of Courses 0–2 (completedLessons = 30),
//  HomeView shows all nodes as .completed and no .current node. This is
//  correct: Course 3 (条件分岐, orders 30–39) has not been written yet.
//  Users simply reach the end of available content. No crash, no misleading
//  state. Once Course 3's lessons are added, the .current node at order 30
//  appears automatically.
//
//  ADVERTISING POLICY (document only; not yet implemented in code)
//  - Interstitial ads appear only after a lesson/session completes (ResultView).
//  - Ads must NEVER appear between questions or mid-lesson.
//  - Premium users: no interstitial ads; learning flow is fully uninterrupted.
//  - Implementation: inject an ad-trigger flag into LessonResult or AppState
//    at the ResultView transition point when ad infrastructure is added.
//
//  ═══════════════════════════════════════════════════════════════════════
//  CURRICULUM ROADMAP  (17 major topics × ~8 lessons × 10 questions)
//  ═══════════════════════════════════════════════════════════════════════
//
//  #  Topic (日本語)              Course ID   Lesson IDs   Order range
//  ── ───────────────────────     ─────────   ──────────   ───────────
//  01 Python基礎                  0           0–9          0–9       ← COMPLETE (10/10 lessons)
//  02 変数と型                    1           10–19        10–19     ← COMPLETE (10/10 lessons)
//  03 演算子                      2           20–29        20–29     ← COMPLETE (10/10 lessons)
//  04 条件分岐                    3           30–39        30–39
//  05 繰り返し                    4           40–49        40–49
//  06 関数                        5           50–59        50–59
//  07 リストとタプル               6           60–69        60–69
//  08 辞書とセット                 7           70–79        70–79
//  09 文字列処理                   8           80–89        80–89
//  10 例外処理                    9           90–99        90–99
//  11 ファイル操作                 10          100–109      100–109
//  12 JSON                        11          110–119      110–119
//  13 モジュール                  12          120–129      120–129
//  14 オブジェクト指向             13          130–139      130–139
//  15 API活用                     14          140–149      140–149
//  16 実践演習                    15          150–159      150–159
//  17 ミニプロジェクト             16          160–169      160–169
//
//  ═══════════════════════════════════════════════════════════════════════
//  ID ALLOCATION RULES  (enforce before adding new content)
//  ═══════════════════════════════════════════════════════════════════════
//  - Course IDs:    sequential from 0 (one per major topic above)
//  - Lesson IDs:    courseID * 10  …  courseID * 10 + 9
//  - Lesson orders: same as lesson IDs (globally unique; drives unlock)
//  - Question IDs:  lessonID * 10  …  lessonID * 10 + 9
//
//  Example — adding lesson 5 to Python基礎 (course 0):
//    Lesson  id: 5,  order: 5,  questions: [q50 … q59]
//    Question ids: 50, 51, 52, 53, 54, 55, 56, 57, 58, 59
//
//  ═══════════════════════════════════════════════════════════════════════
//  HOW TO ADD A NEW LESSON
//  ═══════════════════════════════════════════════════════════════════════
//  1. Open the appropriate course file in Data/Courses/.
//     If the course file does not exist, create it following the pattern
//     of PythonBasics.swift and add the new Course to `courses` below.
//  2. Define question constants (private let qNN = Question(...)).
//  3. Define the lesson constant (private let lessonN = Lesson(...)).
//  4. Append lessonN to the course's `lessons` array.
//  5. No other changes needed — unlock logic and navigation are automatic.
//
//  ═══════════════════════════════════════════════════════════════════════
//  UNLOCK LOGIC
//  ═══════════════════════════════════════════════════════════════════════
//  AppState.progress.completedLessons is a global counter incremented once
//  per completed lesson. HomeView maps it to node states using lesson.order:
//    order < completedLessons  → .completed
//    order == completedLessons → .current   (next to unlock)
//    order > completedLessons  → .locked
//
//  Because lesson.order values are globally unique across all courses,
//  this logic works correctly even when multiple courses are added.
//  Lesson.requiredXP is stored for a future XP-gated unlock mode.
//

import Foundation

enum LessonDataSource {

    // MARK: - Course Registry
    // Register each course file here after creating it.

    static let courses: [Course] = [
        PythonBasicsCourse.course,
        PythonTypesCourse.course,
        PythonOperatorsCourse.course,
        // Add future courses here:
        // ConditionalsCourse.course,      // course ID 3, orders 30–39
        // LoopsCourse.course,             // course ID 4, orders 40–49
        // FunctionsCourse.course,         // course ID 5, orders 50–59
        // ListsTuplesCourse.course,       // course ID 6, orders 60–69
        // DictSetsCourse.course,          // course ID 7, orders 70–79
        // StringsCourse.course,           // course ID 8, orders 80–89
        // ExceptionsCourse.course,        // course ID 9, orders 90–99
        // FileIOCourse.course,            // course ID 10, orders 100–109
        // JSONCourse.course,              // course ID 11, orders 110–119
        // ModulesCourse.course,           // course ID 12, orders 120–129
        // OOPCourse.course,               // course ID 13, orders 130–139
        // APICourse.course,               // course ID 14, orders 140–149
        // PracticalCourse.course,         // course ID 15, orders 150–159
        // MiniProjectsCourse.course,      // course ID 16, orders 160–169
    ]

    // MARK: - Convenience

    static var allLessons: [Lesson] { courses.flatMap { $0.lessons } }

    static var totalLessonCount: Int { allLessons.count }

    static var defaultLesson: Lesson { courses[0].lessons[0] }

    static func lesson(id: Int) -> Lesson? {
        allLessons.first { $0.id == id }
    }

    static func course(id: Int) -> Course? {
        courses.first { $0.id == id }
    }

    // MARK: - Review Mode lookups

    // Finds a single question by ID across all courses/lessons.
    // Used to resolve AppState.progress.reviewQuestionIDs into real Question
    // values for ReviewView.
    static func question(for id: Int) -> Question? {
        for lesson in allLessons {
            if let match = lesson.questions.first(where: { $0.id == id }) {
                return match
            }
        }
        return nil
    }

    // Resolves a list of IDs into questions, preserving order and silently
    // dropping any ID that no longer matches a question (e.g. seed data
    // changed). compactMap keeps this safe with no crashes.
    static func questions(for ids: [Int]) -> [Question] {
        ids.compactMap(question(for:))
    }
}
