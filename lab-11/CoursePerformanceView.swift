
import SwiftUI

// Main Screen

struct CoursePerformanceView: View {

    var body: some View {

        TabView {

            BeforeOptimizationView()
                .tabItem {
                    Label("Before", systemImage: "clock")
                }

            AfterOptimizationView()
                .tabItem {
                    Label("After", systemImage: "bolt.fill")
                }
        }
    }
}


// Before Optimization

struct BeforeOptimizationView: View {

    @State private var refreshCount = 0

    private let courses = Course.sampleCourses

    // Sorting happens every time the view body is recalculated.
    private var sortedCourses: [Course] {

        courses.sorted {
            $0.title < $1.title
        }
    }

    var body: some View {

        NavigationStack {

            List(sortedCourses) { course in
                CourseRow(course: course)
            }
            .navigationTitle("Before Optimization")
            .toolbar {

                ToolbarItem(placement: .topBarTrailing) {

                    Button("Refresh") {
                        refreshCount += 1
                    }
                    .accessibilityIdentifier("beforeRefreshButton")
                }
            }
            .safeAreaInset(edge: .bottom) {

                Text("Refresh count: \(refreshCount)")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.thinMaterial)
            }
        }
    }
}


// After Optimization

struct AfterOptimizationView: View {

    @State private var refreshCount = 0
    @State private var sortedCourses: [Course]

    init() {

        let courses = Course.sampleCourses

        // Sorting is done once when the view is initialized.
        _sortedCourses = State(
            initialValue: courses.sorted {
                $0.title < $1.title
            }
        )
    }

    var body: some View {

        NavigationStack {

            List(sortedCourses) { course in
                CourseRow(course: course)
            }
            .navigationTitle("After Optimization")
            .toolbar {

                ToolbarItem(placement: .topBarTrailing) {

                    Button("Refresh") {
                        refreshCount += 1
                    }
                    .accessibilityIdentifier("afterRefreshButton")
                }
            }
            .safeAreaInset(edge: .bottom) {

                Text("Refresh count: \(refreshCount)")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.thinMaterial)
            }
        }
    }
}


// Reusable Course Row

struct CourseRow: View {

    let course: Course

    var body: some View {

        VStack(alignment: .leading, spacing: 6) {

            Text(course.title)
                .font(.headline)

            Text(course.category)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Text(course.duration)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 5)
    }
}
