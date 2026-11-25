
import SwiftUI

struct RegistrationFormView: View {

    @State private var fullName = ""
    @State private var email = ""
    @State private var organization = ""
    @State private var eventType = "Choose an event"
    @State private var wantsUpdates = false
    @State private var notes = ""

    @State private var showingReview = false

    private let eventOptions = [
        "Choose an event",
        "SwiftUI Workshop",
        "iOS Development Meetup",
        "App Design Seminar",
        "Developer Conference"
    ]

    private var cleanedName: String {
        fullName.trimmingCharacters(
            in: .whitespacesAndNewlines
        )
    }

    private var cleanedEmail: String {
        email.trimmingCharacters(
            in: .whitespacesAndNewlines
        )
    }

    private var isEmailValid: Bool {
        let parts = cleanedEmail.split(
            separator: "@",
            omittingEmptySubsequences: false
        )

        guard parts.count == 2,
              !parts[0].isEmpty else {
            return false
        }

        let domain = String(parts[1])

        return domain.contains(".") &&
            !domain.hasPrefix(".") &&
            !domain.hasSuffix(".") &&
            !cleanedEmail.contains(" ")
    }

    private var isFormValid: Bool {
        !cleanedName.isEmpty &&
        isEmailValid &&
        eventType != "Choose an event"
    }

    private var registration: Registration {
        Registration(
            fullName: cleanedName,
            email: cleanedEmail,
            organization: organization.trimmingCharacters(
                in: .whitespacesAndNewlines
            ),
            eventType: eventType,
            wantsUpdates: wantsUpdates,
            notes: notes.trimmingCharacters(
                in: .whitespacesAndNewlines
            )
        )
    }

    var body: some View {
        NavigationStack {
            Form {

                Section {
                    Text("Fill in your details to reserve a place at one of our upcoming events.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .fixedSize(
                            horizontal: false,
                            vertical: true
                        )
                } header: {
                    Text("Event Registration")
                }

                Section("Your Details") {

                    VStack(alignment: .leading, spacing: 5) {
                        TextField("Full name *", text: $fullName)
                            .textContentType(.name)
                            .textInputAutocapitalization(.words)

                        if cleanedName.isEmpty {
                            validationMessage(
                                "Please enter your name."
                            )
                        }
                    }

                    VStack(alignment: .leading, spacing: 5) {
                        TextField("Email address *", text: $email)
                            .textContentType(.emailAddress)
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()

                        if cleanedEmail.isEmpty {
                            validationMessage(
                                "Email address is required."
                            )
                        } else if !isEmailValid {
                            validationMessage(
                                "Please enter a valid email address."
                            )
                        }
                    }

                    TextField(
                        "Organization (optional)",
                        text: $organization
                    )
                    .textInputAutocapitalization(.words)
                }

                Section("Choose Your Event") {

                    Picker("Event", selection: $eventType) {
                        ForEach(eventOptions, id: \.self) { option in
                            Text(option).tag(option)
                        }
                    }

                    if eventType == "Choose an event" {
                        validationMessage(
                            "Please select an event."
                        )
                    }
                }

                Section("More Information") {

                    Toggle(
                        "Send me event updates",
                        isOn: $wantsUpdates
                    )

                    VStack(alignment: .leading, spacing: 6) {
                        Text("Notes (optional)")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)

                        TextField(
                            "Anything you would like us to know?",
                            text: $notes,
                            axis: .vertical
                        )
                        .lineLimit(3...6)
                    }
                }

                Section {
                    Button {
                        showingReview = true
                    } label: {
                        HStack {
                            Spacer()

                            Text("Review Registration")
                                .fontWeight(.semibold)

                            Spacer()
                        }
                    }
                    .disabled(!isFormValid)

                } footer: {
                    Text(
                        "Fields marked with * are required. Complete them to continue."
                    )
                }
            }
            .navigationTitle("Register")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(
                isPresented: $showingReview
            ) {
                RegistrationReviewView(
                    registration: registration
                )
            }
        }
    }

    private func validationMessage(_ message: String) -> some View {
        Text(message)
            .font(.caption)
            .foregroundStyle(.red)
    }
}

#Preview {
    RegistrationFormView()
}
