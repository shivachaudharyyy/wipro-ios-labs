
import Foundation

struct Course: Identifiable, Hashable {
    let id: Int
    let title: String
    let category: String
    let instructor: String
    let duration: String
    let level: String
    let description: String
    let topics: [String]

    static let sampleCourses: [Course] = [
        Course(
            id: 1,
            title: "SwiftUI Fundamentals",
            category: "iOS Development",
            instructor: "Alex Morgan",
            duration: "6 Weeks",
            level: "Beginner",
            description: "Learn the basics of building iOS interfaces with SwiftUI. This course covers views, layouts, and simple navigation.",
            topics: [
                "Introduction to SwiftUI",
                "Stacks and layout",
                "Working with modifiers",
                "Building reusable views"
            ]
        ),
        Course(
            id: 2,
            title: "UI Design Basics",
            category: "Design",
            instructor: "Sarah Johnson",
            duration: "4 Weeks",
            level: "Beginner",
            description: "Understand the basic ideas behind a clear and user-friendly interface, from choosing colors to arranging content.",
            topics: [
                "Color and typography",
                "Spacing and alignment",
                "Design consistency",
                "Building simple screens"
            ]
        ),
        Course(
            id: 3,
            title: "Advanced Swift",
            category: "Programming",
            instructor: "David Wilson",
            duration: "8 Weeks",
            level: "Advanced",
            description: "Explore some of Swift's more powerful language features and see how they help organize application code.",
            topics: [
                "Closures",
                "Protocols",
                "Generics",
                "Error handling"
            ]
        ),
        Course(
            id: 4,
            title: "Mobile App Development",
            category: "Development",
            instructor: "Emily Brown",
            duration: "5 Weeks",
            level: "Intermediate",
            description: "Get an overview of the mobile app development process and the steps involved in building a useful application.",
            topics: [
                "Planning an app",
                "App structure",
                "Working with data",
                "Testing an application"
            ]
        )
    ]
}
