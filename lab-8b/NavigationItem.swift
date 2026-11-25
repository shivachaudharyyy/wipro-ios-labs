
import Foundation

struct NavigationItem: Identifiable, Hashable {
    let id: Int
    let title: String
    let category: String
    let description: String
    let details: [String]

    static let examples: [NavigationItem] = [
        NavigationItem(
            id: 1,
            title: "SwiftUI Basics",
            category: "Development",
            description: "Get familiar with the building blocks of SwiftUI and learn how views are put together.",
            details: [
                "Text and Image views",
                "Stacks and spacing",
                "Modifiers",
                "SwiftUI previews"
            ]
        ),
        NavigationItem(
            id: 2,
            title: "Navigation in SwiftUI",
            category: "iOS",
            description: "Learn how to move between screens and pass information to another view.",
            details: [
                "NavigationStack",
                "NavigationLink",
                "Navigation destinations",
                "Back navigation"
            ]
        ),
        NavigationItem(
            id: 3,
            title: "Working with Lists",
            category: "Interface",
            description: "Display collections of information in a clean and organized way.",
            details: [
                "List",
                "ForEach",
                "Identifiable models",
                "Row layouts"
            ]
        ),
        NavigationItem(
            id: 4,
            title: "Reusable Components",
            category: "Development",
            description: "Break a screen into smaller views that are easier to understand and maintain.",
            details: [
                "Custom views",
                "View properties",
                "Passing data",
                "Keeping code organized"
            ]
        ),
        NavigationItem(
            id: 5,
            title: "App Structure",
            category: "Basics",
            description: "Understand where a SwiftUI application starts and how its first screen is displayed.",
            details: [
                "The @main attribute",
                "App protocol",
                "WindowGroup",
                "Root view"
            ]
        )
    ]
}
