
import UIKit

struct Product {
    let name: String
    let price: Double
}

class ViewController: UIViewController {

    private var products: [Product] = []
    private var fetchTask: Task<Void, Never>?

    private let titleLabel = UILabel()
    private let statusLabel = UILabel()
    private let resultLabel = UILabel()

    private let fetchButton = UIButton(type: .system)
    private let cancelButton = UIButton(type: .system)
    private let retryButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        setupUI()
    }

    //  UI Setup

    private func setupUI() {

        titleLabel.text = "My Products"
        titleLabel.font = .boldSystemFont(ofSize: 28)
        titleLabel.textAlignment = .center

        statusLabel.text = "Press the button to load products."
        statusLabel.font = .systemFont(ofSize: 17)
        statusLabel.textAlignment = .center
        statusLabel.numberOfLines = 0

        resultLabel.font = .systemFont(ofSize: 17)
        resultLabel.numberOfLines = 0
        resultLabel.textAlignment = .left

        fetchButton.setTitle("Fetch Products", for: .normal)
        fetchButton.addTarget(
            self,
            action: #selector(fetchButtonTapped),
            for: .touchUpInside
        )

        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.addTarget(
            self,
            action: #selector(cancelButtonTapped),
            for: .touchUpInside
        )

        retryButton.setTitle("Try Again", for: .normal)
        retryButton.addTarget(
            self,
            action: #selector(retryButtonTapped),
            for: .touchUpInside
        )

        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            statusLabel,
            resultLabel,
            fetchButton,
            cancelButton,
            retryButton
        ])

        stackView.axis = .vertical
        stackView.spacing = 22
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(
                equalTo: view.centerYAnchor
            ),
            stackView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 25
            ),
            stackView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -25
            )
        ])

        cancelButton.isEnabled = false
        retryButton.isHidden = true
    }

    // Button Actions

    @objc private func fetchButtonTapped() {
        startFetching()
    }

    @objc private func retryButtonTapped() {
        startFetching()
    }

    @objc private func cancelButtonTapped() {
        fetchTask?.cancel()
    }

    // Start Task

    private func startFetching() {

        products.removeAll()

        statusLabel.text = "Loading products..."
        resultLabel.text = ""

        fetchButton.isEnabled = false
        cancelButton.isEnabled = true
        retryButton.isHidden = true

        fetchTask = Task {
            await loadProducts()
        }
    }

    // Async Function

    @MainActor
    private func loadProducts() async {

        do {
            let result = try await fetchProducts()

            try Task.checkCancellation()

            products = result

            if products.isEmpty {
                statusLabel.text = "No products found."
                resultLabel.text = ""
            } else {
                statusLabel.text = "Products loaded successfully!"

                var productText = ""

                for product in products {
                    productText += "\(product.name) - $\(product.price)\n"
                }

                resultLabel.text = productText
            }

        } catch is CancellationError {

            statusLabel.text = "Fetching was cancelled."
            resultLabel.text = ""

        } catch {

            statusLabel.text = "Something went wrong!"
            resultLabel.text = error.localizedDescription
            retryButton.isHidden = false
        }

        fetchButton.isEnabled = true
        cancelButton.isEnabled = false
    }

    //  Fetch Products

    private func fetchProducts() async throws -> [Product] {

        // Simulate a server response
        try await Task.sleep(nanoseconds: 3_000_000_000)

        // Randomly create an error
        if Bool.random() {
            throw NSError(
                domain: "ProductError",
                code: 1,
                userInfo: [
                    NSLocalizedDescriptionKey:
                        "Unable to fetch products. Please try again."
                ]
            )
        }

        let productList = [
            Product(name: "Laptop", price: 750),
            Product(name: "Headphones", price: 45),
            Product(name: "Keyboard", price: 30),
            Product(name: "Mouse", price: 15)
        ]

        // Sometimes return an empty list
        if Bool.random() {
            return []
        }

        return productList
    }
}
