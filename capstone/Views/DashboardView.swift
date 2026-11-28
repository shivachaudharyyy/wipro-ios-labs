
import SwiftUI

struct DashboardView: View {

    @ObservedObject var viewModel: CourseViewModel

    var body: some View {

        ScrollView {

            VStack(alignment: .leading, spacing: 22) {

                VStack(alignment: .leading, spacing: 5) {

                    Text("Welcome Back!")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text("Keep your learning on track.")
                        .foregroundStyle(.secondary)
                }

                HStack(spacing: 12) {

                    summaryCard(
                        title: "Total Courses",
                        value: "\(viewModel.courses.count)",
                        symbol: "book.fill"
                    )

                    summaryCard(
                        title: "Total Credits",
                        value: "\(viewModel.totalCredits)",
                        symbol: "graduationcap.fill"
                    )
                }

                VStack(alignment: .leading, spacing: 10) {

                    Text("Overall Progress")
                        .font(.headline)

                    HStack {

                        ProgressView(
                            value: viewModel.averageProgress
                        )
                        .tint(.blue)

                        Text(
                            "\(Int(viewModel.averageProgress * 100))%"
                        )
                        .fontWeight(.semibold)
                    }

                    Text("Average completion across your courses")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 14))

                VStack(alignment: .leading, spacing: 12) {

                    HStack {
                        Text("Upcoming Deadlines")
                            .font(.headline)

                        Spacer()

                        Text("\(viewModel.upcomingCourses.count)")
                            .foregroundStyle(.secondary)
                    }

                    if viewModel.upcomingCourses.isEmpty {

                        Text("No upcoming deadlines. Add a course to get started.")
                            .foregroundStyle(.secondary)
                            .padding(.vertical, 8)

                    } else {

                        ForEach(
                            viewModel.upcomingCourses.prefix(3)
                        ) { course in

                            NavigationLink {
                                CourseDetailView(
                                    courseID: course.id,
                                    viewModel: viewModel
                                )
                            } label: {
                                CourseRowView(course: course)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }

                VStack(alignment: .leading, spacing: 10) {

                    Text("Learning Summary")
                        .font(.headline)

                    HStack {
                        Label(
                            "Completed",
                            systemImage: "checkmark.circle.fill"
                        )

                        Spacer()

                        Text("\(viewModel.completedCourses.count)")
                            .fontWeight(.semibold)
                    }

                    HStack {
                        Label(
                            "In Progress",
                            systemImage: "clock.fill"
                        )

                        Spacer()

                        Text("\(viewModel.activeCourses.count)")
                            .fontWeight(.semibold)
                    }
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 14))
            }
            .padding()
        }
        .navigationTitle("Course Planner")
    }

    private func summaryCard(
        title: String,
        value: String,
        symbol: String
    ) -> some View {

        VStack(alignment: .leading, spacing: 12) {

            Image(systemName: symbol)
                .font(.title2)
                .foregroundStyle(.blue)

            Text(value)
                .font(.title)
                .fontWeight(.bold)

            Text(title)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}
