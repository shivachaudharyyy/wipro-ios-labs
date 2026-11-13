import Foundation

//  Course using struct
struct Course {
    var name: String
    var duration: Int
}

class CourseManager {
    var course: Course

    init(course: Course) {
        self.course = course
    }

    func showCourse() {
        print("Course: \(course.name)")
        print("Duration: \(course.duration) months")
    }
}

// Creating a course
var course1 = Course(name: "Swift Programming", duration: 3)
var course2 = course1

// Changing the copied value
course2.name = "iOS Development"

print("Original Course:", course1.name)
print("Copied Course:", course2.name)

// Creating class objects
let manager1 = CourseManager(course: course1)
let manager2 = manager1

manager2.course.name = "Advanced Swift"

print("\nClass Example:")
manager1.showCourse()

//  Value type and reference type
print("\nValue and Reference Types")

var firstCourse = Course(name: "Python", duration: 2)
var secondCourse = firstCourse

secondCourse.name = "Java"

print("First Course:", firstCourse.name)
print("Second Course:", secondCourse.name)

// Class example
let firstManager = CourseManager(
    course: Course(name: "HTML", duration: 1)
)

let secondManager = firstManager
secondManager.course.name = "CSS"

print("First Manager:", firstManager.course.name)
print("Second Manager:", secondManager.course.name)


// Teacher and Classroom classes
class Teacher {
    var name: String
    weak var classroom: Classroom?

    init(name: String) {
        self.name = name
    }

    deinit {
        print("\(name) object removed")
    }
}

class Classroom {
    var roomName: String
    var teacher: Teacher?

    init(roomName: String) {
        self.roomName = roomName
    }

    deinit {
        print("\(roomName) object removed")
    }
}

var teacher: Teacher? = Teacher(name: "Rahul")
var room: Classroom? = Classroom(roomName: "Room 101")

teacher?.classroom = room
room?.teacher = teacher

print("\nTeacher:", teacher?.name ?? "No teacher")
print("Classroom:", room?.roomName ?? "No classroom")

// Removing references
teacher = nil
room = nil


//  Strong reference cycle using closure

class Student {
    var name: String
    var attendance: (() -> Void)?

    init(name: String) {
        self.name = name
    }

    func markAttendance() {
        print("\(name) is present")
    }

    deinit {
        print("\(name) object removed")
    }
}

var student: Student? = Student(name: "Aman")

// Using weak self to avoid retain cycle
student?.attendance = { [weak student] in
    student?.markAttendance()
}

student?.attendance?()

// Removing the student object
student = nil


// Value types, reference types and ARC

print("\nMemory Management Example")

var original = Course(name: "C Programming", duration: 2)
var copied = original

copied.duration = 4

print("Original Duration:", original.duration)
print("Copied Duration:", copied.duration)

class Demo {
    var value = 10

    deinit {
        print("Demo object deallocated")
    }
}

var obj1: Demo? = Demo()
var obj2 = obj1

obj2?.value = 50

print("Object 1 Value:", obj1?.value ?? 0)
print("Object 2 Value:", obj2?.value ?? 0)

// Removing strong references
obj1 = nil
obj2 = nil

print("Program completed")

