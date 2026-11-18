
import SwiftUI

struct ContentView: View {

    @State private var name = ""
    @State private var result = "Your result will appear here"

    var body: some View {
        VStack(spacing: 20) {

            // Screen title
            Text("Welcome Screen")
                .font(.largeTitle)
                .fontWeight(.bold)

            // Text field
            TextField("Enter your name", text: $name)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)

            // Button
            Button(action: {
                if name.isEmpty {
                    result = "Please enter your name"
                } else {
                    result = "Hello, \(name)!"
                }
            }) {
                Text("Submit")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.horizontal)

            // Result label
            Text(result)
                .font(.headline)
                .foregroundColor(.gray)

            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
