import UIKit

protocol QuizViewControllerDelegate {
    func didTapStartButton()
    func didTapSegmentedControl(at index: Int)
}

final class QuizViewController: UIViewController {
    @IBOutlet weak var complexitySegmentedControl: UISegmentedControl!
    @IBOutlet weak var startButton: UIButton!
    
    var delegate: QuizViewControllerDelegate?
    
    var quiz: Quiz!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        complexitySegmentedControl.removeAllSegments()
        quiz.complexityLevels.enumerated().forEach { index, level in
            complexitySegmentedControl.insertSegment(withTitle: level.title, at: index, animated: false)
        }

        complexitySegmentedControl.selectedSegmentIndex = 0

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
