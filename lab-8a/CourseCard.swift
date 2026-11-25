
import SwiftUI

struct CourseCard: View {
    let course: Course

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(course.category)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundStyle(.blue)

                Spacer()

                Text(course.status)
                    .font(.caption2)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.green.opacity(0.12))
                    .foregroundStyle(.green)
                    .clipShape(Capsule())
            }

            Text(course.title)
                .font(.headline)
                .foregroundStyle(.primary)

            Text("By \(course.instructor)")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Divider()

            HStack {
                Label(course.duration, systemImage: "clock")

                Spacer()

                Text("View Details")
                    .fontWeight(.semibold)

                Image(systemName: "arrow.right")
            }
            .font(.caption)
            .foregroundStyle(.blue)
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
