
import SwiftUI

struct CourseDetailView: View {

    let course: Course

    @Binding var favoriteIDs: Set<Int>

    private var isFavorite: Bool {
        favoriteIDs.contains(course.id)
    }

    var body: some View {
        List {

            Section("Course Information") {
                VStack(alignment: .leading, spacing: 10) {

                    Text(course.title)
                        .font(.title2)
                        .fontWeight(.bold)

                    Text(course.description)
                        .foregroundStyle(.secondary)

                    LabeledContent(
                        "Instructor",
                        value: course.instructor
                    )

                    LabeledContent(
                        "Duration",
                        value: course.duration
                    )

                    LabeledContent(
                        "Level",
                        value: course.level
                    )

                    LabeledContent(
                        "Category",
                        value: course.category
                    )
                }
                .padding(.vertical, 5)
            }

            Section("What You Will Learn") {
                ForEach(course.topics, id: \.self) { topic in
                    Label(
                        topic,
                        systemImage: "checkmark.circle"
                    )
                }
            }

            Section {
                Button {
                    toggleFavorite()
                } label: {
                    Label(
                        isFavorite
                        ? "Remove from Favourites"
                        : "Add to Favourites",
                        systemImage: isFavorite
                        ? "heart.slash"
                        : "heart"
                    )
                    .foregroundStyle(
                        isFavorite ? .red : .pink
                    )
                }
            }
        }
        .navigationTitle("Course Details")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func toggleFavorite() {
        if isFavorite {
            favoriteIDs.remove(course.id)
        } else {
            favoriteIDs.insert(course.id)
        }
    }
}
