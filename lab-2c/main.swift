import Foundation

// Creating a protocol
protocol Displayable {
    func displayInfo() -> String
}

// Student follows the Displayable protocol
struct Student: Displayable {
    var name: String
    var marks: Int

    func displayInfo() -> String {
        return "Name: \(name), Marks: \(marks)"
    }
}

// Course also follows the Displayable protocol
struct Course: Displayable {
    var name: String
    var duration: String

    func displayInfo() -> String {
        return "Course: \(name), Duration: \(duration)"
    }
}

// Adding extra features using extension
extension String {

    var characterCount: Int {
        return self.count
    }

    var isBlank: Bool {
        return self.trimmingCharacters(
            in: .whitespacesAndNewlines
        ).isEmpty
    }
}

// Creating a generic Stack
struct Stack<T> {

    private var items: [T] = []

    mutating func push(_ item: T) {
        items.append(item)
    }

    mutating func pop() -> T? {
        return items.popLast()
    }

    func peek() -> T? {
        return items.last
    }

    var isEmpty: Bool {
        return items.isEmpty
    }
}

//  Generic function with protocol constraint
func showDetails<T: Displayable>(_ item: T) {
    print(item.displayInfo())
}

// Testing protocol
print(" PROTOCOL")

let student = Student(name: "Rahul", marks: 90)
let course = Course(name: "Swift", duration: "3 Months")

showDetails(student)
showDetails(course)

// Testing extension
print("\n EXTENSION ")

let name = "Rahul Kumar"

print("Name:", name)
print("Characters:", name.characterCount)
print("Is blank:", name.isBlank)

// Testing integer stack
print("\n INTEGER STACK ")

var numberStack = Stack<Int>()

numberStack.push(10)
numberStack.push(20)
numberStack.push(30)

print("Top item:", numberStack.peek() ?? 0)
print("Removed item:", numberStack.pop() ?? 0)
print("New top:", numberStack.peek() ?? 0)
print("Is empty:", numberStack.isEmpty)

// Testing string stack
print("\n STRING STACK ")

var nameStack = Stack<String>()

nameStack.push("Rahul")
nameStack.push("Aman")
nameStack.push("Priya")

print("Top name:", nameStack.peek() ?? "None")
print("Removed name:", nameStack.pop() ?? "None")

// Example checks
print("\n TESTING ")

assert(student.marks == 90)
assert(course.name == "Swift")
assert("Hello".characterCount == 5)
assert("   ".isBlank == true)

var testStack = Stack<Int>()
testStack.push(100)

assert(testStack.peek() == 100)
assert(testStack.pop() == 100)
assert(testStack.isEmpty == true)

print("All 7 tests passed successfully!")


