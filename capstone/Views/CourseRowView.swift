
import SwiftUI

struct CourseRowView: View {

    let course: Course

    var body: some View {

        VStack(alignment: .leading, spacing: 12) {

            HStack {

                VStack(alignment: .leading, spacing: 5) {

                    Text(course.title)
                        .font(.headline)

                    Text("Instructor: \(course.instructor)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Text("\(Int(course.progress * 100))%")
                    .font(.headline)
                    .foregroundStyle(.blue)
            }

            ProgressView(value: course.progress)
                .tint(.blue)

            HStack {

                Text("\(course.completedLessons)/\(course.totalLessons) lessons")

                Spacer()

                Text("\(course.credits) Credits")
            }
            .font(.caption)
            .foregroundStyle(.secondary)
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}
