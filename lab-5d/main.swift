
import Foundation

//  Unsafe Counter (Before Fix)

class UnsafeCounter {
    var count = 0

    func increment() {
        count += 1
    }
}

//  Safe Counter (After Fix)

actor SafeCounter {
    private var count = 0

    func increment() {
        count += 1
    }

    func getCount() -> Int {
        return count
    }
}

//  Sendable Example

struct Student: Sendable {
    let name: String
    let age: Int
}

//  Main Program

@main
struct Main {

    static func main() async {

        print("----- Concurrency Safety Lab 5D -----")

        // 1. Unsafe counter example

        let unsafeCounter = UnsafeCounter()

        await withTaskGroup(of: Void.self) { group in
            for _ in 0..<10 {
                group.addTask {
                    for _ in 0..<1000 {
                        unsafeCounter.increment()
                    }
                }
            }
        }

        print("\nUnsafe Counter Result:")
        print("Count:", unsafeCounter.count)

        // 2. Safe counter using Actor

        let safeCounter = SafeCounter()

        await withTaskGroup(of: Void.self) { group in
            for _ in 0..<10 {
                group.addTask {
                    for _ in 0..<1000 {
                        await safeCounter.increment()
                    }
                }
            }
        }

        let result = await safeCounter.getCount()

        print("\nSafe Counter Result:")
        print("Count:", result)

        // 3. Sendable example

        let student = Student(name: "Rahul", age: 20)

        print("\nSendable Example:")
        print("Name:", student.name)
        print("Age:", student.age)

        // 4. Repeated counter test

        let testCounter = SafeCounter()

        for _ in 0..<5 {
            await withTaskGroup(of: Void.self) { group in
                for _ in 0..<10 {
                    group.addTask {
                        for _ in 0..<1000 {
                            await testCounter.increment()
                        }
                    }
                }
            }
        }

        let testResult = await testCounter.getCount()

        print("\nRepeated Test Result:")
        print("Count:", testResult)

        assert(testResult == 50000, "Test Failed!")

        print("Test Passed!")

        print("\n Lab Completed ")
    }
}
