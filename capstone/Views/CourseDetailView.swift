
import SwiftUI

struct CourseDetailView: View {

    let courseID: UUID

    @ObservedObject var viewModel: CourseViewModel

    var body: some View {

        Group {

            if let course = viewModel.course(for: courseID) {

                Form {

                    Section("Course Information") {

                        detailRow(
                            title: "Course Name",
                            value: course.title
                        )

                        detailRow(
                            title: "Instructor",
                            value: course.instructor
                        )

                        detailRow(
                            title: "Credits",
                            value: "\(course.credits)"
                        )
                    }

                    Section("Learning Progress") {

                        ProgressView(value: course.progress)

                        Text(
                            "\(Int(course.progress * 100))% Completed"
                        )
                        .fontWeight(.semibold)

                        Stepper(
                            "Completed Lessons: \(course.completedLessons)",
                            value: Binding(
                                get: {
                                    viewModel.course(for: courseID)?
                                        .completedLessons ?? 0
                                },
                                set: { newValue in
                                    viewModel.updateProgress(
                                        courseID: courseID,
                                        completedLessons: newValue
                                    )
                                }
                            ),
                            in: 0...course.totalLessons
                        )

                        detailRow(
                            title: "Remaining Lessons",
                            value: "\(course.remainingLessons)"
                        )
                    }

                    Section("Course Schedule") {

                        detailRow(
                            title: "Start Date",
                            value: course.startDate.formatted(
                                date: .abbreviated,
                                time: .omitted
                            )
                        )

                        detailRow(
                            title: "End Date",
                            value: course.endDate.formatted(
                                date: .abbreviated,
                                time: .omitted
                            )
                        )
                    }

                    if course.isCompleted {

                        Section {
                            Label(
                                "Course Completed!",
                                systemImage: "checkmark.seal.fill"
                            )
                            .foregroundStyle(.green)
                        }
                    }
                }

            } else {

                ContentUnavailableView(
                    "Course Not Found",
                    systemImage: "exclamationmark.circle",
                    description: Text(
                        "This course may have been deleted."
                    )
                )
            }
        }
        .navigationTitle("Course Details")
    }

    private func detailRow(
        title: String,
        value: String
    ) -> some View {

        HStack {

            Text(title)

            Spacer()

            Text(value)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.trailing)
        }
    }
}
