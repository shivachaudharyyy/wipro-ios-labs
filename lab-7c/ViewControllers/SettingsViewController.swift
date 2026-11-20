
import UIKit

class SettingsViewController: UIViewController, UITextFieldDelegate {

    //  UI Elements

    private let nameField = UITextField()
    private let notificationSwitch = UISwitch()

    private let themeControl = UISegmentedControl(
        items: ["Light", "Dark", "System"]
    )

    private let volumeSlider = UISlider()
    private let volumeLabel = UILabel()
    private let datePicker = UIDatePicker()

    private let summaryLabel = UILabel()
    private let summaryBox = UIView()

    private let previewButton = UIButton(type: .system)

    private let scrollView = UIScrollView()
    private let contentStack = UIStackView()

    // View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        print("Settings: viewDidLoad")

        view.backgroundColor = .systemBackground
        title = "Personal Settings"

        setupUI()
        setupKeyboardHandling()
        updateSummary()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        print("Settings: viewWillAppear")
        updateSummary()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        print("Settings: viewDidAppear")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        print("Settings: viewWillDisappear")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        print("Settings: viewDidDisappear")
    }

    //  Main UI Setup

    private func setupUI() {

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentStack.translatesAutoresizingMaskIntoConstraints = false

        contentStack.axis = .vertical
        contentStack.spacing = 18

        scrollView.keyboardDismissMode = .interactive

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

        setupNameField()
        setupNotificationSwitch()
        setupThemeControl()
        setupVolumeSlider()
        setupDatePicker()
        setupSummary()
        setupPreviewButton()
    }

    //  Name Field

    private func setupNameField() {

        let heading = makeLabel("Your Name")

        nameField.placeholder = "Enter your name"
        nameField.borderStyle = .roundedRect
        nameField.font = .systemFont(ofSize: 16)
        nameField.returnKeyType = .done
        nameField.autocorrectionType = .no
        nameField.textContentType = .name
        nameField.accessibilityLabel = "Your name"

        nameField.delegate = self

        nameField.addTarget(
            self,
            action: #selector(controlChanged),
            for: .editingChanged
        )

        contentStack.addArrangedSubview(heading)
        contentStack.addArrangedSubview(nameField)
    }

    // Notification Switch

    private func setupNotificationSwitch() {

        let heading = makeLabel("Notifications")

        notificationSwitch.isOn = true
        notificationSwitch.accessibilityLabel = "Notifications"

        notificationSwitch.addTarget(
            self,
            action: #selector(controlChanged),
            for: .valueChanged
        )

        let switchLabel = UILabel()
        switchLabel.text = "Enable Notifications"

        let switchRow = UIStackView(
            arrangedSubviews: [switchLabel, notificationSwitch]
        )

        switchRow.axis = .horizontal
        switchRow.alignment = .center
        switchRow.distribution = .equalSpacing

        contentStack.addArrangedSubview(heading)
        contentStack.addArrangedSubview(switchRow)
    }

    // Theme Selection

    private func setupThemeControl() {

        let heading = makeLabel("Choose Theme")

        themeControl.selectedSegmentIndex = 2
        themeControl.accessibilityLabel = "Choose theme"

        themeControl.addTarget(
            self,
            action: #selector(controlChanged),
            for: .valueChanged
        )

        contentStack.addArrangedSubview(heading)
        contentStack.addArrangedSubview(themeControl)
    }

    // Volume Slider

    private func setupVolumeSlider() {

        let heading = makeLabel("Volume")

        volumeSlider.minimumValue = 0
        volumeSlider.maximumValue = 100
        volumeSlider.value = 50
        volumeSlider.accessibilityLabel = "Volume level"

        volumeSlider.addTarget(
            self,
            action: #selector(controlChanged),
            for: .valueChanged
        )

        volumeLabel.text = "50%"
        volumeLabel.textColor = .secondaryLabel
        volumeLabel.widthAnchor.constraint(
            equalToConstant: 45
        ).isActive = true

        let sliderRow = UIStackView(
            arrangedSubviews: [volumeSlider, volumeLabel]
        )

        sliderRow.axis = .horizontal
        sliderRow.spacing = 12
        sliderRow.alignment = .center

        contentStack.addArrangedSubview(heading)
        contentStack.addArrangedSubview(sliderRow)
    }

    // Date Picker

    private func setupDatePicker() {

        let heading = makeLabel("Reminder Date")

        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = .compact
        datePicker.accessibilityLabel = "Reminder date and time"

        datePicker.addTarget(
            self,
            action: #selector(controlChanged),
            for: .valueChanged
        )

        contentStack.addArrangedSubview(heading)
        contentStack.addArrangedSubview(datePicker)
    }

    //Summary Panel

    private func setupSummary() {

        let heading = makeLabel("Settings Summary")

        summaryBox.backgroundColor = .secondarySystemBackground
        summaryBox.layer.cornerRadius = 12

        summaryLabel.font = .systemFont(ofSize: 15)
        summaryLabel.textColor = .label
        summaryLabel.numberOfLines = 0
        summaryLabel.accessibilityLabel = "Current settings summary"

        summaryLabel.translatesAutoresizingMaskIntoConstraints = false

        summaryBox.addSubview(summaryLabel)

        NSLayoutConstraint.activate([

            summaryLabel.topAnchor.constraint(
                equalTo: summaryBox.topAnchor,
                constant: 15
            ),

            summaryLabel.leadingAnchor.constraint(
                equalTo: summaryBox.leadingAnchor,
                constant: 15
            ),

            summaryLabel.trailingAnchor.constraint(
                equalTo: summaryBox.trailingAnchor,
                constant: -15
            ),

            summaryLabel.bottomAnchor.constraint(
                equalTo: summaryBox.bottomAnchor,
                constant: -15
            )
        ])

        contentStack.addArrangedSubview(heading)
        contentStack.addArrangedSubview(summaryBox)
    }

    //Preview Button

    private func setupPreviewButton() {

        previewButton.setTitle("View Settings", for: .normal)
        previewButton.setTitleColor(.white, for: .normal)

        previewButton.backgroundColor = .systemBlue
        previewButton.titleLabel?.font = .boldSystemFont(ofSize: 17)
        previewButton.layer.cornerRadius = 10

        previewButton.heightAnchor.constraint(
            equalToConstant: 50
        ).isActive = true

        previewButton.accessibilityLabel = "View settings preview"

        previewButton.addTarget(
            self,
            action: #selector(openPreview),
            for: .touchUpInside
        )

        contentStack.addArrangedSubview(previewButton)
    }

    // Helper Label

    private func makeLabel(_ text: String) -> UILabel {

        let label = UILabel()
        label.text = text
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .label

        return label
    }

    // Update Summary

    @objc private func controlChanged() {
        updateSummary()
    }

    private func updateSummary() {

        let name = nameField.text?
            .trimmingCharacters(in: .whitespacesAndNewlines)

        let displayName = name.flatMap {
            $0.isEmpty ? nil : $0
        } ?? "Not entered"

        let notificationStatus = notificationSwitch.isOn
            ? "Enabled"
            : "Disabled"

        let theme = themeControl.titleForSegment(
            at: themeControl.selectedSegmentIndex
        ) ?? "System"

        let volume = Int(volumeSlider.value)

        volumeLabel.text = "\(volume)%"

        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short

        let selectedDate = formatter.string(
            from: datePicker.date
        )

        summaryLabel.text = """
        Name: \(displayName)

        Notifications: \(notificationStatus)

        Theme: \(theme)

        Volume: \(volume)%

        Reminder: \(selectedDate)
        """
    }

    // Open Preview Screen

    @objc private func openPreview() {

        view.endEditing(true)

        let name = nameField.text?
            .trimmingCharacters(in: .whitespacesAndNewlines)

        let displayName = name.flatMap {
            $0.isEmpty ? nil : $0
        } ?? "Not entered"

        let data = SettingsData(
            userName: displayName,
            notificationsEnabled: notificationSwitch.isOn,
            selectedTheme: themeControl.titleForSegment(
                at: themeControl.selectedSegmentIndex
            ) ?? "System",
            volume: volumeSlider.value,
            reminderDate: datePicker.date
        )

        let previewVC = PreviewViewController(settings: data)

        navigationController?.pushViewController(
            previewVC,
            animated: true
        )
    }

    // Keyboard Handling

    private func setupKeyboardHandling() {

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillChangeFrame),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )

        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(hideKeyboard)
        )

        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func keyboardWillChangeFrame(
        _ notification: Notification
    ) {

        guard
            let frame = notification.userInfo?[
                UIResponder.keyboardFrameEndUserInfoKey
            ] as? CGRect
        else {
            return
        }

        let keyboardFrame = view.convert(frame, from: nil)

        let overlap = view.bounds.intersection(keyboardFrame).height

        let bottomInset = max(
            0,
            overlap - view.safeAreaInsets.bottom
        )

        scrollView.contentInset.bottom = bottomInset + 10

        scrollView.verticalScrollIndicatorInsets.bottom = bottomInset
    }

    @objc private func keyboardWillHide(
        _ notification: Notification
    ) {

        scrollView.contentInset.bottom = 0
        scrollView.verticalScrollIndicatorInsets.bottom = 0
    }

    @objc private func hideKeyboard() {

        view.endEditing(true)
    }

    //  Text Field Delegate

    func textFieldShouldReturn(
        _ textField: UITextField
    ) -> Bool {

        textField.resignFirstResponder()
        return true
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

