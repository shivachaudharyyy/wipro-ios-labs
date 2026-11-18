
import UIKit

class ViewController: UIViewController {

    let titleLabel = UILabel()
    let nameTextField = UITextField()
    let submitButton = UIButton(type: .system)
    let resultLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        setupUI()
    }

    func setupUI() {

        // Title label
        titleLabel.text = "Welcome Screen"
        titleLabel.font = .boldSystemFont(ofSize: 28)
        titleLabel.textAlignment = .center

        // Text field
        nameTextField.placeholder = "Enter your name"
        nameTextField.borderStyle = .roundedRect

        // Submit button
        submitButton.setTitle("Submit", for: .normal)
        submitButton.backgroundColor = .systemBlue
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.layer.cornerRadius = 10

        // Result label
        resultLabel.text = "Your result will appear here"
        resultLabel.font = .systemFont(ofSize: 18)
        resultLabel.textAlignment = .center
        resultLabel.textColor = .gray
        resultLabel.numberOfLines = 0

        // Add views to screen
        view.addSubview(titleLabel)
        view.addSubview(nameTextField)
        view.addSubview(submitButton)
        view.addSubview(resultLabel)

        // Enable Auto Layout
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        resultLabel.translatesAutoresizingMaskIntoConstraints = false

        // Set constraints
        NSLayoutConstraint.activate([

            titleLabel.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 60
            ),
            titleLabel.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),

            nameTextField.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 30
            ),
            nameTextField.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 30
            ),
            nameTextField.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -30
            ),

            submitButton.topAnchor.constraint(
                equalTo: nameTextField.bottomAnchor,
                constant: 20
            ),
            submitButton.leadingAnchor.constraint(
                equalTo: nameTextField.leadingAnchor
            ),
            submitButton.trailingAnchor.constraint(
                equalTo: nameTextField.trailingAnchor
            ),
            submitButton.heightAnchor.constraint(equalToConstant: 45),

            resultLabel.topAnchor.constraint(
                equalTo: submitButton.bottomAnchor,
                constant: 25
            ),
            resultLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 20
            ),
            resultLabel.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -20
            )
        ])

        // Connect button to action
        submitButton.addTarget(
            self,
            action: #selector(submitButtonTapped),
            for: .touchUpInside
        )
    }

    // Button action
    @objc func submitButtonTapped() {

        let name = nameTextField.text ?? ""

        if name.isEmpty {
            resultLabel.text = "Please enter your name"
        } else {
            resultLabel.text = "Hello, \(name)!"
        }
    }
}
