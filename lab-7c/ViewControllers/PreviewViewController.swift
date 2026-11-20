
import UIKit

class PreviewViewController: UIViewController {

    private let settings: SettingsData

    private let detailsLabel = UILabel()

    init(settings: SettingsData) {
        self.settings = settings
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        return nil
    }

    // Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        print("Preview: viewDidLoad")

        view.backgroundColor = .systemBackground
        title = "Settings Preview"

        setupScreen()
        showDetails()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        print("Preview: viewWillAppear")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        print("Preview: viewDidAppear")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        print("Preview: viewWillDisappear")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        print("Preview: viewDidDisappear")
    }

    // Screen Setup

    private func setupScreen() {

        detailsLabel.translatesAutoresizingMaskIntoConstraints = false

        detailsLabel.font = .systemFont(ofSize: 17)
        detailsLabel.textColor = .label
        detailsLabel.numberOfLines = 0
        detailsLabel.backgroundColor = .secondarySystemBackground
        detailsLabel.layer.cornerRadius = 12
        detailsLabel.clipsToBounds = true
        detailsLabel.accessibilityLabel = "Selected settings details"

        view.addSubview(detailsLabel)

        NSLayoutConstraint.activate([

            detailsLabel.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 30
            ),

            detailsLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 22
            ),

            detailsLabel.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -22
            )
        ])
    }

    // Display Settings

    private func showDetails() {

        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short

        let reminder = formatter.string(
            from: settings.reminderDate
        )

        let notificationStatus = settings.notificationsEnabled
            ? "Enabled"
            : "Disabled"

        detailsLabel.text = """
        
        PERSONAL SETTINGS

        Name: \(settings.userName)

        Notifications: \(notificationStatus)

        Theme: \(settings.selectedTheme)

        Volume: \(Int(settings.volume))%

        Reminder: \(reminder)

        """
    }
}

