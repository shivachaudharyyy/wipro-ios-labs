
import Foundation

protocol CourseStorageService {
    func loadCourses() throws -> [Course]
    func saveCourses(_ courses: [Course]) throws
}

struct UserDefaultsCourseStorage: CourseStorageService {

    private let storageKey = "saved_courses"

    private let defaults: UserDefaults

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    func loadCourses() throws -> [Course] {

        guard let savedData = defaults.data(forKey: storageKey) else {
            return []
        }

        return try JSONDecoder().decode(
            [Course].self,
            from: savedData
        )
    }

    func saveCourses(_ courses: [Course]) throws {

        let encodedData = try JSONEncoder().encode(courses)

        defaults.set(encodedData, forKey: storageKey)
    }
}
