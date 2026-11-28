
import Foundation
import Combine

@MainActor
final class CourseViewModel: ObservableObject {

    @Published private(set) var courses: [Course] = []
    @Published var errorMessage: String?

    private let storage: CourseStorageService

    init(storage: CourseStorageService = UserDefaultsCourseStorage()) {
        self.storage = storage
        loadCourses()
    }

    // Loading and Saving

    func loadCourses() {

        do {
            courses = try storage.loadCourses()
        } catch {
            errorMessage = "Unable to load saved courses."
        }
    }

    private func saveCourses() {

        do {
            try storage.saveCourses(courses)
        } catch {
            errorMessage = "Unable to save courses. Please try again."
        }
    }

    // Adding a Course

    @discardableResult
    func addCourse(
        title: String,
        instructor: String,
        credits: Int,
        totalLessons: Int,
        startDate: Date,
        endDate: Date
    ) -> Bool {

        let cleanTitle = title.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        let cleanInstructor = instructor.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        if let error = CourseValidator.validate(
            title: cleanTitle,
            instructor: cleanInstructor,
            credits: credits,
            totalLessons: totalLessons,
            completedLessons: 0,
            startDate: startDate,
            endDate: endDate
        ) {
            errorMessage = error
            return false
        }

        let newCourse = Course(
            title: cleanTitle,
            instructor: cleanInstructor,
            credits: credits,
            totalLessons: totalLessons,
            startDate: startDate,
            endDate: endDate
        )

        courses.append(newCourse)
        saveCourses()

        return true
    }

    // Deleting a Course

    func deleteCourse(id: UUID) {

        courses.removeAll { course in
            course.id == id
        }

        saveCourses()
    }

    //  Updating Progress

    @discardableResult
    func updateProgress(
        courseID: UUID,
        completedLessons: Int
    ) -> Bool {

        guard let index = courses.firstIndex(where: {
            $0.id == courseID
        }) else {
            errorMessage = "Course not found."
            return false
        }

        guard completedLessons >= 0,
              completedLessons <= courses[index].totalLessons else {
            errorMessage = "Invalid lesson progress."
            return false
        }

        courses[index].completedLessons = completedLessons

        saveCourses()
        return true
    }

    // Finding a Course

    func course(for id: UUID) -> Course? {
        courses.first { $0.id == id }
    }

    // Collection Transformations

    var totalCredits: Int {
        courses.reduce(0) { total, course in
            total + course.credits
        }
    }

    var averageProgress: Double {

        guard !courses.isEmpty else {
            return 0
        }

        let totalProgress = courses.reduce(0.0) {
            $0 + $1.progress
        }

        return totalProgress / Double(courses.count)
    }

    var completedCourses: [Course] {
        courses.filter { $0.isCompleted }
    }

    var activeCourses: [Course] {
        courses.filter { !$0.isCompleted }
    }

    var sortedCourses: [Course] {
        courses.sorted {
            $0.endDate < $1.endDate
        }
    }

    var upcomingCourses: [Course] {

        let today = Calendar.current.startOfDay(for: Date())

        return courses
            .filter {
                $0.endDate >= today && !$0.isCompleted
            }
            .sorted {
                $0.endDate < $1.endDate
            }
    }

    func clearError() {
        errorMessage = nil
    }
}
