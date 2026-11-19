
import Foundation

// Details of a course
struct CourseDetail {
    let id: Int
    let name: String
    let duration: Int
}

// Function to simulate fetching course details
func fetchCourseDetails(courseID: Int) async throws -> CourseDetail {

    // Different courses take different amounts of time
    let delay = courseID * 1000

    try await Task.sleep(nanoseconds: UInt64(delay) * 1_000_000)

    // Simulate an error for course 3
    if courseID == 3 {
        throw NSError(
            domain: "CourseError",
            code: 404,
            userInfo: [NSLocalizedDescriptionKey: "Course not found"]
        )
    }

    return CourseDetail(
        id: courseID,
        name: "Course \(courseID)",
        duration: 10 + courseID
    )
}


//  Sequential Execution

func fetchSequentially(ids: [Int]) async {

    print("\n Sequential Execution ")

    let startTime = Date()

    for id in ids {
        do {
            let course = try await fetchCourseDetails(courseID: id)
            print("Fetched: \(course.name)")
        } catch {
            print("Failed to fetch course \(id): \(error.localizedDescription)")
        }
    }

    let elapsedTime = Date().timeIntervalSince(startTime)
    print("Sequential time: \(String(format: "%.2f", elapsedTime)) seconds")
}


//  Concurrent Execution using Task Group

func fetchConcurrently(ids: [Int]) async throws {

    print("\n Concurrent Execution ")

    let startTime = Date()

    // Store successful results and failed course IDs
    var courses: [CourseDetail] = []
    var failedIDs: [Int] = []

    try await withThrowingTaskGroup(of: Result<CourseDetail, Error>.self) { group in

        // Start all requests together
        for id in ids {
            group.addTask {
                do {
                    let course = try await fetchCourseDetails(courseID: id)
                    return .success(course)
                } catch {
                    return .failure(error)
                }
            }
        }

        // Collect results as tasks finish
        for try await result in group {

            try Task.checkCancellation()

            switch result {
            case .success(let course):
                courses.append(course)
                print("Successfully fetched: \(course.name)")

            case .failure(let error):
                print("One request failed: \(error.localizedDescription)")
                // Course ID 3 is the simulated failure
                failedIDs.append(3)
            }
        }
    }

    let elapsedTime = Date().timeIntervalSince(startTime)

    print("\nSuccessful courses:")
    for course in courses.sorted(by: { $0.id < $1.id }) {
        print("\(course.id). \(course.name) - \(course.duration) hours")
    }

    print("Failed course IDs: \(failedIDs)")
    print("Concurrent time: \(String(format: "%.2f", elapsedTime)) seconds")
}


// Main Program

@main
struct MainProgram {

    static func main() async {

        let courseIDs = [1, 2, 3, 4, 5]

        print("Task Groups and Structured Concurrency")
      
        // First run sequentially
        await fetchSequentially(ids: courseIDs)

        // Then run concurrently
        do {
            try await fetchConcurrently(ids: courseIDs)
        } catch {
            print("Operation cancelled: \(error)")
        }

        print("\nProgram finished.")
    }
}
