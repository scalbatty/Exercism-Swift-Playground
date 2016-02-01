//: [Previous](@previous)

/*:

# Gigasecond

Write a program that will calculate the date that someone turned or will celebrate their 1 Gs anniversary.

A gigasecond is one billion (10**9) seconds.


## Source

Chapter 9 in Chris Pine's online Learn to Program tutorial. [view source](http://pine.fm/LearnToProgram/?Chapter=09)


*/

//: ## Code

import Foundation

let EXPECTED_DATE_FORMAT = "yyyy-MM-dd'T'HH:mm:ss"

class Gigasecond {
    static func from(origin:String) -> NSDate {
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        dateFormatter.dateFormat = EXPECTED_DATE_FORMAT
        
        if let originDate = dateFormatter.dateFromString(origin) {
            return originDate.dateByAddingTimeInterval(1_000_000_000);
        }
        return NSDate.distantFuture()
    }
}

//: ## Tests

import XCTest


class GigasecondTest: XCTestCase {
    
    func newDateWithTime(input:String) -> NSDate{
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter.dateFromString(input) ?? NSDate.distantFuture() as NSDate
    }
    
    
    func test_1 (){
        let gs = Gigasecond.from("2011-4-25T00:00:00")
        XCTAssertEqual(newDateWithTime("2043-01-01T01:46:40"), gs)
    }
    
    func test_2 (){
        let gs = Gigasecond.from("1977-6-13T00:00:00")
        XCTAssertEqual(newDateWithTime("2009-02-19T01:46:40"), gs)
    }
    
    func test_3 (){
        let gs = Gigasecond.from("1959-7-19T00:00:00")
        XCTAssertEqual(newDateWithTime("1991-03-27T01:46:40"), gs)
    }
    
    func test_time_with_seconds (){
        let gs = Gigasecond.from("1959-7-20T00:00:00").dateByAddingTimeInterval(-1)
        XCTAssertEqual(newDateWithTime("1991-3-28T01:46:39"), gs)
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

TestRunner().runTests(GigasecondTest)
