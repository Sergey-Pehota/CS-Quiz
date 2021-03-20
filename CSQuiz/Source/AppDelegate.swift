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
        window?.rootViewController = makeQuestionViewController()
        
        return true
    }
    
    func makeQuizViewController() -> QuizViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let quizViewController = storyboard.instantiateViewController(identifier: "QuizViewController") as! QuizViewController

        return quizViewController
    }
    
    func makeQuestionViewController() -> QuestionViewController {
        let model = QuestionModel(
            question: "Перечислите основные принципы ООП",
            answers: ["Полиморфизм", "Инкапсуляция", "Наследование", "Все выше перечисленное"])

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let questionViewController = storyboard.instantiateViewController(identifier: "QuestionViewController") as! QuestionViewController
        questionViewController.model = model

        return questionViewController
    }
    
    func makeSettingsViewController() -> SettingsViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let settingsViewController = storyboard.instantiateViewController(identifier: "SettingsViewController") as! SettingsViewController

        return settingsViewController
    }
}

