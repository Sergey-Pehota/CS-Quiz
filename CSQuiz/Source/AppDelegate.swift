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
        let quizViewController = storyboard.instantiateViewController(identifier: "QuizViewController") as! QuizViewController
        quizViewController.title = "Квиз"
        let navigationController = UINavigationController(rootViewController: quizViewController)

        return navigationController
    }
    
    func makeQuestionViewController() -> UIViewController {
        let model = QuestionModel(
            question: "Перечислите основные принципы ООП",
            answers: ["Полиморфизм", "Инкапсуляция", "Наследование", "Все выше перечисленное"])

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let questionViewController = storyboard.instantiateViewController(identifier: "QuestionViewController") as! QuestionViewController
        questionViewController.model = model
        let navigationController = UINavigationController(rootViewController: questionViewController)

        return navigationController
    }
    
    func makeSettingsViewController() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let settingsViewController = storyboard.instantiateViewController(identifier: "SettingsViewController") as! SettingsViewController
        settingsViewController.title = "Настройки"
        let navigationController = UINavigationController(rootViewController: settingsViewController)

        return navigationController
    }
}

