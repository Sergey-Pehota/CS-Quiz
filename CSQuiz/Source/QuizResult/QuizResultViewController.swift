import UIKit

protocol QuizResultViewControllerDelegate {
    func didTapFinishButton()
}

final class QuizResultViewController: UIViewController {
    @IBOutlet weak var questionsAtAllLabel: UILabel!
    @IBOutlet weak var correctAnswersLabel: UILabel!
    @IBOutlet weak var wrongAnswersLabel: UILabel!
    @IBOutlet weak var missedQuestionsLabel: UILabel!
    
    var delegate: QuizResultViewControllerDelegate?
    var quizResult: QuizResult!
    
    override func viewDidLoad() {
        super.viewDidLoad()
               
        questionsAtAllLabel.text = "Всего вопросов: \(quizResult.questionsCount)"
        correctAnswersLabel.text = "Правильных ответов: \(quizResult.correctAnswersCount)"
        wrongAnswersLabel.text = "Неправильных ответов: \(quizResult.wrongAnswersCount)"
        missedQuestionsLabel.text = "Пропущенных вопросов: \(quizResult.missedQuestionsCount)"
    }
    
    @IBAction func finishButtonAction(_ sender: Any) {
        delegate?.didTapFinishButton()
    }
}
