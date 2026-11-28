
import Foundation

struct Course: Identifiable, Codable, Equatable {

    var id: UUID
    var title: String
    var instructor: String
    var credits: Int
    var totalLessons: Int
    var completedLessons: Int
    var startDate: Date
    var endDate: Date

    init(
        id: UUID = UUID(),
        title: String,
        instructor: String,
        credits: Int,
        totalLessons: Int,
        completedLessons: Int = 0,
        startDate: Date,
        endDate: Date
    ) {
        self.id = id
        self.title = title
        self.instructor = instructor
        self.credits = credits
        self.totalLessons = totalLessons
        self.completedLessons = completedLessons
        self.startDate = startDate
        self.endDate = endDate
    }

    var progress: Double {
        guard totalLessons > 0 else {
            return 0
        }

        return Double(completedLessons) / Double(totalLessons)
    }

    var remainingLessons: Int {
        totalLessons - completedLessons
    }

    var isCompleted: Bool {
        completedLessons == totalLessons
    }
}
