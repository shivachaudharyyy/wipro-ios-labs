
import Foundation

struct AppConfiguration {

    static var appName: String {
        Bundle.main.infoDictionary?[
            "CFBundleDisplayName"
        ] as? String ?? "Course Explorer"
    }

    static var bundleIdentifier: String {
        Bundle.main.bundleIdentifier ?? "Not available"
    }

    static var appVersion: String {
        Bundle.main.infoDictionary?[
            "CFBundleShortVersionString"
        ] as? String ?? "1.0"
    }

    static var buildNumber: String {
        Bundle.main.infoDictionary?[
            "CFBundleVersion"
        ] as? String ?? "1"
    }

    static var minimumIOSVersion: String {
        Bundle.main.infoDictionary?[
            "MinimumOSVersion"
        ] as? String ?? "Configured in project settings"
    }
}
