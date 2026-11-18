import Foundation

// Calculate the average
func calculateMean(_ numbers: [Int]) -> Double {
    guard !numbers.isEmpty else { return 0 }

    let total = numbers.reduce(0, +)
    return Double(total) / Double(numbers.count)
}

// Find the biggest number
func findMaximum(_ numbers: [Int]) -> Int {
    return numbers.max() ?? 0
}

// Check email address
func checkEmail(_ email: String) -> Bool {
    let parts = email.split(separator: "@")

    return parts.count == 2 &&
           parts[1].contains(".") &&
           !email.contains(" ")
}

// Format person's name
func formatName(_ name: String) -> String {
    return name
        .trimmingCharacters(in: .whitespaces)
        .lowercased()
        .split(separator: " ")
        .map { $0.capitalized }
        .joined(separator: " ")
}

// 2. Calculate total expenses
struct Transaction {
    var type: String
    var amount: Int
}

func totalExpenses(_ transactions: [Transaction]) -> Int {
    return transactions
        .filter { $0.type == "expense" }
        .map { $0.amount }
        .reduce(0, +)
}

// 3. Sort students by marks and name
struct Student {
    var name: String
    var marks: Int
}

func sortStudents(_ students: [Student]) -> [Student] {
    return students.sorted {
        if $0.marks == $1.marks {
            return $0.name < $1.name
        }
        return $0.marks > $1.marks
    }
}

// Sample data
let numbers = [10, 20, 30, 40, 50]

let transactions = [
    Transaction(type: "income", amount: 5000),
    Transaction(type: "expense", amount: 1000),
    Transaction(type: "expense", amount: 500),
    Transaction(type: "expense", amount: 300)
]

let students = [
    Student(name: "Rahul", marks: 85),
    Student(name: "Aman", marks: 95),
    Student(name: "Priya", marks: 85),
    Student(name: "Neha", marks: 95)
]

// Display results
print("Average:", calculateMean(numbers))
print("Maximum:", findMaximum(numbers))
print("Email valid:", checkEmail("student@gmail.com"))
print("Formatted name:", formatName("  rAHUL kumar "))
print("Total expenses:", totalExpenses(transactions))

print("\nSorted Students:")

for student in sortStudents(students) {
    print("\(student.name) - \(student.marks)")
}
