//
//  QuizViewController.swift
//  CSQuiz
//
//  Created by Sergey on 14.03.21.
//

import UIKit

struct QuizModel {
    let complexityTitles: [String]
    let startTitle: String
}

class QuizViewController: UIViewController {
    @IBOutlet weak var complexitySegmentedControl: UISegmentedControl!
    @IBOutlet weak var startButton: UIButton!
    
    let model = QuizModel(complexityTitles: ["Легко", "Сложно"], startTitle: "Начать")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        complexitySegmentedControl.setTitle(model.complexityTitles[0], forSegmentAt: 0)
        complexitySegmentedControl.setTitle(model.complexityTitles[1], forSegmentAt: 1)
        
        complexitySegmentedControl.addTarget(self, action: #selector(handleComplexitySegmentedControlValueChanged(_:)), for: .valueChanged)
        
        startButton.setTitle(model.startTitle, for: .normal)
        
        startButton.layer.cornerRadius = 12
    }
    
    @IBAction func startButtonAction(_ sender: Any) {
        let vc = makeQuestionViewController()
        present(vc, animated: true, completion: nil)
    }
    
    @objc func handleComplexitySegmentedControlValueChanged(_ sender: UISegmentedControl) {
        print("Handle")
    }
    
    func makeQuestionViewController() -> UIViewController {
        let model = QuestionModel(
            question: "Перечислите основные принципы ООП",
            answers: ["Полиморфизм", "Инкапсуляция", "Наследование", "Все выше перечисленное"])

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let questionViewController = storyboard.instantiateViewController(identifier: "QuestionViewController") as! QuestionViewController
        questionViewController.title = "1/10"
        questionViewController.model = model
        let navigationController = UINavigationController(rootViewController: questionViewController)

        return navigationController
    }
}
