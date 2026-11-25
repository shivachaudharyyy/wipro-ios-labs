
import SwiftUI

struct CourseDetailView: View {
    let course: Course

    var body: some View {
        List {
            Section("Course Information") {
                VStack(alignment: .leading, spacing: 10) {
                    Text(course.title)
                        .font(.title2)
                        .fontWeight(.bold)

                    Text(course.description)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    HStack {
                        Label(course.instructor, systemImage: "person")
                        Spacer()
                        Label(course.duration, systemImage: "clock")
                    }
                    .font(.caption)
                    .foregroundStyle(.blue)

                    Text("Level: \(course.level)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .padding(.vertical, 8)
            }

            Section("What You Will Learn") {
                ForEach(course.topics, id: \.self) { topic in
                    Label(topic, systemImage: "checkmark.circle.fill")
                        .foregroundStyle(.primary)
                        .tint(.green)
                        .padding(.vertical, 4)
                }
            }

            Section("Course Status") {
                HStack {
                    Text("Current Status")
                    Spacer()
                    Text(course.status)
                        .fontWeight(.semibold)
                        .foregroundStyle(.green)
                }
            }
        }
        .navigationTitle("Course Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
