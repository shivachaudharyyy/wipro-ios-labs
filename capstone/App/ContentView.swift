
import SwiftUI

struct ContentView: View {

    @StateObject private var viewModel = CourseViewModel()

    var body: some View {

        TabView {

            NavigationStack {
                DashboardView(viewModel: viewModel)
            }
            .tabItem {
                Label("Dashboard", systemImage: "house")
            }

            NavigationStack {
                AddCourseView(viewModel: viewModel)
            }
            .tabItem {
                Label("Add Course", systemImage: "plus.circle")
            }

            NavigationStack {
                CourseListView(viewModel: viewModel)
            }
            .tabItem {
                Label("My Courses", systemImage: "book.closed")
            }
        }
    }
}
