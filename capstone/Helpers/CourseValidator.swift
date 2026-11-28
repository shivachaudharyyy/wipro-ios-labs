
import Foundation

struct CourseValidator {

    static func validate(
        title: String,
        instructor: String,
        credits: Int,
        totalLessons: Int,
        completedLessons: Int,
        startDate: Date,
        endDate: Date
    ) -> String? {

        if title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return "Please enter a course name."
        }

        if instructor.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return "Please enter the instructor name."
        }

        if credits <= 0 {
            return "Credits must be greater than zero."
        }

        if totalLessons <= 0 {
            return "Total lessons must be greater than zero."
        }

        if completedLessons < 0 || completedLessons > totalLessons {
            return "Completed lessons must be between zero and total lessons."
        }

        if endDate < startDate {
            return "End date cannot be before the start date."
        }

        return nil
    }
}
