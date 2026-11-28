
# Course Planner

## 1. Project Overview

Course Planner is an iOS application developed using
Swift and SwiftUI.

It helps students organize their courses, track
learning progress and manage course deadlines.

The application provides a simple way to maintain
course information and monitor academic progress.

## 2. Problem Statement

Students often manage their courses, deadlines and
learning progress manually.

This application provides a single place where
students can add courses, track completed lessons
and view their upcoming deadlines.

## 3. Target Users

- College students
- University students
- Online learners
- Students managing multiple courses

## 4. Main Features

- Add new courses.
- View all enrolled courses.
- Search courses by name or instructor.
- Track completed lessons.
- Calculate course completion percentage.
- View total credits.
- View upcoming deadlines.
- Delete unwanted courses.
- Save data locally using UserDefaults.
- Validate user inputs.

## 5. Technologies Used

- Swift
- SwiftUI
- MVVM Architecture
- Foundation
- UserDefaults
- Codable
- XCTest

## 6. Project Architecture

The application follows the MVVM architecture.

### Model
Course.swift stores course information.

### ViewModel
CourseViewModel.swift handles application
logic, calculations and state management.

### Views
SwiftUI files display the dashboard,
course form, course list and course details.

### Services
CourseStorageService.swift handles local
data storage.

### Helpers
CourseValidator.swift checks user input.

## 7. Setup Requirements

- macOS
- Xcode
- iOS 17.0 or later deployment target
- Swift

## 8. How to Run

1. Open CoursePlanner.xcodeproj in Xcode.
2. Select an iPhone simulator.
3. Select the CoursePlanner scheme.
4. Press Command + R.
5. The application will launch.

## 9. How to Run Unit Tests

1. Select the CoursePlannerTests scheme or
   run the test target.
2. Press Command + U.
3. Check the test results in Xcode.

The project contains 10 unit test cases.

## 10. Data Storage

Course information is converted into JSON
using JSONEncoder and saved in UserDefaults.

The saved information is loaded when the
application starts again.

## 11. Limitations

- Data is stored locally on the device.
- No cloud synchronization is implemented.
- No user authentication is included.
- Course reminders and notifications are
  not currently implemented.

## 12. Future Improvements

- Add course reminders.
- Add cloud synchronization.
- Add calendar integration.
- Add user authentication.
- Add weekly learning statistics.

## 13. Testing

Unit tests are included for course creation,
deletion, validation, progress calculations,
sorting and empty states.
