import SwiftUI

struct SecondView: View {

    var body: some View {

        VStack(spacing: 20) {

            Text("Second Screen")
                .font(.largeTitle)
                .bold()

            Text("This is the second page of the app.")

            Text("Go back to see the first screen again.")
                .foregroundColor(.gray)
        }
        .navigationTitle("Second Screen")
        .onAppear {
            print("Second View: Appeared")
        }
        .onDisappear {
            print("Second View: Disappeared")
        }
    }
}
