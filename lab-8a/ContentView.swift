
import SwiftUI

struct ContentView: View {
    @State private var courses = Course.sampleCourses

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 22) {
                        headerSection
                        categorySection
                        courseSection
                    }
                    .padding()
                }
            }
            .navigationDestination(for: Course.self) { course in
                CourseDetailView(course: course)
            }
        }
    }

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Course Explorer")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("Find a course and start learning something new.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding(.top, 12)
    }

    private var categorySection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Explore Categories")
                .font(.headline)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    CategoryTag(title: "All Courses")
                    CategoryTag(title: "Design")
                    CategoryTag(title: "Development")
                    CategoryTag(title: "Programming")
                }
            }
        }
    }

    private var courseSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Text("Available Courses")
                    .font(.title2)
                    .fontWeight(.bold)

                Spacer()

                Text("\(courses.count) Courses")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            if courses.isEmpty {
                EmptyCoursesView()
            } else {
                LazyVStack(spacing: 15) {
                    ForEach(courses) { course in
                        NavigationLink(value: course) {
                            CourseCard(course: course)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
