//: [Previous](@previous)

/*:

# Perfect Numbers

The Greek mathematician Nicomachus devised a classification scheme for natural numbers.

The Greek mathematican Nicomachus devised a classification scheme for
natural numbers, identifying each as belonging uniquely to the
categories of _abundant_, _perfect_, or _deficient_.  A perfect number
equals the sum of its positive divisors — the pairs of numbers whose
product yields the target number, excluding the number itself.

- Perfect: Sum of factors = number
- Abundant: Sum of factors > number
- Deficient: Sum of factors < number

The Aliquot sum is defined as the sum of the factors of a number not
including the number itself.

## Examples

- 6 is a perfect number because its divisors are 1, 2, 3 and 6 = 1 + 2 +
3.
- 28 is perfect number because 28 = 1 + 2 + 4 + 7.
- Prime numbers 7, 13, etc are Deficient by the Nicomachus
classificaton.


## Source

Taken from Chapter 2 of Functional Thinking by Neal Ford. [view source](http://shop.oreilly.com/product/0636920029687.do)

*/

//: ## Code

public enum NumberClassification {
    case Perfect
    case Abundent
    case Deficient
}

public struct NumberClassifier {
    
    public var number:Int = 0
    
    public var classification:NumberClassification {
        let sumOfDivisors = Array(1..<number).filter({self.number%$0 == 0}).reduce(0) { $0 + $1 }
        if (sumOfDivisors == number) {
            return .Perfect
        }
        else if (sumOfDivisors > number) {
            return .Abundent
        }
        else {
            return .Deficient
        }
    }
    
}

//: ## Tests

import Foundation
import XCTest

class PerfectNumbersTest: XCTestCase {
    
    
    func testPerfect() {
        let numberClassifier = NumberClassifier(number: 6)
        let expectedValue = NumberClassification.Perfect
        let result = numberClassifier.classification
        XCTAssertEqual(result,expectedValue)
        
    }
    
    func testPerfectAgain() {
        let numberClassifier = NumberClassifier(number: 28)
        let expectedValue = NumberClassification.Perfect
        let result = numberClassifier.classification
        XCTAssertEqual(result,expectedValue)
        
    }
    
    func testDeficient() {
        let numberClassifier = NumberClassifier(number: 13)
        let expectedValue = NumberClassification.Deficient
        let result = numberClassifier.classification
        XCTAssertEqual(result,expectedValue)
        
    }
    
    func testAbundent() {
        let numberClassifier = NumberClassifier(number: 12)
        let expectedValue = NumberClassification.Abundent
        let result = numberClassifier.classification
        XCTAssertEqual(result,expectedValue)
        
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

TestRunner().runTests(PerfectNumbersTest)
