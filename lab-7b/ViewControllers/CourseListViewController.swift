
import UIKit

class CourseListViewController: UIViewController,
                                UITableViewDataSource,
                                UITableViewDelegate {

    private let tableView = UITableView()

    private var courses = Course.sampleCourses

    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "No courses available."
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Available Courses"
        view.backgroundColor = .systemBackground

        setupTableView()
        updateEmptyState()
    }

    private func setupTableView() {

        tableView.translatesAutoresizingMaskIntoConstraints = false

        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(
            CourseCell.self,
            forCellReuseIdentifier: CourseCell.identifier
        )

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 90

        view.addSubview(tableView)

        NSLayoutConstraint.activate([

            tableView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),

            tableView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),

            tableView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),

            tableView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor
            )
        ])
    }

    // Number of rows in the table
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {

        return courses.count
    }

    // Display course information in each row
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(
            withIdentifier: CourseCell.identifier,
            for: indexPath
        )

        guard let courseCell = cell as? CourseCell else {
            return cell
        }

        let selectedCourse = courses[indexPath.row]
        courseCell.configure(with: selectedCourse)

        return courseCell
    }

    // Navigate to the detail screen
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {

        tableView.deselectRow(at: indexPath, animated: true)

        let selectedCourse = courses[indexPath.row]

        let detailVC = CourseDetailViewController(
            course: selectedCourse
        )

        navigationController?.pushViewController(
            detailVC,
            animated: true
        )
    }

    // Show a message if the list is empty
    private func updateEmptyState() {

        tableView.backgroundView = courses.isEmpty ? emptyLabel : nil
        tableView.reloadData()
    }
}
