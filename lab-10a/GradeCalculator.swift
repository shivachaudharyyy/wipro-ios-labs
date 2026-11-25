
import Foundation

struct GradeCalculator {

    func calculateGrade(for marks: Double) -> String? {

        guard marks >= 0 && marks <= 100 else {
            return nil
        }

        switch marks {
        case 90...100:
            return "A"
        case 80..<90:
            return "B"
        case 70..<80:
            return "C"
        case 60..<70:
            return "D"
        default:
            return "F"
        }
    }
}
