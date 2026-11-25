
import SwiftUI

struct RegistrationReviewView: View {

    let registration: Registration

    @State private var showingConfirmation = false

    var body: some View {
        Form {

            Section("Check Your Details") {

                LabeledContent(
                    "Name",
                    value: registration.fullName
                )

                LabeledContent(
                    "Email",
                    value: registration.email
                )

                if !registration.organization.isEmpty {
                    LabeledContent(
                        "Organization",
                        value: registration.organization
                    )
                }

                LabeledContent(
                    "Event",
                    value: registration.eventType
                )

                LabeledContent(
                    "Event updates",
                    value: registration.wantsUpdates ? "Yes" : "No"
                )
            }

            if !registration.notes.isEmpty {
                Section("Your Notes") {
                    Text(registration.notes)
                        .fixedSize(
                            horizontal: false,
                            vertical: true
                        )
                }
            }

            Section {
                Button {
                    showingConfirmation = true
                } label: {
                    HStack {
                        Spacer()

                        Text("Confirm Registration")
                            .fontWeight(.semibold)

                        Spacer()
                    }
                }

            } footer: {
                Text(
                    "Please check the information above before confirming."
                )
            }
        }
        .navigationTitle("Review")
        .navigationBarTitleDisplayMode(.inline)
        .alert(
            "Registration Complete",
            isPresented: $showingConfirmation
        ) {
            Button("Done", role: .cancel) { }
        } message: {
            Text(
                "Thanks, \(registration.fullName). Your registration details have been submitted."
            )
        }
    }
}

#Preview {
    NavigationStack {
        RegistrationReviewView(
            registration: Registration(
                fullName: "Taylor Smith",
                email: "taylor@example.com",
                organization: "Example Studio",
                eventType: "SwiftUI Workshop",
                wantsUpdates: true,
                notes: "Looking forward to attending."
            )
        )
    }
}
