
import SwiftUI

struct CourseSettingsView: View {

    private let courses = [
        "SwiftUI Fundamentals",
        "iOS App Development",
        "UI Design Basics",
        "Advanced Swift"
    ]

    var body: some View {
        NavigationStack {
            List {

                Section {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Welcome to Course Explorer")
                            .font(.title2)
                            .fontWeight(.bold)

                        Text(
                            "Explore learning opportunities and manage your course preferences."
                        )
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 8)
                }

                Section("Available Courses") {
                    ForEach(courses, id: \.self) { course in
                        Label(
                            course,
                            systemImage: "book.closed"
                        )
                    }
                }

                Section("Application") {
                    NavigationLink {
                        AppInfoView()
                    } label: {
                        Label(
                            "App Information",
                            systemImage: "info.circle"
                        )
                    }
                }

                Section("Privacy and Security") {
                    Label(
                        "Privacy Friendly",
                        systemImage: "lock.shield"
                    )
                    .foregroundStyle(.green)

                    Text(
                        "This app works without requesting sensitive device permissions."
                    )
                    .font(.caption)
                    .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("Course Explorer")
        }
    }
}

#Preview {
    CourseSettingsView()
}
