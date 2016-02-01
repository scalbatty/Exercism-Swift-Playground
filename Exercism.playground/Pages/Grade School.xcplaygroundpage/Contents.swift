//: [Previous](@previous)

/*:

# Grade School

Write a small archiving program that stores students' names along with the grade that they are in.

In the end, you should be able to:

- Add a student's name to the roster for a grade
- "Add Jim to grade 2."
- "OK."
- Get a list of all students enrolled in a grade
- "Which students are in grade 2?"
- "We've only got Jim just now."
- Get a sorted list of all students in all grades.  Grades should sort
as 1, 2, 3, etc., and students within a grade should be sorted
alphabetically by name.
- "Who all is enrolled in school right now?"
- "Grade 1: Anna, Barb, and Charlie. Grade 2: Alex, Peter, and Zoe.
Grade 3…"

Note that all our students only have one name.  (It's a small town, what
do you want?)


## For bonus points

Did you get the tests passing and the code clean? If you want to, these
are some additional things you could try:

- If your implementation allows outside code to mutate the school's
internal DB directly, see if you can prevent this. Feel free to
introduce additional tests.

Then please share your thoughts in a comment on the submission. Did this
experiment make the code better? Worse? Did you learn anything from it?


## Source

A pairing session with Phil Battos at gSchool [view source](http://gschool.it)


*/

//: ## Code


public class GradeSchool {
    
    public var db:[Int:[String]] = [:]
    
    public func addStudent(name:String, grade:Int) {
        if (db[grade] == nil) {
            db[grade] = []
        }
        db[grade]?.append(name)
    }
    
    public func studentsInGrade(grade:Int) -> [String] {
        return db[grade] == nil ? [] : db[grade]!
    }
    
    public func sortedRoster() -> [Int:[String]] {
        var sorted:[Int:[String]] = [:]
        for (key, names) in db {
            sorted[key] = names.sort(<)
        }
        return sorted
    }
    
}

//: ## Tests

import XCTest

class GradeSchoolTest: XCTestCase
{
    
    func testAnEmptySchool() {
        let school = GradeSchool()
        let expected = [:]
        let result = school.db
        XCTAssertEqual(result, expected)
    }
    
    func testAddStudent() {
        let school = GradeSchool()
        school.addStudent("Aimee", grade: 2)
        let result = school.db
        let expected: Dictionary = [2: ["Aimee"]]
        XCTAssertEqual(Array(result.keys), Array(expected.keys))
        XCTAssertEqual(result[2]!, expected[2]!)
    }
    
    func testAddMoreStudentsInSameClass() {
        let school = GradeSchool()
        school.addStudent("Fred", grade: 2)
        school.addStudent("James", grade: 2)
        school.addStudent("Paul", grade: 2)
        let result = school.db
        let expected = [2: ["Fred", "James", "Paul"]]
        XCTAssertEqual(Array(result.keys), Array(expected.keys))
        XCTAssertEqual(result[2]!, expected[2]!)
    }
    
    func testAddStudentsToDifferentGrades() {
        let school = GradeSchool()
        school.addStudent("Chelsea", grade: 3)
        school.addStudent("Logan", grade: 7)
        let result = school.db
        let expected = [3: ["Chelsea"], 7: ["Logan"]]
        XCTAssertEqual(Array(result.keys).sort(>), Array(expected.keys).sort(>))
        XCTAssertEqual(result[3]!, expected[3]!)
    }
    
    func testGetStudentsInAGrade() {
        let school = GradeSchool()
        school.addStudent("Franklin", grade: 5)
        school.addStudent("Bradley", grade: 5)
        school.addStudent("Jeff", grade: 1)
        let result = school.studentsInGrade(5)
        let expected = [ "Franklin", "Bradley" ]
        XCTAssertEqual(result, expected)
    }
    
    func testGetStudentsInANonExistantGrade() {
        let school = GradeSchool()
        let result = school.studentsInGrade(1)
        
        let expected: [String] = []
        XCTAssertEqual(result, expected)
    }
    
    func testSortSchool() {
        let school = GradeSchool()
        
        school.addStudent("Jennifer", grade:4)
        school.addStudent("Kareem", grade:6)
        school.addStudent("Christopher", grade:4)
        school.addStudent("Kyle", grade: 3)
        let result = school.sortedRoster()
        
        let expected = [
            3 : ["Kyle"],
            4 : [ "Christopher", "Jennifer" ],
            6 : [ "Kareem"]
        ]
        
        XCTAssertEqual(Array(result.keys).sort(>), Array(expected.keys).sort(>))
        XCTAssertEqual(result[3]!, expected[3]!)
        XCTAssertEqual(result[4]!, expected[4]!)
        XCTAssertEqual(result[6]!, expected[6]!)
    }
}

//: [Next](@next)

//: Testing Boilerplate


class PlaygroundTestObserver : NSObject, XCTestObservation {
    @objc func testCase(testCase: XCTestCase, didFailWithDescription description: String, inFile filePath: String?, atLine lineNumber: UInt) {
        print("Test failed on line \(lineNumber): \(testCase.name), \(description)")
    }
}

let observer = PlaygroundTestObserver()
let center = XCTestObservationCenter.sharedTestObservationCenter()
center.addTestObserver(observer)

struct TestRunner {
    
    func runTests(testClass:AnyClass) {
        print("Running test suite \(testClass)")
        let tests = testClass as! XCTestCase.Type
        let testSuite = tests.defaultTestSuite()
        testSuite.runTest()
        let run = testSuite.testRun as! XCTestSuiteRun
        
        print("Ran \(run.executionCount) tests in \(run.testDuration)s with \(run.totalFailureCount) failures")
    }
    
}

TestRunner().runTests(GradeSchoolTest)
