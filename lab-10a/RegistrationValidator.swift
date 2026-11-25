
import Foundation

struct RegistrationValidator {

    func isValidName(_ name: String) -> Bool {

        let cleanedName = name.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        return !cleanedName.isEmpty
    }

    func isValidEmail(_ email: String) -> Bool {

        let cleanedEmail = email.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

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

    func isValidRegistration(
        name: String,
        email: String
    ) -> Bool {

        return isValidName(name) &&
            isValidEmail(email)
    }
}
