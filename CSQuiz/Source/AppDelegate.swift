import UIKit

@main
class AppDelegate: UIResponder {
    var window: UIWindow?
    var engine = QuizEngine()

    private var quizViewController: QuizViewController!
    private var questionNavigationController: UINavigationController!
}

// MARK: - UIApplicationDelegate

extension AppDelegate: UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = makeTabBarController()

        return true
    }
}

// MARK: - Factories

extension AppDelegate {
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
        questionViewController.title = "\(engine.index + 1)/\(engine.filteredQuestionsCount)"
        questionViewController.progress = Float(engine.index) / Float(engine.filteredQuestionsCount)
        let fq = engine.filteredQuestions
        questionViewController.question = fq[engine.index]

        return questionViewController
    }

    func makeQuizResultViewController() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let quizResultViewController = storyboard.instantiateViewController(identifier: "QuizResultViewController") as! QuizResultViewController
        quizResultViewController.delegate = self
        quizResultViewController.title = "Результаты"
        quizResultViewController.quizResult = QuizResult(
            questionsCount: engine.filteredQuestionsCount,
            correctAnswersCount: engine.correctAnswersCount,
            wrongAnswersCount: engine.wrongAnswersCount,
            missedQuestionsCount: engine.missedQuestionsCount)

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

// MARK: - QuizViewControllerDelegate

extension AppDelegate: QuizViewControllerDelegate {
    func didTapSegmentedControl(at index: Int) {
        engine.complexity = Complexity(rawValue: index)!
    }
    
    func didTapStartButton() {
        let vc = makeQuestionViewController()
        questionNavigationController = UINavigationController(rootViewController: vc)
        questionNavigationController.modalPresentationStyle = .fullScreen
        quizViewController.present(questionNavigationController, animated: true, completion: nil)
    }
}

// MARK: - QuestionViewControllerDelegate

extension AppDelegate: QuestionViewControllerDelegate {
    func didTapAnswerButton(chosenOptionsIndices: Set<Int>) {
//        1. взять текущий вопрос
        let fq = engine.filteredQuestions
        let question = fq[engine.index]
//        2. взять правильные ответы
        switch question.answerType {
        case .multiple(let correctAnswers):
            if chosenOptionsIndices == correctAnswers {
                engine.correctAnswersCount += 1
            } else {
                engine.wrongAnswersCount += 1
            }
            
        case .single(let correctAnswer):
//            содержит ли массив chosenOptionsIndices индекс correctAnswer
            if chosenOptionsIndices.contains(correctAnswer) {
                engine.correctAnswersCount += 1
            } else {
                engine.wrongAnswersCount += 1
            }
        }
//        3. сравнить индексы
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.nextScreen()
        }
        
    }
    
    func didTapSkip() {
        engine.missedQuestionsCount += 1
        nextScreen()
    }
    
    func didTapClose() {
        questionNavigationController.dismiss(animated: true, completion: nil)
        engine.finish()
    }
    
//    private func answerQuestion(_ chosenOption: String) {
//        let fq = engine.filteredQuestions
//        if fq[engine.index].correctAnswers == chosenOption {
//            engine.correctAnswersCount += 1
//        } else {
//            engine.wrongAnswersCount += 1
//        }
//    }
    
    private func nextScreen() {
        let notLastQuestion = engine.index < engine.filteredQuestionsCount - 1
        if notLastQuestion {
            engine.index += 1
            let vc = makeQuestionViewController()
            questionNavigationController.setViewControllers([vc], animated: true)
        } else {
            engine.index = 0
            let vc = makeQuizResultViewController()
            questionNavigationController.setViewControllers([vc], animated: true)
        }
    }
}

// MARK: - QuizResultViewControllerDelegate

extension AppDelegate: QuizResultViewControllerDelegate {
    func didTapFinishButton() {
        questionNavigationController.dismiss(animated: true, completion: nil)
        
        engine.correctAnswersCount = 0
        engine.wrongAnswersCount = 0
        engine.missedQuestionsCount = 0
    }
}
