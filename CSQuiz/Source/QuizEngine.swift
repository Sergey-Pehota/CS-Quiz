import Foundation

class QuizEngine {
    var index = 0
    var correctAnswersCount = 0
    var wrongAnswersCount = 0
    var complexity = Complexity.easy
    var questions = Question.all
    
    var filteredQuestions: [Question] {
        questions.filter { $0.complexity == complexity }
    }
    
    var filteredQuestionsCount: Int {
        filteredQuestions.count
    }
    
    func finish() {
        index = 0
        correctAnswersCount = 0
        wrongAnswersCount = 0
    }
}
