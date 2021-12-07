import Foundation

struct Question {
    let text: String
    let answers: [String]
    let complexity: Complexity
    let answerType: AnswerType
}

enum AnswerType {
    case single(correctAnswer: Int)
    case multiple(correctAnswers: [Int])
}

extension Question {
    static var all: [Question] {
        [
            Question(
                text: "Перечислите основные принципы ООП",
                answers: ["Полиморфизм", "Инкапсуляция", "Наследование", "Все выше перечисленное"],
                complexity: .easy,
                answerType: .single(correctAnswer: 3)),

            Question(
                text: "Каким образом можно инициализировать массив?",
                answers: ["let array: [1, 5, 67]", "var array = [String]()", "var array = {«Дед», «Баба»}", "let array = []()"],
                complexity: .easy,
                answerType: .multiple(correctAnswers: [1])),

            Question(
                text: "Что из нижеприведенного является унарным оператором?",
                answers: ["?,!", "+, -", "&&, ||", "Все выше перечисленное"],
                complexity: .medium,
                answerType: .single(correctAnswer: 0)),

            Question(
                text: "Как правильно декларировать протокол?",
                answers: ["protocol Example { func example() }", "protocol example() {}", "protocol example = [«Learn», «Study», «Practice»]", "var example = Protocol()"],
                complexity: .easy,
                answerType: .single(correctAnswer: 0)),

            Question(
                text: "Каким образом правильно cоздать переменную с опциональным  типом данных?",
                answers: ["var variable = 12?", "var variable: String? = \"Variable\"", "var variable: Optional<Float> = 12.5", "var variable = Optional <12.5>"],
                complexity: .medium,
                answerType: .multiple(correctAnswers: [1, 2])),

            Question(
                text: "Какие методы используются в вычисляемых свойствах?",
                answers: ["print", "init", "set", "get"],
                complexity: .hard,
                answerType: .multiple(correctAnswers: [2, 3])),

            Question(
                text: "Используется ли в протоколах, структурах и перечислениях инициализатор?",
                answers: ["да", "нет"],
                complexity: .easy,
                answerType: .single(correctAnswer: 0)),

            Question(
                text: "Какие из методов составляют  «жизненный цикл» приложения?",
                answers: ["didFinishLaunchingWithOptions, applicationWillResignActive", "viewWillLayoutSubviews, applicationDidBecomeActive", "applicationDidEnterBackground, applicationWillEnterForeground"],
                complexity: .easy,
                answerType: .multiple(correctAnswers: [0, 2])),

            Question(
                text: "Какие из методов составляют  «жизненный цикл» вьюконтроллера?",
                answers: ["viewDidLoad, viewWillAppear", "applicationDidEnterBackground, applicationWillEnterForeground", "viewDidLayoutSubviews, didReceiveMemoryWarning", "didFinishLaunchingWithOptions, applicationWillResignActive"],
                complexity: .hard,
                answerType: .multiple(correctAnswers: [0, 2])),

            Question(
                text: "К какому типу данных относится константа let marks = [3: \"Плохо\", 6: \"Хорошо\", 9: \"Отлично\"]?",
                answers: ["массив", "словарь", "опционал", "кортеж"],
                complexity: .medium,
                answerType: .single(correctAnswer: 1)),

            Question(
                text: "К какому типу данных относится указанная константа let progress = (\"User\", 100.00)?",
                answers: ["массив", "словарь", "опционал", "кортеж"],
                complexity: .easy,
                answerType: .single(correctAnswer: 3))
            
        ]
    }
}
