import Foundation

struct Question {
    let text: String
    let answers: [String]
    let correctAnswer: String
    let complexity: Complexity
    let selectionType: SelectionType
}

enum SelectionType {
    case single, multiple
}

extension Question {
    static var all: [Question] {
        [
            Question(
                text: "Перечислите основные принципы ООП",
                answers: ["Полиморфизм", "Инкапсуляция", "Наследование", "Все выше перечисленное"],
                correctAnswer: "Все выше перечисленное",
                complexity: .hard,
                selectionType: .single),

            Question(
                text: "Каким образом можно инициализировать массив?",
                answers: ["let array: [1, 5, 67]", "var array = [String]()", "var array = {«Дед», «Баба»}", "let array = []()"],
                correctAnswer: "var array = [String]()",
                complexity: .easy,
                selectionType: .multiple),

            Question(
                text: "Что из нижеприведенного является унарным оператором?",
                answers: ["?,!", "+, -", "&&, ||", "Все выше перечисленное"],
                correctAnswer: "?,!",
                complexity: .medium,
                selectionType: .single),

            Question(
                text: "Как правильно декларировать протокол?",
                answers: ["protocol Example { func example() }", "protocol example() {}", "protocol example = [«Learn», «Study», «Practice»]", "var example = Protocol()"],
                correctAnswer: "protocol Example { func example() }",
                complexity: .easy,
                selectionType: .single),

            Question(
                text: "Каким образом правильно cоздать переменную с опциональным  типом данных?",
                answers: ["var variable = 12?", "var variable: String? = \"Variable\"", "var variable: Optional = 12.5!", "var variable = Optional <12.5>"],
                correctAnswer: "var variable: String? = \"Variable\"",
                complexity: .medium,
                selectionType: .multiple),

            Question(
                text: "Какие методы используются в вычисляемых свойствах?",
                answers: ["print, init", "init, func", "get, set", "init, get"],
                correctAnswer: "get, set",
                complexity: .hard,
                selectionType: .multiple),

            Question(
                text: "Используется ли в протоколах, структурах и перечислениях инициализатор?",
                answers: ["да", "нет"],
                correctAnswer: "да",
                complexity: .easy,
                selectionType: .single),

            Question(
                text: "Какие из методов составляют  «жизненный цикл» приложения?",
                answers: ["didFinishLaunchingWithOptions, applicationWillResignActive", "viewWillLayoutSubviews, applicationDidBecomeActive", "applicationDidEnterBackground, applicationWillEnterForeground", "перечисленные в пунктах 4.2 и 4.3", "перечисленные в пунктах 4.1 и 4.3"],
                correctAnswer: "перечисленные в пунктах 4.1 и 4.3",
                complexity: .easy,
                selectionType: .multiple),

            Question(
                text: "Какие из методов составляют  «жизненный цикл» вьюконтроллера?",
                answers: ["viewDidLoad, viewWillAppear", "viewDidAppear, viewWillLayoutSubviews", "viewDidLayoutSubviews, didReceiveMemoryWarning", "все вышеперечисленные"],
                correctAnswer: "все вышеперечисленные",
                complexity: .hard,
                selectionType: .multiple),

            Question(
                text: "К какому типу данных относится константа let marks = [3: \"Плохо\", 6: \"Хорошо\", 9: \"Отлично\"]?",
                answers: ["массив", "словарь", "опционал", "кортеж"],
                correctAnswer: "словарь",
                complexity: .medium,
                selectionType: .single),

            Question(
                text: "К какому типу данных относится указанная константа let progress = (\"User\", 100.00)?",
                answers: ["массив", "словарь", "опционал", "кортеж"],
                correctAnswer: "кортеж",
                complexity: .easy,
                selectionType: .single)
        ]
    }
}
