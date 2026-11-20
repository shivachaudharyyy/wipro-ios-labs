
import UIKit

class RegistrationViewController: UIViewController, UITextFieldDelegate {

    // UI Elements

    private let nameField = UITextField()
    private let emailField = UITextField()
    private let courseField = UITextField()

    private let errorLabel = UILabel()
    private let submitButton = UIButton(type: .system)

    private let scrollView = UIScrollView()
    private let formStack = UIStackView()

    //Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Student Registration"

        setupUI()
        setupKeyboard()
    }

    //UI Setup

    private func setupUI() {

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        formStack.translatesAutoresizingMaskIntoConstraints = false

        formStack.axis = .vertical
        formStack.spacing = 18

        view.addSubview(scrollView)
        scrollView.addSubview(formStack)

        NSLayoutConstraint.activate([

            scrollView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),

            scrollView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),

            scrollView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),

            scrollView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor
            ),

            formStack.topAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.topAnchor,
                constant: 35
            ),

            formStack.leadingAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.leadingAnchor,
                constant: 24
            ),

            formStack.trailingAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.trailingAnchor,
                constant: -24
            ),

            formStack.bottomAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.bottomAnchor,
                constant: -30
            ),

            formStack.widthAnchor.constraint(
                equalTo: scrollView.frameLayoutGuide.widthAnchor,
                constant: -48
            )
        ])

        let heading = UILabel()
        heading.text = "Create Your Profile"
        heading.font = .boldSystemFont(ofSize: 26)
        heading.textColor = .label

        let description = UILabel()
        description.text = "Enter your details to continue."
        description.font = .systemFont(ofSize: 15)
        description.textColor = .secondaryLabel

        setupTextFields()

        errorLabel.textColor = .systemRed
        errorLabel.font = .systemFont(ofSize: 14)
        errorLabel.numberOfLines = 0
        errorLabel.isHidden = true
        errorLabel.accessibilityLabel = "Form validation error"

        submitButton.setTitle("Continue", for: .normal)
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.backgroundColor = .systemBlue
        submitButton.titleLabel?.font = .boldSystemFont(ofSize: 17)
        submitButton.layer.cornerRadius = 10
        submitButton.heightAnchor.constraint(
            equalToConstant: 50
        ).isActive = true

        submitButton.accessibilityLabel = "Submit registration"

        submitButton.addTarget(
            self,
            action: #selector(submitForm),
            for: .touchUpInside
        )

        formStack.addArrangedSubview(heading)
        formStack.addArrangedSubview(description)

        addField(title: "Full Name", field: nameField)
        addField(title: "Email Address", field: emailField)
        addField(title: "Course", field: courseField)

        formStack.addArrangedSubview(errorLabel)
        formStack.addArrangedSubview(submitButton)
    }

    // Text Fields

    private func setupTextFields() {

        nameField.placeholder = "Enter your full name"
        nameField.autocapitalizationType = .words
        nameField.textContentType = .name
        nameField.accessibilityLabel = "Full name"

        emailField.placeholder = "Enter your email"
        emailField.keyboardType = .emailAddress
        emailField.autocapitalizationType = .none
        emailField.autocorrectionType = .no
        emailField.textContentType = .emailAddress
        emailField.accessibilityLabel = "Email address"

        courseField.placeholder = "Enter your course"
        courseField.autocapitalizationType = .words
        courseField.accessibilityLabel = "Course"

        let fields = [nameField, emailField, courseField]

        for field in fields {

            field.borderStyle = .roundedRect
            field.font = .systemFont(ofSize: 16)
            field.heightAnchor.constraint(
                equalToConstant: 48
            ).isActive = true

            field.delegate = self
        }

        nameField.returnKeyType = .next
        emailField.returnKeyType = .next
        courseField.returnKeyType = .done
    }

    private func addField(title: String, field: UITextField) {

        let label = UILabel()
        label.text = title
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .label

        formStack.addArrangedSubview(label)
        formStack.addArrangedSubview(field)
    }

    //Form Validation

    private func validateForm() -> Bool {

        let name = nameField.text?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        let email = emailField.text?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        let course = courseField.text?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        if name.isEmpty {
            showError("Please enter your name.")
            return false
        }

        if email.isEmpty {
            showError("Please enter your email address.")
            return false
        }

        if !isValidEmail(email) {
            showError("Please enter a valid email address.")
            return false
        }

        if course.isEmpty {
            showError("Please enter your course.")
            return false
        }

        errorLabel.isHidden = true
        return true
    }

    private func isValidEmail(_ email: String) -> Bool {

        let emailPattern =
            #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#

        return email.range(
            of: emailPattern,
            options: .regularExpression
        ) != nil
    }

    private func showError(_ message: String) {

        errorLabel.text = message
        errorLabel.isHidden = false
    }

    //Submit Form

    @objc private func submitForm() {

        view.endEditing(true)

        guard validateForm() else {
            return
        }

        let student = Student(
            name: nameField.text?
                .trimmingCharacters(in: .whitespacesAndNewlines) ?? "",
            email: emailField.text?
                .trimmingCharacters(in: .whitespacesAndNewlines) ?? "",
            course: courseField.text?
                .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        )

        let postsVC = PostsViewController(student: student)

        navigationController?.pushViewController(
            postsVC,
            animated: true
        )
    }

    //Keyboard Handling

    private func setupKeyboard() {

        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(hideKeyboard)
        )

        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func hideKeyboard() {

        view.endEditing(true)
    }

    func textFieldShouldReturn(
        _ textField: UITextField
    ) -> Bool {

        if textField == nameField {
            emailField.becomeFirstResponder()
        } else if textField == emailField {
            courseField.becomeFirstResponder()
        } else {
            courseField.resignFirstResponder()
            submitForm()
        }

        return true
    }
}
