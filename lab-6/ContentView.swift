
import SwiftUI

struct ContentView: View {

    @State private var posts: [Post] = []
    @State private var isLoading = false
    @State private var errorMessage: String?

    private let postService = PostService()

    var body: some View {

        NavigationStack {
            Group {

                if isLoading {
                    ProgressView("Loading posts...")
                        .padding()

                } else if let error = errorMessage {
                    VStack(spacing: 15) {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.largeTitle)
                            .foregroundColor(.orange)

                        Text(error)
                            .multilineTextAlignment(.center)

                        Button("Try Again") {
                            Task {
                                await loadPosts()
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()

                } else {
                    List(posts) { post in

                        NavigationLink {
                            PostDetailView(post: post)
                        } label: {
                            VStack(alignment: .leading, spacing: 8) {

                                Text(post.title.capitalized)
                                    .font(.headline)
                                    .lineLimit(2)

                                Text(post.body)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .lineLimit(2)

                                Text("Post ID: \(post.id)")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            .padding(.vertical, 5)
                        }
                    }
                }
            }
            .navigationTitle("Posts")
            .task {
                await loadPosts()
            }
        }
    }

    @MainActor
    private func loadPosts() async {

        isLoading = true
        errorMessage = nil

        do {
            let result = try await postService.fetchPosts()
            posts = result

        } catch {
            posts = []
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
