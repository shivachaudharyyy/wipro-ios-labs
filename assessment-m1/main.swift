import Foundation

// TASK 1: Working with a Gradebook

var gradebook: [String: [Int]] = [
    "shreya": [88, 92, 95],
    "priya": [75, 80, 82],
    "zack": [90, 85, 88]
]

// Function to calculate average marks
func showAverage(studentName: String, grades: [String: [Int]]) {

    if let marks = grades[studentName] {

        if marks.isEmpty {
            print("\(studentName) has no grades recorded.")
            return
        }

        let totalMarks = marks.reduce(0, +)
        let average = Double(totalMarks) / Double(marks.count)

        print("\(studentName)'s average grade is: \(average)")

    } else {
        print("Student '\(studentName)' not found in the gradebook.")
    }
}

print("\n TASK 1 OUTPUT ")

showAverage(studentName: "shreya", grades: gradebook)
showAverage(studentName: "priya", grades: gradebook)
showAverage(studentName: "ayan", grades: gradebook)

// TASK 2: Creating a Generic Stack


struct Stack<T> {

    private var items: [T] = []

    // Adding an element
    mutating func push(_ item: T) {
        items.append(item)
    }

    // Removing the last element
    mutating func pop() -> T? {
        return items.popLast()
    }

    // Getting the top element
    var peek: T? {
        return items.last
    }
}

print("\n TASK 2 OUTPUT ")

// Testing stack with numbers
var numberStack = Stack<Int>()

numberStack.push(10)
numberStack.push(20)
numberStack.push(30)

print("Popped from Int stack: \(numberStack.pop() ?? 0)")
print("Top element: \(numberStack.peek ?? 0)")

// Testing stack with strings
var wordStack = Stack<String>()

wordStack.push("Hello")
wordStack.push("Swift")

print("Popped from String stack: \(wordStack.pop() ?? "")")
print("Top element: \(wordStack.peek ?? "Empty")")

// TASK 3: Handling Retain Cycles


class Person {

    var name: String
    var car: Car?

    init(name: String) {
        self.name = name
    }

    deinit {
        print("Person \(name) was deinitialized.")
    }
}

class Car {

    var model: String

    // Weak reference avoids retain cycle
    weak var owner: Person?

    init(model: String) {
        self.model = model
    }

    deinit {
        print("Car \(model) was deinitialized.")
    }
}

print("\n TASK 3 OUTPUT ")

do {

    let person = Person(name: "John")
    let car = Car(model: "Tesla")

    person.car = car
    car.owner = person

    print("Objects created inside scope.")

}

print("Scope ended.")

// TASK 4: Username Validation and Error Handling


// Creating custom errors
enum ValidationError: Error {

    case usernameTooShort(String)
    case invalidCharacters(String)
}

// Function to validate username
func checkUsername(_ username: String) throws {

    if username.count < 4 {

        throw ValidationError.usernameTooShort(
            "Username must be at least 4 characters long."
        )
    }

    let specialCharacters = CharacterSet(
        charactersIn: "!@#$%^&*() "
    )

    if username.rangeOfCharacter(from: specialCharacters) != nil {

        throw ValidationError.invalidCharacters(
            "Username cannot contain spaces or special characters."
        )
    }

    print("Username '\(username)' is valid!")
}

print("\n TASK 4 OUTPUT ")

// Testing different usernames
let usernames = ["bob", "alex!", "developer_one"]

for username in usernames {

    do {

        try checkUsername(username)

    } catch ValidationError.usernameTooShort(let message) {

        print("Validation Error: \(message)")

    } catch ValidationError.invalidCharacters(let message) {

        print("Validation Error: \(message)")

    } catch {

        print("An unexpected error occurred.")
    }
}



// TASK 5: Map, Filter and Reduce


print("\n TASK 5 OUTPUT ")

// Map example
let numbers = [1, 2, 3, 4, 5]

let doubledNumbers = numbers.map { $0 * 2 }

print("Map Output: \(doubledNumbers)")

// Filter example
let evenNumbers = numbers.filter { $0 % 2 == 0 }

print("Filter Output: \(evenNumbers)")

// Reduce example
let total = numbers.reduce(0, +)

print("Reduce Output: \(total)")
