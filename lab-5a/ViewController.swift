
import UIKit

class ViewController: UIViewController {

    //  UI Elements

    let titleLabel = UILabel()
    let statusLabel = UILabel()
    let resultLabel = UILabel()
    let startButton = UIButton(type: .system)
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    let logTextView = UITextView()

    // Used to store results from background tasks safely
    let resultLock = NSLock()
    var results: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        setupUI()
    }

    // UI Setup

    func setupUI() {

        titleLabel.text = "GCD & Main Thread Demo"
        titleLabel.font = .boldSystemFont(ofSize: 25)
        titleLabel.textAlignment = .center

        statusLabel.text = "Ready to start"
        statusLabel.textAlignment = .center
        statusLabel.font = .systemFont(ofSize: 17)

        resultLabel.text = "Results will appear here"
        resultLabel.textAlignment = .center
        resultLabel.numberOfLines = 0

        startButton.setTitle("Start Work", for: .normal)
        startButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        startButton.backgroundColor = .systemBlue
        startButton.setTitleColor(.white, for: .normal)
        startButton.layer.cornerRadius = 10
        startButton.addTarget(self, action: #selector(startWork), for: .touchUpInside)

        activityIndicator.hidesWhenStopped = true

        logTextView.font = .systemFont(ofSize: 13)
        logTextView.isEditable = false
        logTextView.layer.borderWidth = 1
        logTextView.layer.borderColor = UIColor.systemGray4.cgColor
        logTextView.layer.cornerRadius = 8

        let stack = UIStackView(arrangedSubviews: [
            titleLabel,
            statusLabel,
            activityIndicator,
            resultLabel,
            startButton,
            logTextView
        ])

        stack.axis = .vertical
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 30
            ),
            stack.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 20
            ),
            stack.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -20
            ),

            startButton.heightAnchor.constraint(equalToConstant: 50),
            logTextView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }

    //  Logging

    func addLog(_ message: String) {

        DispatchQueue.main.async {
            self.logTextView.text += message + "\n"

            let bottom = NSRange(
                location: max(self.logTextView.text.count - 1, 0),
                length: 0
            )

            self.logTextView.scrollRangeToVisible(bottom)
        }
    }

    // Start Background Work

    @objc func startWork() {

        // Avoid starting the same work multiple times
        startButton.isEnabled = false
        startButton.alpha = 0.5

        statusLabel.text = "Work is running..."
        resultLabel.text = "Please wait..."

        activityIndicator.startAnimating()
        logTextView.text = ""

        results.removeAll()

        addLog("Main thread: Button clicked")
        addLog("Background work started")

        let group = DispatchGroup()

        // First background operation
        group.enter()

        DispatchQueue.global(qos: .userInitiated).async {

            self.addLog("Task 1 started on background queue")

            // Simulate a slow operation
            Thread.sleep(forTimeInterval: 4)

            let answer = "Task 1 completed successfully"

            self.resultLock.lock()
            self.results.append(answer)
            self.resultLock.unlock()

            self.addLog("Task 1 finished")

            group.leave()
        }

        // Second background operation with a delay
        group.enter()

        DispatchQueue.global(qos: .utility).asyncAfter(
            deadline: .now() + 2
        ) {

            self.addLog("Task 2 started after 2 seconds")

            Thread.sleep(forTimeInterval: 2)

            let answer = "Task 2 completed successfully"

            self.resultLock.lock()
            self.results.append(answer)
            self.resultLock.unlock()

            self.addLog("Task 2 finished")

            group.leave()
        }

        // Wait until both background tasks are completed
        group.notify(queue: DispatchQueue.main) {

            self.activityIndicator.stopAnimating()

            self.statusLabel.text = "All work completed!"

            self.startButton.isEnabled = true
            self.startButton.alpha = 1.0

            self.resultLock.lock()
            let finalResults = self.results
            self.resultLock.unlock()

            self.resultLabel.text = finalResults.joined(separator: "\n")

            self.addLog("Main thread: Results updated")
            self.addLog("All background tasks completed")
        }
    }
}
