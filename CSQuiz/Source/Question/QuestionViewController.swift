import UIKit

protocol QuestionViewControllerDelegate {
    func didTapAnswerButton(chosenOptionsIndices: Set<Int>)
    func didTapSkip()
    func didTapClose()
}

final class QuestionViewController: UIViewController {
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var promptLabel: UILabel!
    @IBOutlet weak var answerButton: UIButton!
    @IBOutlet weak var answersStackView: UIStackView!
    
    var delegate: QuestionViewControllerDelegate?
    
    var question: Question!
    var progress: Float!
    var chosenOptionsIndices = Set<Int>()
    var chosenOptionIndex: Int?
    var correctAnswerShow = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Закрыть", style: .plain, target: self, action: #selector(closeTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Пропустить", style: .plain, target: self, action: #selector(skipped))
        progressView.setProgress(progress, animated: false)

        titleLabel.text = question.text
        
        switch question.answerType {
        case .multiple:
            promptLabel.text = "Выберите несколько вариантов ответа"
            
        case.single:
            promptLabel.text = "Выберите один вариант ответа"
            }

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
        
        answerButton.isEnabled = false
    }

    @IBAction func answerButtonAction(_ sender: UIButton) {
        let subviews = answersStackView.arrangedSubviews
        switch question.answerType {
        case .multiple(let correctAnswers) where chosenOptionsIndices.count > 0:
            delegate?.didTapAnswerButton(chosenOptionsIndices: chosenOptionsIndices)
            if  correctAnswerShow {
                for index in chosenOptionsIndices {
                    if correctAnswers.contains(index) {
                        subviews[index].backgroundColor = .systemGreen
                    } else {
                        subviews[index].backgroundColor = .systemRed
                    }
                }
            }
        case .single(let correctAnswer) where chosenOptionIndex != nil:
            delegate?.didTapAnswerButton(chosenOptionsIndices: [chosenOptionIndex!])
            if correctAnswerShow {
                if correctAnswer == chosenOptionIndex {
                    subviews[chosenOptionIndex!].backgroundColor = .systemGreen
                } else {
                    subviews[chosenOptionIndex!].backgroundColor = .systemRed
                }
            }
        default: break
        }
    }
    
    @objc private func handleButtonTap(sender: UIButton) {
        let tapIndex = sender.tag
        switch question.answerType {
        case .multiple:
            if let index = chosenOptionsIndices.firstIndex(of: tapIndex) {
                chosenOptionsIndices.remove(at: index)
                removeSelection(sender)
                print(chosenOptionsIndices)
                if chosenOptionsIndices.count == 0 {
                    answerButton.isEnabled = false
                } else if chosenOptionsIndices.count > 0 {
                    answerButton.isEnabled = true
                }
            } else {
                chosenOptionsIndices.insert(tapIndex)
                select(sender)
                answerButton.isEnabled = true
            }
            
        case .single:
            if let allreadyChosenOptionIndex = chosenOptionIndex {
                chosenOptionIndex = nil
                if allreadyChosenOptionIndex == tapIndex {
                    let button = answersStackView.subviews[allreadyChosenOptionIndex] as! UIButton
                    removeSelection(button)
                    answerButton.isEnabled = false
                } else {
                    chosenOptionIndex = tapIndex
                    select(sender)
                    answerButton.isEnabled = true
                    let button = answersStackView.subviews[allreadyChosenOptionIndex] as! UIButton
                    removeSelection(button)
                }
            } else {
                chosenOptionIndex = tapIndex
                select(sender)
                answerButton.isEnabled = true
            }
        }
    }
    
    func select(_ sender: UIButton) {
        sender.backgroundColor = .systemBlue
        sender.setTitleColor(.white, for: .normal)
        sender.layer.borderColor = UIColor.clear.cgColor
    }
    
    func removeSelection(_ button: UIButton) {
        button.backgroundColor = .systemGray5
        button.setTitleColor(.systemBlue, for: .normal)
        button.layer.borderColor = UIColor.blue.cgColor

    }
    
    @objc private func closeTapped() {
        delegate?.didTapClose()
    }
    
    @objc private func skipped() {
        delegate?.didTapSkip()
    }
}

