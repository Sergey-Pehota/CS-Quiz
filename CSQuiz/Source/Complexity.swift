import Foundation

enum Complexity: Int, CaseIterable {
    case easy, medium, hard
}

extension Complexity {
    var title: String {
        switch self {
        case .easy: return "Легко"
        case .medium: return "Средне"
        case .hard: return "Сложно"
        }
    }
}
