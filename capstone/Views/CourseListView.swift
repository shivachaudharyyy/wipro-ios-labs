
import SwiftUI

struct CourseListView: View {

    @ObservedObject var viewModel: CourseViewModel

    @State private var searchText = ""

    private var filteredCourses: [Course] {

        let allCourses = viewModel.sortedCourses

        if searchText.trimmingCharacters(
            in: .whitespacesAndNewlines
        ).isEmpty {
            return allCourses
        }

        return allCourses.filter {
            $0.title.localizedCaseInsensitiveContains(searchText) ||
            $0.instructor.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {

        Group {

            if viewModel.courses.isEmpty {

                ContentUnavailableView(
                    "No Courses Yet",
                    systemImage: "book.closed",
                    description: Text(
                        "Add your first course to start planning your learning."
                    )
                )

            } else if filteredCourses.isEmpty {

                ContentUnavailableView.search(
                    text: searchText
                )

            } else {

                List {

                    ForEach(filteredCourses) { course in

                        NavigationLink {

                            CourseDetailView(
                                courseID: course.id,
                                viewModel: viewModel
                            )

                        } label: {

                            CourseRowView(course: course)
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                        .swipeActions {

                            Button(role: .destructive) {

                                viewModel.deleteCourse(id: course.id)

                            } label: {

                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("My Courses")
        .searchable(
            text: $searchText,
            prompt: "Search courses or instructors"
        )
    }
}
