
import Foundation
import Combine

final class CourseStore: ObservableObject {

    @Published var courses: [Course] = Course.sampleCourses

    @Published var favoriteIDs: Set<Int> {
        didSet {
            saveFavorites()
        }
    }

    private let favoritesKey = "savedCourseFavorites"

    init() {
        let savedIDs = UserDefaults.standard.array(
            forKey: favoritesKey
        ) as? [Int] ?? []

        favoriteIDs = Set(savedIDs)
    }

    func toggleFavorite(for course: Course) {
        if favoriteIDs.contains(course.id) {
            favoriteIDs.remove(course.id)
        } else {
            favoriteIDs.insert(course.id)
        }
    }

    func isFavorite(_ course: Course) -> Bool {
        favoriteIDs.contains(course.id)
    }

    private func saveFavorites() {
        UserDefaults.standard.set(
            Array(favoriteIDs),
            forKey: favoritesKey
        )
    }
}
