//
//  QuestionsViewController.swift
//  CSQuiz
//
//  Created by Sergey on 10.03.21.
//

import UIKit

class Model {
    let question: String
    let answers: [String]
    
    init(question: String, answers: [String]) {
        self.question = question
        self.answers = answers
    }
}

class QuestionsViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
   
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    @IBOutlet weak var fourthButton: UIButton!
    
    let model = Model(question: "Перечислите основные принципы ООП",
                      answers: ["Полиморфизм", "Инкапсуляция", "Наследование", "Все выше перечисленное"])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = model.question
        
        firstButton.setTitle(model.answers[0], for: .normal)
        secondButton.setTitle(model.answers[1], for: .normal)
        thirdButton.setTitle(model.answers[2], for: .normal)
        fourthButton.setTitle(model.answers[3], for: .normal)
    }
}
