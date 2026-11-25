
import XCTest
@testable import CourseExplorer

//  Grade Calculator Tests

final class GradeCalculatorTests: XCTestCase {

    private let calculator = GradeCalculator()

    func testGradeForExcellentMarks() {

        XCTAssertEqual(
            calculator.calculateGrade(for: 95),
            "A"
        )
    }

    func testGradeForAverageMarks() {

        XCTAssertEqual(
            calculator.calculateGrade(for: 75),
            "C"
        )
    }

    func testGradeAtBoundaryMarks() {

        XCTAssertEqual(
            calculator.calculateGrade(for: 90),
            "A"
        )

        XCTAssertEqual(
            calculator.calculateGrade(for: 80),
            "B"
        )

        XCTAssertEqual(
            calculator.calculateGrade(for: 60),
            "D"
        )
    }

    func testGradeForZeroMarks() {

        XCTAssertEqual(
            calculator.calculateGrade(for: 0),
            "F"
        )
    }

    func testInvalidMarksReturnNil() {

        XCTAssertNil(
            calculator.calculateGrade(for: -5)
        )

        XCTAssertNil(
            calculator.calculateGrade(for: 105)
        )
    }
}


//  Registration Validation Tests

final class RegistrationValidatorTests: XCTestCase {

    private let validator = RegistrationValidator()

    func testValidRegistrationDetails() {

        XCTAssertTrue(
            validator.isValidRegistration(
                name: "Rahul Sharma",
                email: "rahul@example.com"
            )
        )
    }

    func testEmptyNameIsRejected() {

        XCTAssertFalse(
            validator.isValidName("   ")
        )
    }

    func testInvalidEmailIsRejected() {

        XCTAssertFalse(
            validator.isValidEmail("rahul.com")
        )

        XCTAssertFalse(
            validator.isValidEmail("rahul@")
        )
    }

    func testEmailWithExtraSpaces() {

        XCTAssertTrue(
            validator.isValidEmail(
                " rahul@example.com "
            )
        )
    }
}


// ViewModel Tests

@MainActor
final class CourseViewModelTests: XCTestCase {

    func testCoursesLoadSuccessfully() {

        let fakeService = FakeCourseService()

        let viewModel = CourseViewModel(
            courseService: fakeService
        )

        viewModel.loadCourses()

        XCTAssertEqual(viewModel.courses.count, 2)

        XCTAssertEqual(
            viewModel.courses[0].title,
            "SwiftUI Basics"
        )

        XCTAssertNil(viewModel.errorMessage)
    }

    func testViewModelHandlesServiceError() {

        let fakeService = FakeCourseService(
            shouldFail: true
        )

        let viewModel = CourseViewModel(
            courseService: fakeService
        )

        viewModel.loadCourses()

        XCTAssertTrue(viewModel.courses.isEmpty)
        XCTAssertNotNil(viewModel.errorMessage)
    }
}


// Fake Course Service

private struct FakeCourseService: CourseServiceProtocol {

    var shouldFail = false

    func fetchCourses() throws -> [Course] {

        if shouldFail {

            throw NSError(
                domain: "CourseServiceError",
                code: 404,
                userInfo: [
                    NSLocalizedDescriptionKey:
                        "Unable to load courses."
                ]
            )
        }

        return [
            Course(
                id: 1,
                title: "SwiftUI Basics",
                category: "Development",
                duration: "4 Weeks"
            ),

            Course(
                id: 2,
                title: "iOS Development",
                category: "Programming",
                duration: "6 Weeks"
            )
        ]
    }
}
