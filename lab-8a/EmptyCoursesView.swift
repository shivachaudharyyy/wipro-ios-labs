
import SwiftUI

struct EmptyCoursesView: View {
    var body: some View {
        VStack(spacing: 14) {
            Image(systemName: "book.closed")
                .font(.system(size: 45))
                .foregroundStyle(.secondary)

            Text("No Courses Available")
                .font(.headline)

            Text("There are currently no courses to display. Please check back later.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 45)
        .padding(.horizontal)
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
