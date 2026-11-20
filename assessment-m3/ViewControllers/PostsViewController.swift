
import UIKit

class PostsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //Properties

    private let student: Student
    private let postService = PostService()

    private var posts: [Post] = []

    // UI Elements

    private let tableView = UITableView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let statusLabel = UILabel()
    private let retryButton = UIButton(type: .system)

    // Initializer

    init(student: Student) {
        self.student = student
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        return nil
    }

    // Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Posts"

        setupUI()
        fetchPosts()
    }

    //UI Setup

    private func setupUI() {

        tableView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        retryButton.translatesAutoresizingMaskIntoConstraints = false

        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: "PostCell"
        )

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 90

        statusLabel.textAlignment = .center
        statusLabel.numberOfLines = 0
        statusLabel.font = .systemFont(ofSize: 16)
        statusLabel.textColor = .secondaryLabel
        statusLabel.isHidden = true

        activityIndicator.hidesWhenStopped = true

        retryButton.setTitle("Try Again", for: .normal)
        retryButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        retryButton.isHidden = true
        retryButton.accessibilityLabel = "Retry loading posts"

        retryButton.addTarget(
            self,
            action: #selector(retryLoading),
            for: .touchUpInside
        )

        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        view.addSubview(statusLabel)
        view.addSubview(retryButton)

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
                equalTo: view.safeAreaLayoutGuide.bottomAnchor
            ),

            activityIndicator.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),

            activityIndicator.centerYAnchor.constraint(
                equalTo: view.centerYAnchor,
                constant: -35
            ),

            statusLabel.topAnchor.constraint(
                equalTo: activityIndicator.bottomAnchor,
                constant: 15
            ),

            statusLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 25
            ),

            statusLabel.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -25
            ),

            retryButton.topAnchor.constraint(
                equalTo: statusLabel.bottomAnchor,
                constant: 15
            ),

            retryButton.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            )
        ])
    }

    // Fetch Posts

    private func fetchPosts() {

        activityIndicator.startAnimating()

        tableView.isHidden = true
        statusLabel.isHidden = true
        retryButton.isHidden = true

        Task {

            do {

                let result = try await postService.fetchPosts()

                posts = result

                activityIndicator.stopAnimating()

                if posts.isEmpty {

                    showEmptyState()

                } else {

                    showPosts()
                }

            } catch {

                activityIndicator.stopAnimating()

                showFailure(error.localizedDescription)
            }
        }
    }

    // Display States

    private func showPosts() {

        statusLabel.isHidden = true
        retryButton.isHidden = true
        tableView.isHidden = false

        tableView.reloadData()
    }

    private func showEmptyState() {

        tableView.isHidden = true

        statusLabel.text = "No posts available right now."
        statusLabel.isHidden = false

        retryButton.isHidden = false
    }

    private func showFailure(_ message: String) {

        tableView.isHidden = true

        statusLabel.text = """
        Unable to load posts.

        \(message)
        """

        statusLabel.isHidden = false
        retryButton.isHidden = false
    }

    //  Retry

    @objc private func retryLoading() {

        fetchPosts()
    }

    // Table View Data Source

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {

        return posts.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(
            withIdentifier: "PostCell",
            for: indexPath
        )

        let post = posts[indexPath.row]

        var content = cell.defaultContentConfiguration()

        content.text = post.title.capitalized
        content.secondaryText = "Post ID: \(post.id)"

        content.textProperties.numberOfLines = 2
        content.secondaryTextProperties.color = .secondaryLabel

        cell.contentConfiguration = content
        cell.accessoryType = .disclosureIndicator

        return cell
    }

    // Table View Navigation

    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {

        tableView.deselectRow(
            at: indexPath,
            animated: true
        )

        let selectedPost = posts[indexPath.row]

        let detailVC = PostDetailViewController(
            post: selectedPost,
            student: student
        )

        navigationController?.pushViewController(
            detailVC,
            animated: true
        )
    }
}
