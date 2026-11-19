
import Foundation
import Combine

class TaskController: ObservableObject {
    @Published var tasks: [Task] = []

    func addTask(_ title: String) {
        if !title.isEmpty {
            tasks.append(Task(title: title))
        }
    }

    func completeTask(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
        }
    }

    func deleteTask(_ task: Task) {
        tasks.removeAll { $0.id == task.id }
    }
}
