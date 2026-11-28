
import XCTest
@testable import CoursePlanner

final class TestCourseStorage: CourseStorageService {

    var savedCourses: [Course] = []

    func loadCourses() throws -> [Course] {
        return savedCourses
    }

    func saveCourses(_ courses: [Course]) throws {
        savedCourses = courses
    }
}

@MainActor
final class CoursePlannerTests: XCTestCase {

    private func makeCourse(
        title: String = "Swift Programming",
        credits: Int = 3,
        totalLessons: Int = 10,
        completedLessons: Int = 5,
        endDate: Date = Date()
    ) -> Course {

        Course(
            title: title,
            instructor: "John",
            credits: credits,
            totalLessons: totalLessons,
            completedLessons: completedLessons,
            startDate: Date(),
            endDate: endDate
        )
    }

    // Test 1: Adding a course

    func testAddCourse() {

        let viewModel = CourseViewModel(
            storage: TestCourseStorage()
        )

        let result = viewModel.addCourse(
            title: "Swift",
            instructor: "John",
            credits: 3,
            totalLessons: 10,
            startDate: Date(),
            endDate: Date().addingTimeInterval(86400)
        )

        XCTAssertTrue(result)
        XCTAssertEqual(viewModel.courses.count, 1)
        XCTAssertEqual(viewModel.courses.first?.title, "Swift")
    }

    // Test 2: Deleting a course

    func testDeleteCourse() {

        let storage = TestCourseStorage()
        storage.savedCourses = [makeCourse()]

        let viewModel = CourseViewModel(storage: storage)

        let courseID = viewModel.courses[0].id

        viewModel.deleteCourse(id: courseID)

        XCTAssertTrue(viewModel.courses.isEmpty)
    }

    // Test 3: Calculating total credits

    func testTotalCredits() {

        let storage = TestCourseStorage()

        storage.savedCourses = [
            makeCourse(credits: 3),
            makeCourse(title: "Java", credits: 4)
        ]

        let viewModel = CourseViewModel(storage: storage)

        XCTAssertEqual(viewModel.totalCredits, 7)
    }

    // Test 4: Calculating average progress

    func testAverageProgress() {

        let storage = TestCourseStorage()

        storage.savedCourses = [
            makeCourse(completedLessons: 5),
            makeCourse(
                title: "Java",
                completedLessons: 10
            )
        ]

        let viewModel = CourseViewModel(storage: storage)

        XCTAssertEqual(
            viewModel.averageProgress,
            0.75,
            accuracy: 0.001
        )
    }

    // Test 5: Finding completed courses

    func testCompletedCourses() {

        let storage = TestCourseStorage()

        storage.savedCourses = [
            makeCourse(completedLessons: 10),
            makeCourse(
                title: "Java",
                completedLessons: 3
            )
        ]

        let viewModel = CourseViewModel(storage: storage)

        XCTAssertEqual(viewModel.completedCourses.count, 1)
        XCTAssertEqual(
            viewModel.completedCourses.first?.title,
            "Swift Programming"
        )
    }

    // Test 6: Sorting courses by deadline

    func testCourseSorting() {

        let storage = TestCourseStorage()

        let laterDate = Date().addingTimeInterval(86400 * 10)
        let earlierDate = Date().addingTimeInterval(86400 * 2)

        storage.savedCourses = [
            makeCourse(
                title: "Java",
                endDate: laterDate
            ),
            makeCourse(
                title: "Swift",
                endDate: earlierDate
            )
        ]

        let viewModel = CourseViewModel(storage: storage)

        XCTAssertEqual(
            viewModel.sortedCourses.first?.title,
            "Swift"
        )
    }

    // Test 7: Rejecting an empty course name

    func testEmptyCourseNameValidation() {

        let viewModel = CourseViewModel(
            storage: TestCourseStorage()
        )

        let result = viewModel.addCourse(
            title: "   ",
            instructor: "John",
            credits: 3,
            totalLessons: 10,
            startDate: Date(),
            endDate: Date()
        )

        XCTAssertFalse(result)
        XCTAssertTrue(viewModel.courses.isEmpty)
        XCTAssertNotNil(viewModel.errorMessage)
    }

    // Test 8: Updating lesson progress

    func testUpdateProgress() {

        let storage = TestCourseStorage()
        storage.savedCourses = [makeCourse()]

        let viewModel = CourseViewModel(storage: storage)

        let courseID = viewModel.courses[0].id

        let result = viewModel.updateProgress(
            courseID: courseID,
            completedLessons: 8
        )

        XCTAssertTrue(result)

        XCTAssertEqual(
            viewModel.course(for: courseID)?.completedLessons,
            8
        )
    }

    // Test 9: Handling an empty course list

    func testEmptyCourseList() {

        let viewModel = CourseViewModel(
            storage: TestCourseStorage()
        )

        XCTAssertTrue(viewModel.courses.isEmpty)
        XCTAssertEqual(viewModel.totalCredits, 0)
        XCTAssertEqual(viewModel.averageProgress, 0)
        XCTAssertTrue(viewModel.upcomingCourses.isEmpty)
    }

    // Test 10: Rejecting invalid lesson progress

    func testInvalidProgress() {

        let storage = TestCourseStorage()
        storage.savedCourses = [makeCourse()]

        let viewModel = CourseViewModel(storage: storage)

        let courseID = viewModel.courses[0].id

        let result = viewModel.updateProgress(
            courseID: courseID,
            completedLessons: 15
        )

        XCTAssertFalse(result)
        XCTAssertEqual(
            viewModel.course(for: courseID)?.completedLessons,
            5
        )
    }
}
