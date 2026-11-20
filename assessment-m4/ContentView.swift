
import SwiftUI

// Book Model

struct Book: Identifiable, Hashable {

    let id: Int
    let title: String
    let author: String
    let category: String
    let description: String

}

// Shared Library Data

@MainActor
class LibraryStore: ObservableObject {

    @Published var favouriteIDs: Set<Int> = []

    let books: [Book] = [

        Book(
            id: 1,
            title: "The Alchemist",
            author: "Paulo Coelho",
            category: "Fiction",
            description: "A young shepherd travels in search of his dreams and discovers the importance of following his heart."
        ),

        Book(
            id: 2,
            title: "Atomic Habits",
            author: "James Clear",
            category: "Self Improvement",
            description: "A practical book about building good habits, breaking bad ones and making small improvements every day."
        ),

        Book(
            id: 3,
            title: "The Psychology of Money",
            author: "Morgan Housel",
            category: "Finance",
            description: "This book explains how people think about money and how behaviour influences financial decisions."
        ),

        Book(
            id: 4,
            title: "Rich Dad Poor Dad",
            author: "Robert Kiyosaki",
            category: "Finance",
            description: "A book about financial education, investing and developing a better understanding of money."
        ),

        Book(
            id: 5,
            title: "Deep Work",
            author: "Cal Newport",
            category: "Productivity",
            description: "Learn how focused work can improve productivity and help you achieve meaningful results."
        )
    ]

    var favouriteBooks: [Book] {

        books.filter { favouriteIDs.contains($0.id) }
    }

    func toggleFavourite(for book: Book) {

        if favouriteIDs.contains(book.id) {

            favouriteIDs.remove(book.id)

        } else {

            favouriteIDs.insert(book.id)
        }
    }

    func isFavourite(_ book: Book) -> Bool {

        favouriteIDs.contains(book.id)
    }
}

// Main Content View

struct ContentView: View {

    var body: some View {

        TabView {

            BrowseView()
                .tabItem {
                    Label("Browse", systemImage: "books.vertical")
                }

            FavouritesView()
                .tabItem {
                    Label("Favourites", systemImage: "heart.fill")
                }

            FeedbackView()
                .tabItem {
                    Label("Feedback", systemImage: "envelope")
                }
        }
        .tint(.blue)
    }
}

// Browse Screen

struct BrowseView: View {

    @EnvironmentObject var library: LibraryStore

    var body: some View {

        NavigationStack {

            List {

                Section {

                    ForEach(library.books) { book in

                        HStack {

                            NavigationLink(value: book) {

                                BookRow(book: book)
                            }

                            Button {

                                library.toggleFavourite(for: book)

                            } label: {

                                Image(
                                    systemName: library.isFavourite(book)
                                        ? "heart.fill"
                                        : "heart"
                                )
                                .foregroundStyle(
                                    library.isFavourite(book)
                                        ? .red
                                        : .secondary
                                )
                                .font(.title3)
                            }
                            .buttonStyle(.plain)
                            .accessibilityLabel(
                                library.isFavourite(book)
                                    ? "Remove \(book.title) from favourites"
                                    : "Add \(book.title) to favourites"
                            )
                        }
                    }
                } header: {

                    Text("Available Books")
                }
            }
            .navigationTitle("Book Library")
            .navigationDestination(for: Book.self) { book in

                BookDetailView(book: book)
            }
        }
    }
}

// Book Row

struct BookRow: View {

    let book: Book

    var body: some View {

        VStack(alignment: .leading, spacing: 5) {

            Text(book.title)
                .font(.headline)
                .foregroundStyle(.primary)

            Text(book.author)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Text(book.category)
                .font(.caption)
                .foregroundStyle(.blue)
        }
        .padding(.vertical, 6)
    }
}


// Favourites Screen

struct FavouritesView: View {

    @EnvironmentObject var library: LibraryStore

