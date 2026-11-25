
import SwiftUI

struct AppInfoView: View {

    var body: some View {
        List {

            Section("Application Details") {

                infoRow(
                    title: "App Name",
                    value: AppConfiguration.appName
                )

                infoRow(
                    title: "Bundle Identifier",
                    value: AppConfiguration.bundleIdentifier
                )

                infoRow(
                    title: "Version",
                    value: AppConfiguration.appVersion
                )

                infoRow(
                    title: "Build Number",
                    value: AppConfiguration.buildNumber
                )

                infoRow(
                    title: "Minimum iOS",
                    value: AppConfiguration.minimumIOSVersion
                )
            }

            Section("Privacy") {

                Label(
                    "No sensitive permissions required",
                    systemImage: "checkmark.shield.fill"
                )
                .foregroundStyle(.green)

                Text(
                    "Course Explorer does not access the camera, photo library, contacts or location."
                )
                .font(.subheadline)
                .foregroundStyle(.secondary)
            }

            Section("About") {
                Text(
                    "This application demonstrates basic SwiftUI configuration and privacy-friendly app design."
                )
                .font(.subheadline)
                .foregroundStyle(.secondary)
            }
        }
        .navigationTitle("App Information")
    }

    private func infoRow(
        title: String,
        value: String
    ) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)

            Text(value)
                .font(.body)
                .textSelection(.enabled)
        }
        .padding(.vertical, 3)
    }
}

#Preview {
    NavigationStack {
        AppInfoView()
    }
}
