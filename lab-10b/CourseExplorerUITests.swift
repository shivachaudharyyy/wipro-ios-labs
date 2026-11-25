
import XCTest

final class CourseExplorerUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    // Successful Registration

    func testUserCanRegisterSuccessfully() {

        let nameField = app.textFields["nameField"]
        let emailField = app.textFields["emailField"]
        let submitButton = app.buttons["submitButton"]

        XCTAssertTrue(nameField.waitForExistence(timeout: 5))
        XCTAssertTrue(emailField.exists)

        nameField.tap()
        nameField.typeText("Rahul Sharma")

        emailField.tap()
        emailField.typeText("rahul@example.com")

        XCTAssertTrue(submitButton.isEnabled)

        submitButton.tap()

        let successMessage = app.staticTexts["successMessage"]

        XCTAssertTrue(
            successMessage.waitForExistence(timeout: 5),
            "Registration success message should appear."
        )
    }

    // Empty Form Validation

    func testSubmitButtonIsDisabledForEmptyForm() {

        let submitButton = app.buttons["submitButton"]

        XCTAssertTrue(submitButton.waitForExistence(timeout: 5))

        XCTAssertFalse(
            submitButton.isEnabled,
            "Submit button should remain disabled when fields are empty."
        )

        XCTAssertFalse(
            app.staticTexts["successMessage"].exists
        )
    }
}
