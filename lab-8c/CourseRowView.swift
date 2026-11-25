
import SwiftUI

struct CourseRowView: View {

    let course: Course

    @Binding var favoriteIDs: Set<Int>

    private var isFavorite: Bool {
        favoriteIDs.contains(course.id)
    }

    var body: some View {
        HStack(spacing: 12) {

            VStack(alignment: .leading, spacing: 5) {
                Text(course.title)
                    .font(.headline)

                Text(course.category)
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Text("\(course.duration) • \(course.level)")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Button {
                toggleFavorite()
            } label: {
                Image(
                    systemName: isFavorite
                    ? "heart.fill"
                    : "heart"
                )
                .font(.title3)
                .foregroundStyle(
                    isFavorite ? .pink : .secondary
                )
                .padding(8)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .accessibilityLabel(
                isFavorite
                ? "Remove \(course.title) from favourites"
                : "Add \(course.title) to favourites"
            )
        }
        .padding(.vertical, 6)
    }

    private func toggleFavorite() {
        if isFavorite {
            favoriteIDs.remove(course.id)
        } else {
            favoriteIDs.insert(course.id)
        }
    }
}
