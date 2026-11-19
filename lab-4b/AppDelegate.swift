import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions:
        [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {

        print("App: Finished launching")
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        print("App: Will become inactive")
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        print("App: Became active")
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        print("App: Entered background")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        print("App: Will enter foreground")
    }

    func applicationWillTerminate(_ application: UIApplication) {
        print("App: Will terminate")
    }
}
