import UIKit

protocol QuestionViewControllerDelegate {
    func didTapButton(chosenOption: String)
    func didTapClose()
}

final class QuestionViewController: UIViewController {
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var answersStackView: UIStackView!
    
    var delegate: QuestionViewControllerDelegate?
    
    var question: Question!
    var progress: Float!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Закрыть", style: .plain, target: self, action: #selector(closeTapped))
        
        progressView.setProgress(progress, animated: false)

        titleLabel.text = question.text

        question.answers.enumerated().forEach { index, answer in
            let answerButton = UIButton()
            answerButton.setTitle(answer, for: .normal)
            answerButton.setTitleColor(.systemBlue, for: .normal)
            answerButton.titleLabel?.font = .systemFont(ofSize: 20)
            answerButton.titleLabel?.numberOfLines = 2
            answerButton.layer.cornerRadius = 12
            answerButton.layer.borderWidth = 1
            answerButton.layer.borderColor = UIColor.blue.cgColor
            answerButton.backgroundColor = .systemGray5
            answerButton.tag = index
            answerButton.addTarget(self, action: #selector(handleButtonTap(sender:)), for: .touchUpInside)

            answersStackView.addArrangedSubview(answerButton)
        }
    }

    @objc private func handleButtonTap(sender: UIButton) {
        let chosenIndex = sender.tag
        let chosenOption = question.answers[chosenIndex]
        delegate?.didTapButton(chosenOption: chosenOption)
    }
    
    @objc private func closeTapped() {
        delegate?.didTapClose()
    }
}
