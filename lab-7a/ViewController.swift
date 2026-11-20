
import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    let nameField = UITextField()
    let emailField = UITextField()
    let courseField = UITextField()

    let nameError = UILabel()
    let emailError = UILabel()
    let courseError = UILabel()

    let submitButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Profile Form"

        setupForm()
        setupKeyboard()
    }

    func setupForm() {

        let heading = UILabel()
        heading.text = "Create Your Profile"
        heading.font = .boldSystemFont(ofSize: 26)
        heading.textAlignment = .center

        let description = UILabel()
        description.text = "Enter your details below"
        description.textColor = .secondaryLabel
        description.textAlignment = .center

        setupTextField(nameField, placeholder: "Enter your name")
        setupTextField(emailField, placeholder: "Enter your email")
        setupTextField(courseField, placeholder: "Enter your course")

        nameField.keyboardType = .default
        nameField.textContentType = .name
        nameField.returnKeyType = .next

        emailField.keyboardType = .emailAddress
        emailField.textContentType = .emailAddress
        emailField.autocapitalizationType = .none
        emailField.returnKeyType = .next

        courseField.keyboardType = .default
        courseField.returnKeyType = .done

        nameField.delegate = self
        emailField.delegate = self
        courseField.delegate = self

        setupErrorLabel(nameError)
        setupErrorLabel(emailError)
        setupErrorLabel(courseError)

        submitButton.setTitle("Submit", for: .normal)
        submitButton.titleLabel?.font = .boldSystemFont(ofSize: 17)
        submitButton.backgroundColor = .systemBlue
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.layer.cornerRadius = 10
        submitButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        submitButton.accessibilityLabel = "Submit profile"
        submitButton.addTarget(
            self,
            action: #selector(submitForm),
            for: .touchUpInside
        )

        let formStack = UIStackView()
        formStack.axis = .vertical
        formStack.spacing = 12
        formStack.translatesAutoresizingMaskIntoConstraints = false

        formStack.addArrangedSubview(heading)
        formStack.addArrangedSubview(description)

        addField(
            to: formStack,
            title: "Full Name",
            field: nameField,
            error: nameError
        )

        addField(
            to: formStack,
            title: "Email Address",
            field: emailField,
            error: emailError
        )

        addField(
            to: formStack,
            title: "Course",
            field: courseField,
            error: courseError
        )

        formStack.setCustomSpacing(20, after: description)
        formStack.addArrangedSubview(submitButton)

        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.keyboardDismissMode = .interactive

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
                equalTo: view.bottomAnchor
            ),

            formStack.topAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.topAnchor,
                constant: 35
            ),

            formStack.leadingAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.leadingAnchor,
                constant: 25
            ),

            formStack.trailingAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.trailingAnchor,
                constant: -25
            ),

            formStack.bottomAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.bottomAnchor,
                constant: -30
            ),

            formStack.widthAnchor.constraint(
                equalTo: scrollView.frameLayoutGuide.widthAnchor,
                constant: -50
            )
        ])
    }

    func setupTextField(
        _ field: UITextField,
        placeholder: String
    ) {

        field.placeholder = placeholder
        field.borderStyle = .roundedRect
        field.font = .systemFont(ofSize: 16)
        field.heightAnchor.constraint(
            equalToConstant: 48
        ).isActive = true

        field.accessibilityLabel = placeholder
        field.clearButtonMode = .whileEditing
    }

    func setupErrorLabel(_ label: UILabel) {

        label.textColor = .systemRed
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.isHidden = true
    }

    func addField(
        to stack: UIStackView,
        title: String,
        field: UITextField,
        error: UILabel
    ) {

        let label = UILabel()
        label.text = title
        label.font = .boldSystemFont(ofSize: 15)

        stack.addArrangedSubview(label)
        stack.addArrangedSubview(field)
        stack.addArrangedSubview(error)
    }

    @objc func submitForm() {

        view.endEditing(true)

        var isValid = true

        if nameField.text?.trimmingCharacters(
            in: .whitespacesAndNewlines
        ).isEmpty ?? true {

            nameError.text = "Please enter your name."
            nameError.isHidden = false
            isValid = false

        } else {
            nameError.isHidden = true
        }

        let email = emailField.text?.trimmingCharacters(
            in: .whitespacesAndNewlines
        ) ?? ""

        if email.isEmpty {

            emailError.text = "Please enter your email."
            emailError.isHidden = false
            isValid = false

        } else if !isValidEmail(email) {

            emailError.text = "Please enter a valid email address."
            emailError.isHidden = false
            isValid = false

        } else {
            emailError.isHidden = true
        }

        if courseField.text?.trimmingCharacters(
            in: .whitespacesAndNewlines
        ).isEmpty ?? true {

            courseError.text = "Please enter your course."
            courseError.isHidden = false
            isValid = false

        } else {
            courseError.isHidden = true
        }

        if isValid {
            showSuccessMessage()
        }
    }

    func isValidEmail(_ email: String) -> Bool {

        let emailPattern =
            #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#

        return email.range(
            of: emailPattern,
            options: .regularExpression
        ) != nil
    }

    func showSuccessMessage() {

        let alert = UIAlertController(
            title: "Success",
            message: "Your profile has been submitted successfully!",
            preferredStyle: .alert
        )

        alert.addAction(
            UIAlertAction(title: "OK", style: .default)
        )

        present(alert, animated: true)
    }

    func setupKeyboard() {

        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(hideKeyboard)
        )

        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc func hideKeyboard() {
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
            textField.resignFirstResponder()
        }

        return true
    }
}
