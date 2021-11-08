import UIKit

protocol QuestionViewControllerDelegate {
    func didTapChooseButton(chosenOption: String)
    func didTapAnswerButton()
    func didTapSkip()
    func didTapClose()
}

final class QuestionViewController: UIViewController {
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var answersStackView: UIStackView!
    
    var delegate: QuestionViewControllerDelegate?
    
    var question: Question!
    var progress: Float!
    var chosenOptionsIndices = [Int]()
//    var singleAnswersIndices = [Int]()
    var chosenOptionIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Закрыть", style: .plain, target: self, action: #selector(closeTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Пропустить", style: .plain, target: self, action: #selector(skipped))
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

    @IBAction func answerButtonAction(_ sender: Any) {
        delegate?.didTapAnswerButton()
    }
    
    @objc private func handleButtonTap(sender: UIButton) {
        let tapIndex = sender.tag
        let chosenOption = question.answers[tapIndex]
        delegate?.didTapChooseButton(chosenOption: chosenOption)

        
        switch question.selectionType {
        case .multiple:
            if let index = chosenOptionsIndices.firstIndex(of: tapIndex) {
    //            1. Удалить этот элемент из массива
                chosenOptionsIndices.remove(at: index)
    //            2. Убрать выделение (кнопки)
                sender.backgroundColor = .systemGray5
                sender.setTitleColor(.systemBlue, for: .normal)
                sender.layer.borderColor = UIColor.blue.cgColor
            } else {
                chosenOptionsIndices.append(tapIndex)
                sender.backgroundColor = .systemBlue
                sender.setTitleColor(.white, for: .normal)
                sender.layer.borderColor = UIColor.clear.cgColor
            }
            
        case .single:
            if let allreadyChosenOptionIndex = chosenOptionIndex {
                chosenOptionIndex = nil
                if allreadyChosenOptionIndex == tapIndex {
                    let button = answersStackView.subviews[allreadyChosenOptionIndex] as! UIButton
                   removeSelection(button)
                } else {
                    chosenOptionIndex = tapIndex
                    select(sender)
                    let button = answersStackView.subviews[allreadyChosenOptionIndex] as! UIButton
                    removeSelection(button)
                }
            } else {
                chosenOptionIndex = tapIndex
                select(sender)
            }
//
//            singleAnswersIndices.append(tapIndex)
//            let firstIndex = singleAnswersIndices[0]
//            if singleAnswersIndices.count == 1 {
//                let button = answersStackView.subviews[firstIndex] as! UIButton
//                select(button)
//            } else if singleAnswersIndices.count > 1 && firstIndex == singleAnswersIndices[1] {
//                removeSelection(sender)
//                singleAnswersIndices.remove(at: 0)
//            } else if singleAnswersIndices.count > 1 {
//                let secondIndex = singleAnswersIndices[1]
//                let button = answersStackView.subviews[firstIndex] as! UIButton
//               removeSelection(button)
//                let secondButton = answersStackView.subviews[secondIndex] as! UIButton
//                select(secondButton)
//                singleAnswersIndices.remove(at: 0)
//            }
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
