
import Foundation

// Model
struct TaskItem: Identifiable {
    let id: Int
    var title: String
    var isCompleted: Bool
}

//  Service
struct TaskService {

    func getPersonalTasks() async throws -> [TaskItem] {
        try await Task.sleep(nanoseconds: 2_000_000_000)

        return [
            TaskItem(id: 1, title: "Complete assignment", isCompleted: false),
            TaskItem(id: 2, title: "Read notes", isCompleted: true)
        ]
    }

    func getWorkTasks() async throws -> [TaskItem] {
        try await Task.sleep(nanoseconds: 3_000_000_000)

        return [
            TaskItem(id: 3, title: "Prepare report", isCompleted: false),
            TaskItem(id: 4, title: "Check project", isCompleted: false)
        ]
    }
}

// ViewModel
@MainActor
class TaskViewModel {

    private let service = TaskService()

    var tasks: [TaskItem] = []
    var isLoading = false

    func loadTasks() async {

        isLoading = true
        print("Loading tasks...")

        do {
            // Fetch both sources at the same time
            async let personal = service.getPersonalTasks()
            async let work = service.getWorkTasks()

            let result = try await (personal, work)

            try Task.checkCancellation()

            tasks = result.0 + result.1
            isLoading = false

            print("Tasks loaded successfully!")
            showTasks()

        } catch is CancellationError {
            isLoading = false
            print("Task loading cancelled.")

        } catch {
            isLoading = false
            print("Something went wrong: \(error)")
        }
    }

    func showTasks() {
        for task in tasks {
            print("\(task.title) - \(task.isCompleted ? "Done" : "Pending")")
        }
    }

    func completeTask(id: Int) {
        if let index = tasks.firstIndex(where: { $0.id == id }) {
            tasks[index].isCompleted.toggle()
        }
    }
}

// Task Group Example
func fetchNumbers() async -> [Int] {

    return await withTaskGroup(of: Int.self) { group in

        group.addTask { 10 }
        group.addTask { 20 }
        group.addTask { 30 }

        var numbers: [Int] = []

        for await number in group {
            numbers.append(number)
        }

        return numbers
    }
}

//  Main Program
@main
struct AssessmentApp {

    static func main() async {

        let viewModel = await TaskViewModel()

        // Load tasks
        await viewModel.loadTasks()

        // Update a task
        await viewModel.completeTask(id: 1)

        print("\nAfter updating a task:")
        await viewModel.showTasks()

        // Task group demonstration
        let numbers = await fetchNumbers()
        print("\nTask group results:", numbers)

        // GCD demonstration
        DispatchQueue.global().async {
            print("\nRunning background work using GCD")
        }

        print("\nAssessment completed.")
    }
}
