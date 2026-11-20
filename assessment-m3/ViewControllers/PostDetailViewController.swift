
import UIKit

class PostDetailViewController: UIViewController {

    //  Properties

    private let post: Post
    private let student: Student

    // UI Elements

    private let scrollView = UIScrollView()
    private let contentStack = UIStackView()

    private let postIdLabel = UILabel()
    private let titleLabel = UILabel()
    private let bodyLabel = UILabel()
    private let studentLabel = UILabel()

    // Initializer

    init(post: Post, student: Student) {

        self.post = post
        self.student = student

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        return nil
    }

    //  Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Post Details"

        setupUI()
        displayPost()
    }

    // UI Setup

    private func setupUI() {

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentStack.translatesAutoresizingMaskIntoConstraints = false

        contentStack.axis = .vertical
        contentStack.spacing = 20
        contentStack.alignment = .fill

        view.addSubview(scrollView)
        scrollView.addSubview(contentStack)

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

            contentStack.topAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.topAnchor,
                constant: 25
            ),

            contentStack.leadingAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.leadingAnchor,
                constant: 22
            ),

            contentStack.trailingAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.trailingAnchor,
                constant: -22
            ),

            contentStack.bottomAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.bottomAnchor,
                constant: -25
            ),

            contentStack.widthAnchor.constraint(
                equalTo: scrollView.frameLayoutGuide.widthAnchor,
                constant: -44
            )
        ])

        studentLabel.font = .systemFont(ofSize: 14)
        studentLabel.textColor = .secondaryLabel
        studentLabel.numberOfLines = 0

        postIdLabel.font = .boldSystemFont(ofSize: 15)
        postIdLabel.textColor = .systemBlue

        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.textColor = .label
        titleLabel.numberOfLines = 0

        bodyLabel.font = .systemFont(ofSize: 17)
        bodyLabel.textColor = .secondaryLabel
        bodyLabel.numberOfLines = 0

        studentLabel.accessibilityLabel = "Student information"
        postIdLabel.accessibilityLabel = "Post identification number"
        titleLabel.accessibilityLabel = "Post title"
        bodyLabel.accessibilityLabel = "Post description"

        contentStack.addArrangedSubview(studentLabel)
        contentStack.addArrangedSubview(postIdLabel)
        contentStack.addArrangedSubview(titleLabel)
        contentStack.addArrangedSubview(bodyLabel)
    }

    //  Display Post

    private func displayPost() {

        studentLabel.text = "Opened by: \(student.name)"

        postIdLabel.text = "POST #\(post.id)"

        titleLabel.text = post.title.capitalized

        bodyLabel.text = post.body.capitalized
    }
}