    var body: some View {

        NavigationStack {

            Group {

                if library.favouriteBooks.isEmpty {

                    // Show this when no book is saved
                    VStack(spacing: 12) {

                        Image(systemName: "heart")
                            .font(.system(size: 50))
                            .foregroundColor(.gray)

                        Text("No Favourites Yet")
                            .font(.title2)
                            .fontWeight(.semibold)

                        Text("Books you add to favourites will appear here.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                } else {

                    // Display all saved books
                    List {

                        ForEach(library.favouriteBooks) { book in

                            HStack {

                                NavigationLink(value: book) {

                                    BookRow(book: book)
                                }

                                Button {

                                    library.toggleFavourite(for: book)

                                } label: {

                                    Image(systemName: "heart.fill")
                                        .font(.title3)
                                        .foregroundColor(.red)
                                }
                                .buttonStyle(.plain)
                                .accessibilityLabel(
                                    "Remove \(book.title) from favourites"
                                )
                            }
                        }
                    }
                    .navigationDestination(for: Book.self) { book in

                        BookDetailView(book: book)
                    }
                }
            }
            .navigationTitle("My Favourites")
        }
    }
}

//  Book Detail Screen

struct BookDetailView: View {

    let book: Book

    @EnvironmentObject var library: LibraryStore

    var body: some View {

        ScrollView {

            VStack(alignment: .leading, spacing: 20) {

                Image(systemName: "book.closed.fill")
                    .font(.system(size: 75))
                    .foregroundStyle(.blue)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 35)
                    .background(.blue.opacity(0.08))
                    .clipShape(RoundedRectangle(cornerRadius: 18))

                Text(book.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Written by \(book.author)")
                    .font(.headline)
                    .foregroundStyle(.secondary)

                Text(book.category.uppercased())
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(.blue)

                Divider()

                Text("About this book")
                    .font(.title2)
                    .fontWeight(.semibold)

                Text(book.description)
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .lineSpacing(5)

                Button {

                    library.toggleFavourite(for: book)

                } label: {

                    Label(
                        library.isFavourite(book)
                            ? "Remove from Favourites"
                            : "Add to Favourites",

                        systemImage: library.isFavourite(book)
                            ? "heart.fill"
                            : "heart"
                    )
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .accessibilityHint(
                    "Changes this book's favourite status"
                )
            }
            .padding()
        }
        .navigationTitle("Book Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

//Feedback Screen

struct FeedbackView: View {

    @State private var name = ""
    @State private var email = ""
    @State private var message = ""

    @State private var isSubmitting = false

    @State private var errorMessage: String?
    @State private var successMessage: String?

    var body: some View {

        NavigationStack {

            Form {

                Section("Your Information") {

                    TextField("Enter your name", text: $name)
                        .textContentType(.name)
                        .textInputAutocapitalization(.words)
                        .accessibilityLabel("Your name")

                    TextField("Enter your email", text: $email)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .textContentType(.emailAddress)
                        .accessibilityLabel("Your email")
                }

                Section("Your Feedback") {

                    TextEditor(text: $message)
                        .frame(minHeight: 120)
                        .accessibilityLabel("Feedback message")
                }

                if let errorMessage = errorMessage {

                    Section {

                        Label(
                            errorMessage,
                            systemImage: "exclamationmark.circle.fill"
                        )
                        .foregroundStyle(.red)
                    }
                }

                if let successMessage = successMessage {

                    Section {

                        Label(
                            successMessage,
                            systemImage: "checkmark.circle.fill"
                        )
                        .foregroundStyle(.green)
                    }
                }

                Section {

                    Button {

                        Task {
                            await submitFeedback()
                        }

                    } label: {

                        HStack {

                            Spacer()

                            if isSubmitting {

                                ProgressView("Submitting...")

                            } else {

                                Text("Submit Feedback")
                                    .fontWeight(.semibold)
                            }

                            Spacer()
                        }
                    }
                    .disabled(isSubmitting)
                }
            }
            .navigationTitle("Feedback")
        }
    }

    //Form Validation

    private func validateForm() -> String? {

        let cleanName = name.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        let cleanEmail = email.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        let cleanMessage = message.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        if cleanName.isEmpty {

            return "Please enter your name."
        }

        if cleanEmail.isEmpty {

            return "Please enter your email."
        }

        if !isValidEmail(cleanEmail) {

            return "Please enter a valid email address."
        }

        if cleanMessage.isEmpty {

            return "Please write some feedback."
        }

        if cleanMessage.count < 10 {

            return "Feedback should contain at least 10 characters."
        }

        return nil
    }

    private func isValidEmail(_ value: String) -> Bool {

        let pattern =
            #"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#

        return value.range(
            of: pattern,
            options: .regularExpression
        ) != nil
    }

    //  Submit Feedback

    @MainActor
    private func submitFeedback() async {

        errorMessage = nil
        successMessage = nil

        if let validationError = validateForm() {

            errorMessage = validationError
            return
        }

        isSubmitting = true

        do {

            // Simulate a short submission process.
            try await Task.sleep(nanoseconds: 1_000_000_000)

            successMessage = "Thank you! Your feedback has been submitted."

            name = ""
            email = ""
            message = ""

        } catch {

            errorMessage = "Something went wrong. Please try again."
        }

        isSubmitting = false
    }
}
