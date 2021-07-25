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
    let correctAnswer: String
    let complexity: Complexity
}

protocol QuestionViewControllerDelegate {
    func didTapButton(chosenOption: String)
}

class QuestionViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
   
    
    @IBOutlet weak var progressView: UIProgressView!
    
    var delegate: QuestionViewControllerDelegate?
    
    var question: Question!
    var progress: Float!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = question.text
        
        progressView.setProgress(progress, animated: false)
        
        var questionButton = UIButton()
//        questionButton.setTitle(question.answers[index], for: .normal)
        questionButton.titleLabel?.font = .systemFont(ofSize: 24)
        questionButton.titleLabel?.textColor = .systemBlue
        questionButton.layer.cornerRadius = 12
        questionButton.layer.borderWidth = 1
        questionButton.layer.borderColor = UIColor.blue.cgColor
        questionButton.backgroundColor = .systemGray5
        questionButton.titleLabel?.adjustsFontSizeToFitWidth = true
    }
}

