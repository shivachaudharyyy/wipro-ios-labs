import Foundation

//  Sorting students using a closure

struct Student {
    var name: String
    var marks: Int
}

let students = [
    Student(name: "Rahul", marks: 85),
    Student(name: "Aman", marks: 95),
    Student(name: "Priya", marks: 80),
    Student(name: "Neha", marks: 95),
    Student(name: "Karan", marks: 70)
]

// Sorting students by marks, highest first
let sortedStudents = students.sorted {
    $0.marks > $1.marks
}

print("Students sorted by marks:")

for student in sortedStudents {
    print("\(student.name) - \(student.marks)")
}


//Function that accepts a completion closure

func performOperation(completion: () -> Void) {
    print("\nOperation started...")

    // Simulating some work
    print("Operation completed!")

    // Calling the completion closure
    completion()
}

performOperation {
    print("The task is finished successfully.")
}


//Trailing closure and shorthand argument names

let numbers = [10, 20, 30, 40, 50]

// Using shorthand argument name $0
let doubledNumbers = numbers.map {
    $0 * 2
}

print("\nDoubled numbers:", doubledNumbers)

// Same example using an explicit parameter name
let tripledNumbers = numbers.map { number in
    return number * 3
}

print("Tripled numbers:", tripledNumbers)


//Counter closure and captured state

func createCounter() -> () -> Int {
    var count = 0

    // The closure remembers the value of count
    let counter = {
        count += 1
        return count
    }

    return counter
}

let myCounter = createCounter()

print("\nCounter values:")
print(myCounter())
print(myCounter())
print(myCounter())
print(myCounter())


//Avoiding retain cycles using weak self

class StudentManager {
    var studentName = "Rahul"

    var showDetails: (() -> Void)?

    func setupDetails() {
        // weak self prevents a strong reference cycle
        showDetails = { [weak self] in
            guard let self = self else {
                return
            }

            print("\nStudent name:", self.studentName)
        }
    }

    deinit {
        print("StudentManager object removed from memory.")
    }
}

var manager: StudentManager? = StudentManager()

manager?.setupDetails()
manager?.showDetails?()

// Releasing the object
manager = nil


// Optional Extension: Simple retry helper

func retryOperation(times: Int, operation: () -> Bool) -> Bool {

    for attempt in 1...max(1, times) {
        print("\nAttempt \(attempt)")

        if operation() {
            print("Operation successful!")
            return true
        }

        print("Operation failed. Trying again...")
    }

    print("All attempts finished.")
    return false
}

// Testing the retry function
var attemptCount = 0

retryOperation(times: 3) {
    attemptCount += 1

    // Simulating success on the third attempt
    return attemptCount == 3
}
