
import SwiftUI

struct PostDetailView: View {

    let post: Post

    var body: some View {

        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                Text("Post Details")
                    .font(.title)
                    .fontWeight(.bold)

                Text("Post ID: \(post.id)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Text("User ID: \(post.userId)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Divider()

                Text(post.title.capitalized)
                    .font(.title2)
                    .fontWeight(.semibold)

                Text(post.body)
                    .font(.body)
                    .lineSpacing(6)

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
