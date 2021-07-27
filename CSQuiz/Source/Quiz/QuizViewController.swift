import UIKit

protocol QuizViewControllerDelegate {
    func didTapStartButton()
    func didTapSegmentedControl(at index: Int)
}

class QuizViewController: UIViewController {
    @IBOutlet weak var complexitySegmentedControl: UISegmentedControl!
    @IBOutlet weak var startButton: UIButton!
    
    var delegate: QuizViewControllerDelegate?
    
    var quiz: Quiz!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        complexitySegmentedControl.setTitle(quiz.complexityLevels[0].title, forSegmentAt: 0)
        complexitySegmentedControl.setTitle(quiz.complexityLevels[1].title, forSegmentAt: 1)
        complexitySegmentedControl.setTitle(quiz.complexityLevels[2].title, forSegmentAt: 2)

        
        complexitySegmentedControl.addTarget(self, action: #selector(handleComplexitySegmentedControlValueChanged(_:)), for: .valueChanged)
        
        startButton.setTitle(quiz.startTitle, for: .normal)
        
        startButton.layer.cornerRadius = 12
    }
    
    @IBAction func startButtonAction(_ sender: Any) {
        delegate?.didTapStartButton()
    }
    
    @objc func handleComplexitySegmentedControlValueChanged(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        delegate?.didTapSegmentedControl(at: index)
    }
}
