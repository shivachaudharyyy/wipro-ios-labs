
import Foundation
import Combine

// Course Model

struct Course: Identifiable, Equatable {

    let id: Int
    let title: String
    let category: String
    let duration: String
}

// Course Service

protocol CourseServiceProtocol {
    func fetchCourses() throws -> [Course]
}

// Sample Data

struct SampleCourseService: CourseServiceProtocol {

    func fetchCourses() throws -> [Course] {

        return [
            Course(
                id: 1,
                title: "SwiftUI Fundamentals",
                category: "iOS Development",
                duration: "4 Weeks"
            ),

            Course(
                id: 2,
                title: "Advanced Swift",
                category: "Programming",
                duration: "6 Weeks"
            ),

            Course(
                id: 3,
                title: "UI Design Basics",
                category: "Design",
                duration: "3 Weeks"
            )
        ]
    }
}

// Course ViewModel

@MainActor
final class CourseViewModel: ObservableObject {

    @Published private(set) var courses: [Course] = []
    @Published private(set) var errorMessage: String?

    private let courseService: CourseServiceProtocol

    init(
        courseService: CourseServiceProtocol = SampleCourseService()
    ) {
        self.courseService = courseService
    }

    func loadCourses() {

        do {
            let availableCourses = try courseService.fetchCourses()

            courses = availableCourses
            errorMessage = nil

        } catch {

            courses = []
            errorMessage = error.localizedDescription
        }
    }
}
