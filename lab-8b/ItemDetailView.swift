
import SwiftUI

struct ItemDetailView: View {
    let item: NavigationItem

    @Binding var navigationPath: [NavigationItem]
    @State private var isBookmarked = false

    var body: some View {
        List {
            Section("About this topic") {
                Text(item.description)
                    .font(.body)

                LabeledContent("Category", value: item.category)
            }

            Section("What you will cover") {
                ForEach(item.details, id: \.self) { detail in
                    Label(detail, systemImage: "checkmark.circle")
                        .foregroundStyle(.primary)
                }
            }
        }
        .navigationTitle(item.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isBookmarked.toggle()
                } label: {
                    Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                }
                .accessibilityLabel(
                    isBookmarked ? "Remove bookmark" : "Bookmark topic"
                )
            }

            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    navigationPath.removeAll()
                } label: {
                    Image(systemName: "house")
                }
                .accessibilityLabel("Go to home")
            }
        }
    }
}
