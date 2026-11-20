
import UIKit

class CourseCell: UITableViewCell {

    static let identifier = "CourseCell"

    private let courseTitle = UILabel()
    private let instructorName = UILabel()
    private let courseDuration = UILabel()

    private let stackView = UIStackView()

    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupCell()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }

    private func setupCell() {

        courseTitle.font = .boldSystemFont(ofSize: 17)
        courseTitle.textColor = .label
        courseTitle.numberOfLines = 0

        instructorName.font = .systemFont(ofSize: 14)
        instructorName.textColor = .secondaryLabel

        courseDuration.font = .systemFont(ofSize: 13)
        courseDuration.textColor = .systemBlue

        stackView.axis = .vertical
        stackView.spacing = 6
        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackView.addArrangedSubview(courseTitle)
        stackView.addArrangedSubview(instructorName)
        stackView.addArrangedSubview(courseDuration)

        contentView.addSubview(stackView)

        NSLayoutConstraint.activate([

            stackView.topAnchor.constraint(
                equalTo: contentView.layoutMarginsGuide.topAnchor
            ),

            stackView.leadingAnchor.constraint(
                equalTo: contentView.layoutMarginsGuide.leadingAnchor
            ),

            stackView.trailingAnchor.constraint(
                equalTo: contentView.layoutMarginsGuide.trailingAnchor
            ),

            stackView.bottomAnchor.constraint(
                equalTo: contentView.layoutMarginsGuide.bottomAnchor
            )
        ])

        accessoryType = .disclosureIndicator
        selectionStyle = .default
    }

    func configure(with course: Course) {

        courseTitle.text = course.title
        instructorName.text = "Instructor: \(course.instructor)"
        courseDuration.text = "Duration: \(course.duration)"

        accessibilityLabel = "\(course.title), instructor \(course.instructor), duration \(course.duration)"
    }
}
