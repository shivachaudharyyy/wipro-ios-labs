import SwiftUI

@main
struct LifecycleDemoApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self)
    var appDelegate

    @Environment(\.scenePhase) var scenePhase

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onChange(of: scenePhase) { oldPhase, newPhase in

                    switch newPhase {
                    case .active:
                        print("Scene: App is active")

                    case .inactive:
                        print("Scene: App is inactive")

                    case .background:
                        print("Scene: App is in background")

                    @unknown default:
                        print("Scene: Unknown state")
                    }
                }
        }
    }
}
