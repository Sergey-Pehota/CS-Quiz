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
        let image = UIImage(systemName: "hand.raised")
        quizViewController.tabBarItem = UITabBarItem(title: "Квиз", image: image, tag: 0)
        let navigationController = UINavigationController(rootViewController: quizViewController)
        navigationController.navigationBar.prefersLargeTitles = true

        return navigationController
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

