import UIKit

struct QuizResult {
    let questionsCount: Int
    let correctAnswersCount: Int
    let wrongAnswersCount: Int
}

protocol QuizResultViewControllerDelegate {
    func didTapFinishButton()
}

class QuizResultViewController: UIViewController {
 
    @IBOutlet weak var resultLabel: UILabel!
    
    var delegate: QuizResultViewControllerDelegate?
    var quizResult: QuizResult!
    
    override func viewDidLoad() {
        super.viewDidLoad()
               
        resultLabel.text = """
        Всего вопросов: \(quizResult.questionsCount)
        Количество правильных ответов: \(quizResult.correctAnswersCount)
        Количество неправильных ответов: \(quizResult.wrongAnswersCount)
        """
        
        resultLabel.layer.cornerRadius = 12
        
    }
    
    @IBAction func finishButtonAction(_ sender: Any) {
        delegate?.didTapFinishButton()
    }
}
