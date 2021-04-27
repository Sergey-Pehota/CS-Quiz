//
//  QuestionsViewController.swift
//  CSQuiz
//
//  Created by Sergey on 10.03.21.
//

import UIKit

struct Question {
    let text: String
    let answers: [String]
}

protocol QuestionViewControllerDelegate {
    func didTapButton(option: String)
}

class QuestionViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
   
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    @IBOutlet weak var fourthButton: UIButton!
    
    var delegate: QuestionViewControllerDelegate?
    
    var question: Question!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = question.text
        
        [firstButton, secondButton, thirdButton, fourthButton]
            .enumerated()
            .forEach { index, button in
                button?.setTitle(question.answers[index], for: .normal)
                button?.layer.cornerRadius = 12
                button?.layer.borderWidth = 1
                button?.layer.borderColor = UIColor.blue.cgColor
                button?.backgroundColor = .clear
            }
    }
    
    
    @IBAction func firstButtonAction(_ sender: Any) {
        delegate?.didTapButton(option: question.answers[0])
    }
    
    @IBAction func secondButtonAction(_ sender: Any) {
        delegate?.didTapButton(option: question.answers[1])
    }
    
    @IBAction func thirdButtonAction(_ sender: Any) {
        delegate?.didTapButton(option: question.answers[2])
    }
    
    @IBAction func fourthButtonAction(_ sender: Any) {
        delegate?.didTapButton(option: question.answers[3])
    }
}

