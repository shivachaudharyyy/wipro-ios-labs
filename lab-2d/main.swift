
import Foundation

// Custom Error Enum

enum ValidationError: Error {
    case emptyName
    case invalidMark
    case invalidID
}

// Student Structure

struct Student {
    let id: Int
    let name: String
    let mark: Double
}

//  Student Registration Function

func registerStudent(id: Int, name: String, mark: Double) throws -> Student {

    if name.trimmingCharacters(in: .whitespaces).isEmpty {
        throw ValidationError.emptyName
    }

    if mark < 0 || mark > 100 {
        throw ValidationError.invalidMark
    }

    if id <= 0 {
        throw ValidationError.invalidID
    }

    let student = Student(id: id, name: name, mark: mark)

    return student
}

//  Error Handling

func showRegistration(id: Int, name: String, mark: Double) {

    do {
        let student = try registerStudent(
            id: id,
            name: name,
            mark: mark
        )

        print("Student registered successfully!")
        print("ID: \(student.id)")
        print("Name: \(student.name)")
        print("Mark: \(student.mark)")

    } catch ValidationError.emptyName {
        print("Error: Student name cannot be empty.")

    } catch ValidationError.invalidMark {
        print("Error: Mark must be between 0 and 100.")

    } catch ValidationError.invalidID {
        print("Error: Student ID must be greater than zero.")

    } catch {
        print("Something went wrong: \(error)")
    }
}

// Testing

print("Test 1: Valid Student")
showRegistration(id: 101, name: "Rahul", mark: 85)

print("\n Test 2: Empty Name ")
showRegistration(id: 102, name: "", mark: 75)

print("\n Test 3: Invalid Mark ")
showRegistration(id: 103, name: "Aman", mark: 120)

print("\n Test 4: Invalid ID ")
showRegistration(id: -1, name: "Priya", mark: 90)
