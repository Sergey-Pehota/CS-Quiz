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
        
        startButton.setTitle(model.startTitle, for: .normal)
    }
}
