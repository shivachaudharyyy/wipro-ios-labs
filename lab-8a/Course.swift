
import Foundation

struct Course: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let instructor: String
    let category: String
    let duration: String
    let level: String
    let description: String
    let topics: [String]
    let status: String

    static let sampleCourses: [Course] = [
        Course(
            title: "SwiftUI Fundamentals",
            instructor: "Alex Morgan",
            category: "iOS Development",
            duration: "6 Weeks",
            level: "Beginner",
            description: "Learn how to build iOS applications with SwiftUI. Explore views, layouts, and navigation while creating a simple app.",
            topics: [
                "Introduction to SwiftUI",
                "Stacks and layouts",
                "Creating reusable views",
                "Navigation and lists"
            ],
            status: "Popular"
        ),
        Course(
            title: "UI Design Basics",
            instructor: "Sarah Johnson",
            category: "Design",
            duration: "4 Weeks",
            level: "Beginner",
            description: "Learn the foundations of user interface design and understand how to create clean, easy-to-use screens.",
            topics: [
                "Design principles",
                "Colors and typography",
                "Spacing and alignment",
                "Reusable UI components"
            ],
            status: "New"
        ),
        Course(
            title: "Advanced Swift",
            instructor: "David Wilson",
            category: "Programming",
            duration: "8 Weeks",
            level: "Advanced",
            description: "Build on your Swift knowledge and explore concepts commonly used in larger applications.",
            topics: [
                "Closures",
                "Protocols",
                "Generics",
                "Error handling"
            ],
            status: "Trending"
        ),
        Course(
            title: "Mobile App Development",
            instructor: "Emily Brown",
            category: "Development",
            duration: "5 Weeks",
            level: "Intermediate",
            description: "Explore the mobile app development process, from planning an app to testing its main features.",
            topics: [
                "App architecture",
                "Working with APIs",
                "Managing data",
                "Testing applications"
            ],
            status: "Popular"
        )
    ]
}
