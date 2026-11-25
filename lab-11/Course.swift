
import Foundation

struct Course: Identifiable {

    let id: Int
    let title: String
    let category: String
    let duration: String

    static let sampleCourses: [Course] = {

        var courses: [Course] = []

        for number in 1...5000 {

            let course = Course(
                id: number,
                title: String(
                    format: "Course %05d",
                    number
                ),
                category: number % 2 == 0
                    ? "Development"
                    : "Design",
                duration: "\(number % 8 + 1) Weeks"
            )

            courses.append(course)
        }

        return courses
    }()
}
