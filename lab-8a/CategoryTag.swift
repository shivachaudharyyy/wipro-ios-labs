
import SwiftUI

struct CategoryTag: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.caption)
            .fontWeight(.semibold)
            .padding(.horizontal, 14)
            .padding(.vertical, 9)
            .background(Color.blue.opacity(0.10))
            .foregroundStyle(.blue)
            .clipShape(Capsule())
    }
}
