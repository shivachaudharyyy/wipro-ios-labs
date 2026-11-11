let name = "Shiva"
let rollNo = 101
let marks = [80, 75, 85, 90, 80]
let attendance = 85
let total = marks.reduce(0, +)
let avg = total / 5

let result = marks.allSatisfy { $0 >= 35 } && attendance >= 75 ? "PASS" : "FAIL"
let grade = avg >= 90 ? "A+" : avg >= 80 ? "A" : avg >= 70 ? "B" : avg >= 60 ? "C" : avg >= 50 ? "D" : "F"

print("Name:", name)
print("Roll No:", rollNo)
print("Marks:", marks)
print("Total:", total)
print("Average:", avg)
print("Percentage:", total / 5, "%")
print("Attendance:", attendance)
print("Result:", result)
print("Grade:", result == "PASS" ? grade : "F")

print(10+5)
print(10>5)
print(true&&false)
