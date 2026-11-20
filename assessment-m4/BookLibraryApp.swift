
import SwiftUI

@main
struct BookLibraryApp: App {

    @StateObject private var library = LibraryStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(library)
        }
    }
}
