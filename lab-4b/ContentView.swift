import SwiftUI

struct ContentView: View {

    var body: some View {
        NavigationStack {

            VStack(spacing: 20) {

                Text("Home Screen")
                    .font(.largeTitle)
                    .bold()

                Text("Welcome to Lifecycle Demo")

                NavigationLink(destination: SecondView()) {
                    Text("Go to Second Screen")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .navigationTitle("Home")
            .onAppear {
                print("Home View: Appeared")
                refreshHomeData()
            }
            .onDisappear {
                print("Home View: Disappeared")
            }
        }
    }

    // A small refresh action when the screen appears
    func refreshHomeData() {
        print("Home View: Refreshing data")
    }
}
