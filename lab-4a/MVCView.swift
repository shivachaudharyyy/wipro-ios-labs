
import SwiftUI

struct MVCView: View {
    @StateObject var controller = TaskController()
    @State private var name = ""

    var body: some View {
        VStack {
            TextField("Enter task", text: $name)

            Button("Add") {
                controller.addTask(name)
                name = ""
            }

            List {
                ForEach(controller.tasks) { task in
                    HStack {
                        Button(task.isCompleted ? "Done" : "Complete") {
                            controller.completeTask(task)
                        }

                        Text(task.title)
                    }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        controller.deleteTask(controller.tasks[index])
                    }
                }
            }
        }
        .padding()
    }
}
