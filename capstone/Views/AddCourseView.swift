
import SwiftUI

struct AddCourseView: View {

    @ObservedObject var viewModel: CourseViewModel

    @State private var title = ""
    @State private var instructor = ""
    @State private var credits = 3
    @State private var totalLessons = 12

    @State private var startDate = Date()

    @State private var endDate = Calendar.current.date(
        byAdding: .day,
        value: 30,
        to: Date()
    ) ?? Date()

    @State private var alertMessage: String?
    @State private var showAlert = false

    var body: some View {

        Form {

            Section("Course Information") {

                TextField("Course Name", text: $title)

                TextField("Instructor Name", text: $instructor)
            }

            Section("Course Details") {

                Stepper(
                    "Credits: \(credits)",
                    value: $credits,
                    in: 1...10
                )

                Stepper(
                    "Total Lessons: \(totalLessons)",
                    value: $totalLessons,
                    in: 1...100
                )
            }

            Section("Course Schedule") {

                DatePicker(
                    "Start Date",
                    selection: $startDate,
                    displayedComponents: .date
                )

                DatePicker(
                    "End Date",
                    selection: $endDate,
                    displayedComponents: .date
                )
            }

            Section {

                Button {
                    saveCourse()
                } label: {

                    HStack {
                        Spacer()

                        Text("Add Course")
                            .fontWeight(.semibold)

                        Spacer()
                    }
                }
            }
        }
        .navigationTitle("Add New Course")
        .alert("Course Planner", isPresented: $showAlert) {

            Button("OK", role: .cancel) { }

        } message: {

            Text(alertMessage ?? "")
        }
        .onDisappear {
            viewModel.clearError()
        }
    }

    private func saveCourse() {

        let success = viewModel.addCourse(
            title: title,
            instructor: instructor,
            credits: credits,
            totalLessons: totalLessons,
            startDate: startDate,
            endDate: endDate
        )

        if success {

            alertMessage = "Your course has been added successfully."

            title = ""
            instructor = ""
            credits = 3
            totalLessons = 12
            startDate = Date()

            endDate = Calendar.current.date(
                byAdding: .day,
                value: 30,
                to: Date()
            ) ?? Date()

        } else {

            alertMessage = viewModel.errorMessage
                ?? "Something went wrong."
        }

        showAlert = true
    }
}
