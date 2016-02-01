//: [Previous](@previous)

/*:

# Sum Of Multiples

Write a program that, given a number, can find the sum of all the multiples of 3 or 5 up to but not including that number.

If we list all the natural numbers below 10 that are multiples of 3 or
5, we get 3, 5, 6 and 9. The sum of these multiples is 23.

Allow the program to be configured to find the sum of multiples of
numbers other than 3 and 5.


## Source

A variation on Problem 1 at Project Euler [view source](http://projecteuler.net/problem=1)


*/

//: ## Code

func isMultipleOf(multiples:[Int])(_ candidate:Int) -> Bool {
    return multiples
        .map{candidate%$0 == 0}
        .reduce(false) {acc, x in acc || x};
}

struct SumOfMultiples {
    static func toLimit(limit:Int, inMultiples multiples:[Int] = [3, 5]) -> Int {
        let multiplesExcluding0 = multiples.filter() {$0 != 0}
        let multiplePredicate = isMultipleOf(multiplesExcluding0)
        return (0..<limit).filter(multiplePredicate).reduce(0, combine: +);
    }
}

//: ## Tests

import XCTest


class SumOfMultiplesTest:XCTestCase {
    
    
    func testSumTo1(){
        let result = SumOfMultiples.toLimit(1)
        
        XCTAssertEqual(0, result)
    }
    
    func testSumTo3(){
        XCTAssertEqual(3,  SumOfMultiples.toLimit(4))
    }
    
    func testSumTo10(){
        XCTAssertEqual(23,  SumOfMultiples.toLimit(10))
    }
    
    func testSumTo1000(){
        XCTAssertEqual(233168,  SumOfMultiples.toLimit(1000))
    }
    
    func testConfigurable_7_13_17_to_20(){
        XCTAssertEqual(51,  SumOfMultiples.toLimit(20, inMultiples: [7, 13, 17]))
        
    }
    
    func testConfigurable_43_47_to_10000(){
        XCTAssertEqual(2203160,  SumOfMultiples.toLimit(10000, inMultiples: [43, 47]))
        
    }
    
    
    func testConfigurable_0_to_10(){
        XCTAssertEqual(0,  SumOfMultiples.toLimit(10, inMultiples: [0]))
        
    }
    
    
    func testConfigurable_0_1_to_10(){
        XCTAssertEqual(45,  SumOfMultiples.toLimit(10, inMultiples: [0, 1]))
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

TestRunner().runTests(SumOfMultiplesTest)
