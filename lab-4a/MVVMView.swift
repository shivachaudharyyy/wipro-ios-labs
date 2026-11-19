
import SwiftUI

struct MVVMView: View {
    @StateObject var viewModel = TaskViewModel()
    @State private var name = ""

    var body: some View {
        VStack {
            TextField("Enter task", text: $name)

            Button("Add") {
                viewModel.addTask(name)
                name = ""
            }

            List {
                ForEach(viewModel.tasks) { task in
                    HStack {
                        Button(task.isCompleted ? "Done" : "Complete") {
                            viewModel.completeTask(task)
                        }

                        Text(task.title)
                    }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        viewModel.deleteTask(viewModel.tasks[index])
                    }
                }
            }
        }
        .padding()
    }
}
