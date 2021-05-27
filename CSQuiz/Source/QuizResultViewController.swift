import UIKit

struct QuizResult {
    let questionsCount: Int
    let correctAnswersCount: Int
    let wrongAnswersCount: Int
}

class QuizResultViewController: UIViewController {
    var quizResult: QuizResult!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Всего вопросов: \(quizResult.questionsCount)")
        print("Количество правильных ответов: \(quizResult.correctAnswersCount)")
        print("Количество неправильных ответов: \(quizResult.wrongAnswersCount)")
    }
    
    @IBAction func finishButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
