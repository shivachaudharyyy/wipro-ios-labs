
import Foundation

// Student details
struct Student {
    var id: Int
    var name: String
    var marks: Int
}

// Sample student data
let students = [
    Student(id: 1, name: "Rahul", marks: 85),
    Student(id: 2, name: "Aman", marks: 90),
    Student(id: 3, name: "Priya", marks: 78)
]

//  Function to find student marks using ID
func findMarks(id: Int) -> Int? {
    for student in students {
        if student.id == id {
            return student.marks
        }
    }
    return nil
}

//  Demonstrating optional handling

let result = findMarks(id: 1)

// Using if let
if let marks = result {
    print("Marks: \(marks)")
} else {
    print("Student not found")
}

// Using guard let
func showMarks(id: Int) {
    guard let marks = findMarks(id: id) else {
        print("No student found")
        return
    }

    print("Student marks: \(marks)")
}

showMarks(id: 2)

// Optional chaining
let studentName: String? = students.first?.name
print("Student name: \(studentName ?? "Unknown")")

// Nil coalescing operator
let defaultMarks = findMarks(id: 10) ?? 0
print("Default marks: \(defaultMarks)")

// 3. Handling missing dictionary key
var studentInfo = [
    "name": "Rahul",
    "course": "Swift"
]

let age = studentInfo["age"] ?? "Age not available"
print(age)

// Handling empty text field
var userText = ""

if userText.isEmpty {
    print("Text field is empty")
} else {
    print(userText)
}

// 4. Avoiding force unwrapping

let optionalValue: Int? = nil

if let value = optionalValue {
    print(value)
} else {
    print("Value is missing")
}

// 5. Optional profile model (Extension)
struct Profile {
    var name: String
    var address: String?
    var phone: String?
}

let profile = Profile(
    name: "Rahul",
    address: nil,
    phone: nil
)

print("Name: \(profile.name)")
print("Address: \(profile.address ?? "Not provided")")
print("Phone: \(profile.phone ?? "Not provided")")

