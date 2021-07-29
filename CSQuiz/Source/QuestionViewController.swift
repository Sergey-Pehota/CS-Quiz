//
//  QuestionsViewController.swift
//  CSQuiz
//
//  Created by Sergey on 10.03.21.
//

import UIKit

// Оставляем класс в качестве примера, в данном случае лучще использовать структуру
class QuestionModel {
    let question: String
    let answers: [String]
    
    init(question: String, answers: [String]) {
        self.question = question
        self.answers = answers
    }
}

class QuestionViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
   
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    @IBOutlet weak var fourthButton: UIButton!
    
    var model: QuestionModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = model.question
        
        [firstButton, secondButton, thirdButton, fourthButton]
            .enumerated()
            .forEach { index, button in
                button?.setTitle(model.answers[index], for: .normal)
                button?.layer.cornerRadius = 12
                button?.layer.borderWidth = 1
                button?.layer.borderColor = UIColor.blue.cgColor
                button?.backgroundColor = .clear
            }
    }
}
