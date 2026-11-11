import Foundation 
var course=["Swift","Java","Python","React"]
course.append("iOS")
course.removeAll{ $0 == "Java" }
course.sort()

print("Courses:" , course)
print("Filtered:" ,course.filter{ $0.contains("i")})
print("Search Swift:".course.contains("Swift"))

let id: Set<Int> =[101,102,103,101,104,102]
print("Student ids:" id)
print("Unique Students:" id.count)

let marks=[101:85,102:90,103:70,104:60]
var topId=0;
var highMark=0;

for(ids,mark)in marks{
  if mark>highMark{
    highMark=mark
    topId=ids

  }
}

print("Topper ID:",topId)
print("Topper Marks:"highMark)

let below40=mark.filter{ $0.value<40 }
print("Students Below 40:" ,below40)


enum Priorty{
  case high,medium ,low
}
let task=Priority.high

switch task{
  case .high:
    print("High Priority")
  case .medium:
    print("Medium Priority")
  case .low:
    print("Low Priority")
}

enum Result{
  case success(String)
  case error(String)
}
let res=Result.success("Data Loaded")

switch response{
  case .success(let message):
    print(message)
  case .error(let message):
    print(message)
}
