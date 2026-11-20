
import Foundation

struct Course {

    let title: String
    let instructor: String
    let duration: String
    let description: String

    static let sampleCourses = [

        Course(
            title: "iOS Development",
            instructor: "Rahul Sharma",
            duration: "8 Weeks",
            description: "Learn how to build iOS applications using Swift and UIKit. This course covers layouts, navigation, table views and basic app development."
        ),

        Course(
            title: "Web Development",
            instructor: "Amit Verma",
            duration: "10 Weeks",
            description: "Learn frontend and backend web development with HTML, CSS, JavaScript and modern web technologies."
        ),

        Course(
            title: "Data Structures",
            instructor: "Priya Singh",
            duration: "6 Weeks",
            description: "Understand arrays, linked lists, stacks, queues, trees and other important data structures."
        ),

        Course(
            title: "Python Programming",
            instructor: "Neha Gupta",
            duration: "5 Weeks",
            description: "Learn Python fundamentals, functions, loops, object-oriented programming and practical problem solving."
        ),

        Course(
            title: "Database Management",
            instructor: "Rohit Kumar",
            duration: "4 Weeks",
            description: "Understand SQL, database design, queries, relationships and database management concepts."
        )
    ]
}
