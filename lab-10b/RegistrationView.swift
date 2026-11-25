
import SwiftUI

struct RegistrationView: View {

    @State private var name = ""
    @State private var email = ""
    @State private var errorMessage = ""
    @State private var isRegistered = false

    private var isFormValid: Bool {
        let cleanName = name.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        let cleanEmail = email.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        return !cleanName.isEmpty &&
            cleanEmail.contains("@") &&
            cleanEmail.contains(".")
    }

    var body: some View {

        NavigationStack {
            Form {

                Section("Personal Details") {

                    TextField("Enter your name", text: $name)
                        .accessibilityIdentifier("nameField")

                    TextField("Enter your email", text: $email)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .accessibilityIdentifier("emailField")
                }

                Section {

                    Button("Submit Registration") {
                        submitForm()
                    }
                    .disabled(!isFormValid)
                    .accessibilityIdentifier("submitButton")
                }

                if !errorMessage.isEmpty {

                    Text(errorMessage)
                        .foregroundColor(.red)
                        .accessibilityIdentifier("errorMessage")
                }

                if isRegistered {

                    Text("Registration completed successfully!")
                        .foregroundColor(.green)
                        .accessibilityIdentifier("successMessage")
                }
            }
            .navigationTitle("Event Registration")
        }
    }

    private func submitForm() {

        let cleanName = name.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        let cleanEmail = email.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !cleanName.isEmpty,
              cleanEmail.contains("@"),
              cleanEmail.contains(".") else {

            errorMessage = "Please enter valid details."
            return
        }

        errorMessage = ""
        isRegistered = true
    }
}

#Preview {
    RegistrationView()
}
