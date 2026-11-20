
import UIKit

class CourseDetailViewController: UIViewController {

    private let course: Course

    private let titleLabel = UILabel()
    private let instructorLabel = UILabel()
    private let durationLabel = UILabel()
    private let descriptionLabel = UILabel()

    init(course: Course) {
        self.course = course
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Course Details"

        setupUI()
        showCourseDetails()
    }

    private func setupUI() {

        titleLabel.font = .boldSystemFont(ofSize: 25)
        titleLabel.numberOfLines = 0

        instructorLabel.font = .systemFont(ofSize: 17)
        instructorLabel.textColor = .secondaryLabel

        durationLabel.font = .systemFont(ofSize: 16)
        durationLabel.textColor = .systemBlue

        descriptionLabel.font = .systemFont(ofSize: 16)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping

        let headingLabel = UILabel()
        headingLabel.text = "About this course"
        headingLabel.font = .boldSystemFont(ofSize: 19)

        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            instructorLabel,
            durationLabel,
            headingLabel,
            descriptionLabel
        ])

        stackView.axis = .vertical
        stackView.spacing = 18
        stackView.translatesAutoresizingMaskIntoConstraints = false

        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(scrollView)
        scrollView.addSubview(stackView)

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

            stackView.topAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.topAnchor,
                constant: 30
            ),

            stackView.leadingAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.leadingAnchor,
                constant: 25
            ),

            stackView.trailingAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.trailingAnchor,
                constant: -25
            ),

            stackView.bottomAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.bottomAnchor,
                constant: -30
            ),

            stackView.widthAnchor.constraint(
                equalTo: scrollView.frameLayoutGuide.widthAnchor,
                constant: -50
            )
        ])
    }

    private func showCourseDetails() {

        titleLabel.text = course.title
        instructorLabel.text = "Instructor: \(course.instructor)"
        durationLabel.text = "Duration: \(course.duration)"
        descriptionLabel.text = course.description
    }
}
