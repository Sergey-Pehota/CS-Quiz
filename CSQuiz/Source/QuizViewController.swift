//
//  QuizViewController.swift
//  CSQuiz
//
//  Created by Sergey on 14.03.21.
//

import UIKit

struct Quiz {
    let complexityTitles: [String]
    let startTitle: String
}

protocol QuizViewControllerDelegate {
    func didTapStartButton()
}

class QuizViewController: UIViewController {
    @IBOutlet weak var complexitySegmentedControl: UISegmentedControl!
    @IBOutlet weak var startButton: UIButton!
    
    var delegate: QuizViewControllerDelegate?
    
    var quiz: Quiz!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        complexitySegmentedControl.setTitle(quiz.complexityTitles[0], forSegmentAt: 0)
        complexitySegmentedControl.setTitle(quiz.complexityTitles[1], forSegmentAt: 1)
        
        complexitySegmentedControl.addTarget(self, action: #selector(handleComplexitySegmentedControlValueChanged(_:)), for: .valueChanged)
        
        startButton.setTitle(quiz.startTitle, for: .normal)
        
        startButton.layer.cornerRadius = 12
    }
    
    @IBAction func startButtonAction(_ sender: Any) {
        delegate?.didTapStartButton()
    }
    
    @objc func handleComplexitySegmentedControlValueChanged(_ sender: UISegmentedControl) {
        print("Handle")
    }
}
