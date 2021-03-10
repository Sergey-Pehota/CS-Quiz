//
//  QuestionsViewController.swift
//  CSQuiz
//
//  Created by Sergey on 10.03.21.
//

import UIKit

class Model {
    let question: String
    
    init(question: String) {
        self.question = question
    }
}


class QuestionsViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
   
    let model = Model(question: "Перечислите основные принципы ООП")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = model.question
    }

}
