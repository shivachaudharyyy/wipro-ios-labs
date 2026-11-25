
import SwiftUI

struct ContentView: View {
    @State private var navigationPath: [NavigationItem] = []
    @State private var searchText = ""
    @State private var showingAppInfo = false

    private var visibleItems: [NavigationItem] {
        guard !searchText.isEmpty else {
            return NavigationItem.examples
        }

        return NavigationItem.examples.filter {
            $0.title.localizedCaseInsensitiveContains(searchText) ||
            $0.category.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        NavigationStack(path: $navigationPath) {
            List {
                Section {
                    ForEach(visibleItems) { item in
                        NavigationLink(value: item) {
                            ItemRow(item: item)
                        }
                    }
                } header: {
                    Text("Learning Topics")
                } footer: {
                    Text("Select a topic to see its details.")
                }
            }
            .navigationTitle("Navigation Demo")
            .searchable(text: $searchText, prompt: "Search topics")
            .navigationDestination(for: NavigationItem.self) { item in
                ItemDetailView(
                    item: item,
                    navigationPath: $navigationPath
                )
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAppInfo = true
                    } label: {
                        Image(systemName: "info.circle")
                    }
                    .accessibilityLabel("App information")
                }
            }
            .alert("About this App", isPresented: $showingAppInfo) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("This small app demonstrates the SwiftUI app entry point, a NavigationStack, and passing a selected model to a detail view.")
            }
        }
    }
}

private struct ItemRow: View {
    let item: NavigationItem

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(item.title)
                .font(.headline)

            Text(item.category)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 5)
    }
}

#Preview {
    ContentView()
}
