import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var quizViewController: QuizViewController!
    var questionNavigationController: UINavigationController!
    var index = 0
    var questionsCount: Int {
        questions
            .filter { $0.complexity == complexity }
            .count
    }
    var correctAnswersCount = 0
    var wrongAnswersCount = 0
    
    var complexity = Complexity.easy

    var questions: [Question] = [
        Question(
            text: "Перечислите основные принципы ООП",
            answers: ["Полиморфизм", "Инкапсуляция", "Наследование", "Все выше перечисленное"],
            correctAnswer: "Все выше перечисленное",
            complexity: .hard),
        
        Question(
            text: "Каким образом можно инициализировать массив?",
            answers: ["let array: [1, 5, 67]", "var array = [String]()", "var array = {«Дед», «Баба»}", "let array = []()"],
            correctAnswer: "var array = [String]()",
            complexity: .easy),
        
        Question(
            text: "Что из нижеприведенного является унарным оператором?",
            answers: ["?,!", "+, -", "&&, ||", "Все выше перечисленное"],
            correctAnswer: "?,!",
            complexity: .medium),
        
        Question(
            text: "Как правильно декларировать протокол?",
            answers: ["protocol Example { func example() }", "protocol example() {}", "protocol example = [«Learn», «Study», «Practice»]", "var example = Protocol()"],
            correctAnswer: "protocol Example { func example() }",
            complexity: .easy),
        
        Question(
            text: "Каким образом правильно cоздаать переменную с опциональным  типом данных?",
            answers: ["var variable = 12?", "var variable: String? = \"Variable\"", "var variable: Optional = 12.5!", "var variable = Optional <12.5>"],
            correctAnswer: "var variable: String? = \"Variable\"",
            complexity: .medium),
        
        Question(
            text: "Какие методы используются в вычисляемых свойствах?",
            answers: ["print, init", "init, func", "get, set", "init, get"],
            correctAnswer: "get, set",
            complexity: .hard),
        
        Question(
            text: "Используется ли в протоколах, структурах и перечислениях инициализатор?",
            answers: ["да", "нет"],
            correctAnswer: "да",
            complexity: .easy),
        
        Question(
            text: "Какие из методов составляют  «жизненный цикл» приложения?",
            answers: ["didFinishLaunchingWithOptions, applicationWillResignActive", "viewWillLayoutSubviews, applicationDidBecomeActive", "applicationDidEnterBackground, applicationWillEnterForeground", "перечисленные в пунктах 4.2 и 4.3", "перечисленные в пунктах 4.1 и 4.3"],
            correctAnswer: "перечисленные в пунктах 4.1 и 4.3",
            complexity: .easy),
        
        Question(
            text: "Какие из методов составляют  «жизненный цикл» вьюконтроллера?",
            answers: ["viewDidLoad, viewWillAppear", "viewDidAppear, viewWillLayoutSubviews", "viewDidLayoutSubviews, didReceiveMemoryWarning", "все вышеперечисленные"],
            correctAnswer: "все вышеперечисленные",
            complexity: .hard),
        
        Question(
            text: "К какому типу данных относится указанная константа let marks = [3: \"Плохо\", 6: \"Хорошо\", 9: \"Отлично\"]?",
            answers: ["массив", "словарь", "опционал", "кортеж"],
            correctAnswer: "словарь",
            complexity: .medium),
        
        Question(
            text: "К какому типу данных относится указанная константа let progress = (\"User\", 100.00)?",
            answers: ["массив", "словарь", "опционал", "кортеж"],
            correctAnswer: "кортеж",
            complexity: .easy)

    ]

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = makeTabBarController()
        
        return true
    }
    
    func makeTabBarController() -> UIViewController {
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers([makeQuizViewController(), makeSettingsViewController()], animated: false)
        
        return tabBarController
    }
    
    func makeQuizViewController() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        quizViewController = storyboard.instantiateViewController(identifier: "QuizViewController")
        quizViewController.delegate = self
        quizViewController.title = "Квиз"
        quizViewController.quiz = Quiz(complexityLevels: Complexity.allCases, startTitle: "Начать")
        let image = UIImage(systemName: "hand.raised")
        quizViewController.tabBarItem = UITabBarItem(title: "Квиз", image: image, tag: 0)
        let navigationController = UINavigationController(rootViewController: quizViewController)
        navigationController.navigationBar.prefersLargeTitles = true

        return navigationController
    }
    
    func makeQuestionViewController() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let questionViewController = storyboard.instantiateViewController(identifier: "QuestionViewController") as! QuestionViewController
        questionViewController.delegate = self
        questionViewController.title = "\(index + 1)/\(questionsCount)"
        questionViewController.progress = Float(index) / Float(questionsCount)
        let filteredQuestions = questions.filter { $0.complexity == complexity }
        questionViewController.question = filteredQuestions[index]
        
        return questionViewController
    }
    
    func makeQuizResultViewController() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let quizResultViewController = storyboard.instantiateViewController(identifier: "QuizResultViewController") as! QuizResultViewController
        quizResultViewController.delegate = self
        quizResultViewController.title = "Результаты"
        quizResultViewController.quizResult = QuizResult(
            questionsCount: questionsCount,
            correctAnswersCount: correctAnswersCount,
            wrongAnswersCount: wrongAnswersCount)
        
        return quizResultViewController
    }
    
    func makeSettingsViewController() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let settingsViewController = storyboard.instantiateViewController(identifier: "SettingsViewController") as! SettingsViewController
        settingsViewController.title = "Настройки"
        let image = UIImage(systemName: "hand.point.right")
        settingsViewController.tabBarItem = UITabBarItem(title: "Настройки", image: image, tag: 0)
        let navigationController = UINavigationController(rootViewController: settingsViewController)
        navigationController.navigationBar.prefersLargeTitles = true

        return navigationController
    }
}

extension AppDelegate: QuizViewControllerDelegate {
    func didTapSegmentedControl(at index: Int) {
        complexity = Complexity(rawValue: index)!
    }
    
    func didTapStartButton() {
        let vc = makeQuestionViewController()
        questionNavigationController = UINavigationController(rootViewController: vc)
        quizViewController.present(questionNavigationController, animated: true, completion: nil)
    }
}

extension AppDelegate: QuestionViewControllerDelegate {
    func didTapButton(chosenOption: String) {
        answerQuestion(chosenOption)
        nextScreen()
    }
    
    private func answerQuestion(_ chosenOption: String) {
        let filteredQuestions = questions.filter { $0.complexity == complexity }
        if filteredQuestions[index].correctAnswer == chosenOption {
            correctAnswersCount += 1
        } else {
            wrongAnswersCount += 1
        }
    }

    private func nextScreen() {
        let notLastQuestion = index < questionsCount - 1
        if notLastQuestion {
            index += 1
            let vc = makeQuestionViewController()
            questionNavigationController.setViewControllers([vc], animated: true)
        } else {
            index = 0
            let vc = makeQuizResultViewController()
            questionNavigationController.setViewControllers([vc], animated: true)
        }
    }
}

extension AppDelegate: QuizResultViewControllerDelegate {
    func didTapFinishButton() {
        questionNavigationController.dismiss(animated: true, completion: nil)
        
        correctAnswersCount = 0
        wrongAnswersCount = 0
    }
}
