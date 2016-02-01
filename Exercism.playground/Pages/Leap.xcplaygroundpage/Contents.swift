//: [Previous](@previous)
/*:
# Leap

Write a program that will take a year and report if it is a leap year.

The tricky thing here is that a leap year occurs:

```plain
on every year that is evenly divisible by 4
except every year that is evenly divisible by 100
unless the year is also evenly divisible by 400
```

For example, 1997 is not a leap year, but 1996 is.  1900 is not a leap
year, but 2000 is.

If your language provides a method in the standard library that does
this look-up, pretend it doesn't exist and implement it yourself.

## Notes

For a delightful, four minute explanation of the whole leap year
phenomenon, go watch [this youtube video][video].

[video]: http://www.youtube.com/watch?v=xX96xng7sAE

## Source

JavaRanch Cattle Drive, exercise 3 [view source](http://www.javaranch.com/leap.jsp)
*/

//: ## Code

public struct Year {
    
    let calendarYear:Int
    
    var isLeapYear:Bool {
        return calendarYear % 400 == 0 ||
            (calendarYear % 4 == 0 && calendarYear % 100 != 0)
    }
}


//: ## Tests

import XCTest

class LeapTest : XCTestCase {
    
    func testVanillaLeapYear() {
        let year = Year(calendarYear: 1996)
        XCTAssertTrue(year.isLeapYear);
    }
    
    func testAnyOldYear() {
        let year = Year(calendarYear: 1997)
        XCTAssertTrue(!year.isLeapYear);
    }
    
    func testCentury() {
        let year = Year(calendarYear: 1900)
        XCTAssertTrue(!year.isLeapYear);
    }
    
    func testExceptionalCentury() {
        let year = Year(calendarYear: 2400)
        XCTAssertTrue(year.isLeapYear);
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

TestRunner().runTests(LeapTest)
