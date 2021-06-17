//
//  AppDelegate.swift
//  CSQuiz
//
//  Created by Nikita on 6.03.21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var quizViewController: QuizViewController!
    var questionNavigationController: UINavigationController!
    var index = 0
    var questionsCount: Int {
        questions.count
    }
    var correctAnswersCount = 0
    var wrongAnswersCount = 0
    
    var questions: [Question] = [
        Question(
            text: "Перечислите основные принципы ООП",
            answers: ["Полиморфизм", "Инкапсуляция", "Наследование", "Все выше перечисленное"],
            correctAnswer: "Все выше перечисленное",
            complexity: .easy),
        
        Question(
            text: "Каким образом можно инициализировать массив?",
            answers: ["let array: [1, 5, 67]", "var array = [String]()", "var array = {«Дед», «Баба»}", "let array = []()"],
            correctAnswer: "var array = [String]()",
            complexity: .hard),
        
        Question(
            text: "Что из нижеприведенного является унарным оператором?",
            answers: ["?,!", "+, -", "&&, ||", "Все выше перечисленное"],
            correctAnswer: "?,!",
            complexity: .hard),
        
        Question(
            text: "Как правильно декларировать протокол?",
            answers: ["protocol Example { func example() }", "protocol example() {}", "protocol example = [«Learn», «Study», «Practice»]", "var example = Protocol()"],
            correctAnswer: "protocol Example { func example() }",
            complexity: .easy),
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
        quizViewController.quiz = QuizModel(complexityTitles: ["Легко", "Сложно"], startTitle: "Начать")
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
        questionViewController.question = questions[index]

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
        if questions[index].correctAnswer == chosenOption {
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
