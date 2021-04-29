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
    
    var questions: [Question] = [
        Question(
            text: "Перечислите основные принципы ООП",
            answers: ["Полиморфизм", "Инкапсуляция", "Наследование", "Все выше перечисленное"]),
        
        Question(
            text: "Каким образом можно инициализировать массив?",
            answers: ["1", "2", "3", "4"]),
        
        Question(
            text: "Каким образом можно инициализировать массив?",
            answers: ["5", "6", "7", "8"]),
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
        let image = UIImage(systemName: "hand.raised")
        quizViewController.tabBarItem = UITabBarItem(title: "Квиз", image: image, tag: 0)
        let navigationController = UINavigationController(rootViewController: quizViewController)
        navigationController.navigationBar.prefersLargeTitles = true

        return navigationController
    }
    
    func makeQuestionViewController(question: Question) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let questionViewController = storyboard.instantiateViewController(identifier: "QuestionViewController") as! QuestionViewController
        questionViewController.delegate = self
        questionViewController.title = "1/10"
        questionViewController.question = question

        return questionViewController
    }
    
    func makeFinishViewController() -> UIViewController {
        let vc = UIViewController()
        vc.view.backgroundColor = .green
        
        return vc
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
        let vc = makeQuestionViewController(question: questions[index])
        questionNavigationController = UINavigationController(rootViewController: vc)
        quizViewController.present(questionNavigationController, animated: true, completion: nil)
    }
}

extension AppDelegate: QuestionViewControllerDelegate {
    func didTapButton(option: String) {
        if index < questions.count - 1 {
            index += 1
            let vc = makeQuestionViewController(question: questions[index])
            questionNavigationController.pushViewController(vc, animated: true)
        } else {
            let vc = makeFinishViewController()
            questionNavigationController.pushViewController(vc, animated: true)
        }
    }
}
