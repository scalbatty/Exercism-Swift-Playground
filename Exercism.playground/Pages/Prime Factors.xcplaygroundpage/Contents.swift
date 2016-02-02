//: [Previous](@previous)

/*:

# Prime Factors

Compute the prime factors of a given natural number.

A prime number is only evenly divisible by itself and 1.

Note that 1 is not a prime number.

## Example

What are the prime factors of 60?

- Our first divisor is 2. 2 goes into 60, leaving 30.
- 2 goes into 30, leaving 15.
- 2 doesn't go cleanly into 15. So let's move on to our next divisor, 3.
- 3 goes cleanly into 15, leaving 5.
- 3 does not go cleanly into 5. The next possible factor is 4.
- 4 does not go cleanly into 5. The next possible factor is 5.
- 5 does go cleanly into 5.
- We're left only with 1, so now, we're done.

Our successful divisors in that computation represent the list of prime
factors of 60: 2, 2, 3, and 5.

You can check this yourself:

- 2 * 2 * 3 * 5
- = 4 * 15
- = 60
- Success!

## Setup

Go through the project setup instructions for Xcode using Swift:

http://exercism.io/languages/swift


## Source

The Prime Factors Kata by Uncle Bob [view source](http://butunclebob.com/ArticleS.UncleBob.ThePrimeFactorsKata)


*/

//: ## Code

struct PrimeFactors {
    
    let value:Int
    
    var toArray:[Int] {
        get {
            
            let factor = self.value.firstPrimeFactor
            guard let realFactor = factor else { return [] }
            return [realFactor] + PrimeFactors(self.value / realFactor).toArray
        }
    }
    
    init(_ value:Int) {
        self.value = value
    }
}

extension Int {
    
    var isPrime:Bool {
        guard self > 1 else { return false }
        guard self > 2 else { return true }
        
        return !Array(2..<(self-1)).reduce(false, combine: { acc, value in
            return acc || value.isFactor(of: self)
        })
    }
    
    var firstPrimeFactor:Int? {
        guard self > 1 else { return nil }
        
        var factor:Int? = nil
        for value in 2...self where value.isPrime {
            guard !value.isFactor(of: self) else {
                factor = value
                break
            }
        }
        return factor
    }
    
    func isFactor(of value:Int) -> Bool {
        
        return value%self == 0
    }
}

extension SequenceType {
    func first(predicate:(Self.Generator.Element) -> Bool) -> Self.Generator.Element? {
        
        for element in self {
            guard !predicate(element) else { return element }
        }
        return nil
    }
}

//: ## Tests

import XCTest

class PrimeFactorsTest: XCTestCase {
    
    func test1() {
        XCTAssertEqual([], PrimeFactors(1).toArray)
    }
    
    func test2() {
        XCTAssertEqual([2] , PrimeFactors(2).toArray)
    }
    
    func test3() {
        XCTAssertEqual([3], PrimeFactors(3).toArray)
    }
    
    func test4() {
        XCTAssertEqual([2, 2], PrimeFactors(4).toArray)
    }
    
    func test6() {
        XCTAssertEqual([2, 3], PrimeFactors(6).toArray)
    }
    
    func test8() {
        XCTAssertEqual([2, 2, 2], PrimeFactors(8).toArray)
    }
    
    func test9() {
        XCTAssertEqual([3, 3], PrimeFactors(9).toArray)
    }
    
    func test27() {
        XCTAssertEqual([3, 3, 3], PrimeFactors(27).toArray)
    }
    
    func test625() {
        XCTAssertEqual([5, 5, 5, 5], PrimeFactors(625).toArray)
    }
    
//    func test901255() {
//        XCTAssertEqual([5, 17, 23, 461], PrimeFactors(901_255).toArray)
//    }
    
//    func test93819012551() {
//        XCTAssertEqual([11, 9539, 894_119], PrimeFactors(93_819_012_551).toArray)
//    }

}


//: # XCTest Boilerplate


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

TestRunner().runTests(PrimeFactorsTest)

