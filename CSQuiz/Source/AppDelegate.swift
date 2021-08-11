import UIKit

@main
class AppDelegate: UIResponder {
    var window: UIWindow?

    private var quizViewController: QuizViewController!
    private var questionNavigationController: UINavigationController!

    private var index = 0
    private var correctAnswersCount = 0
    private var wrongAnswersCount = 0
    private var complexity = Complexity.easy
    private var questions = Question.all

    private var filteredQuestions: [Question] {
        questions.filter { $0.complexity == complexity }
    }
    private var filteredQuestionsCount: Int {
        filteredQuestions.count
    }
}

// MARK: - UIApplicationDelegate

extension AppDelegate: UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = makeTabBarController()

        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        print("applicationWillTerminate")
        questionNavigationController.dismiss(animated: true, completion: nil)
        
        correctAnswersCount = 0
        wrongAnswersCount = 0
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
        questionViewController.title = "\(index + 1)/\(filteredQuestionsCount)"
        questionViewController.progress = Float(index) / Float(filteredQuestionsCount)
        let fq = filteredQuestions
        questionViewController.question = fq[index]

        return questionViewController
    }

    func makeQuizResultViewController() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let quizResultViewController = storyboard.instantiateViewController(identifier: "QuizResultViewController") as! QuizResultViewController
        quizResultViewController.delegate = self
        quizResultViewController.title = "Результаты"
        quizResultViewController.quizResult = QuizResult(
            questionsCount: filteredQuestionsCount,
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

// MARK: - QuizViewControllerDelegate

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

// MARK: - QuestionViewControllerDelegate

extension AppDelegate: QuestionViewControllerDelegate {
    func didTapButton(chosenOption: String) {
        answerQuestion(chosenOption)
        nextScreen()
    }
    
    private func answerQuestion(_ chosenOption: String) {
        let fq = filteredQuestions
        if fq[index].correctAnswer == chosenOption {
            correctAnswersCount += 1
        } else {
            wrongAnswersCount += 1
        }
    }

    private func nextScreen() {
        let notLastQuestion = index < filteredQuestionsCount - 1
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

// MARK: - QuizResultViewControllerDelegate

extension AppDelegate: QuizResultViewControllerDelegate {
    func didTapFinishButton() {
        questionNavigationController.dismiss(animated: true, completion: nil)
        
        correctAnswersCount = 0
        wrongAnswersCount = 0
    }
}
