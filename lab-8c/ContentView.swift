
import SwiftUI

struct ContentView: View {

    @StateObject private var store = CourseStore()
    @State private var searchText = ""

    private var filteredCourses: [Course] {
        guard !searchText.isEmpty else {
            return store.courses
        }

        return store.courses.filter { course in
            course.title.localizedCaseInsensitiveContains(searchText) ||
            course.category.localizedCaseInsensitiveContains(searchText) ||
            course.instructor.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        NavigationStack {
            List {
                Section {
                    if filteredCourses.isEmpty {
                        Text("No courses found. Try another search.")
                            .foregroundStyle(.secondary)
                    } else {
                        ForEach(filteredCourses) { course in
                            NavigationLink {
                                CourseDetailView(
                                    course: course,
                                    favoriteIDs: $store.favoriteIDs
                                )
                            } label: {
                                CourseRowView(
                                    course: course,
                                    favoriteIDs: $store.favoriteIDs
                                )
                            }
                        }
                    }
                } header: {
                    HStack {
                        Text("Available Courses")

                        Spacer()

                        Text("\(filteredCourses.count)")
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .navigationTitle("Course Explorer")
            .searchable(
                text: $searchText,
                prompt: "Search courses"
            )
            .toolbar {
                ToolbarItem(
                    placement: .navigationBarTrailing
                ) {
                    HStack(spacing: 5) {
                        Image(systemName: "heart.fill")
                            .foregroundStyle(.pink)

                        Text("\(store.favoriteIDs.count)")
                            .font(.subheadline)
                    }
                    .accessibilityLabel(
                        "\(store.favoriteIDs.count) favourites"
                    )
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
