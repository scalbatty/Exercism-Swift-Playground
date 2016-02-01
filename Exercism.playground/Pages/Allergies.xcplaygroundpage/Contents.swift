//: [Previous](@previous)

/*:

# Allergies

Write a program that, given a person's allergy score, can tell them whether or not they're allergic to a given item, and their full list of allergies.

An allergy test produces a single numeric score which contains the
information about all the allergies the person has (that they were
tested for).

The list of items (and their value) that were tested are:

* eggs (1)
* peanuts (2)
* shellfish (4)
* strawberries (8)
* tomatoes (16)
* chocolate (32)
* pollen (64)
* cats (128)

So if Tom is allergic to peanuts and chocolate, he gets a score of 34.

Now, given just that score of 34, your program should be able to say:

- Whether Tom is allergic to any one of those allergens listed above.
- All the allergens Tom is allergic to.


## Source

Jumpstart Lab Warm-up [view source](http://jumpstartlab.com)


*/

//: ## Code

import Foundation

public struct Allergies:OptionSetType {
    
    static var eggs: Allergies          { return self.init(1 << 0) }
    static var peanuts: Allergies       { return self.init(1 << 1) }
    static var shellfish: Allergies     { return self.init(1 << 2) }
    static var strawberries: Allergies  { return self.init(1 << 3) }
    static var tomatoes: Allergies      { return self.init(1 << 4) }
    static var chocolate: Allergies     { return self.init(1 << 5) }
    static var pollen: Allergies        { return self.init(1 << 6) }
    static var cats: Allergies          { return self.init(1 << 7) }
    
    public func hasAllergy(other:Allergies) -> Bool {
        return self.value & other.value > 0
    }
    
    // Boilerplate code for the enumflag behavior
    
    public typealias RawValue = UInt;
    private var value: UInt = 0
    public init(_ value: UInt) { self.value = value }
    public init(rawValue value: UInt) { self.value = value }
    public init(nilLiteral: ()) { self.value = 0 }
    public static var allZeros: Allergies { return self.init(0) }
    public var rawValue: UInt { return self.value }
}


//: ## Tests

import Foundation
import XCTest

class AllergiesTest: XCTestCase {
    
    func test_bob() {
        
        let allergies = Allergies(34)
        
        XCTAssertTrue(allergies.hasAllergy(Allergies.peanuts), "Bob is allergic to peanuts")
        XCTAssertTrue(allergies.hasAllergy(Allergies.chocolate), "Bob is allergic to chocolate")
        XCTAssertFalse(allergies.hasAllergy(Allergies.cats),  "Bob is not allergic to cats")
    }
    
    func test_eggsNcats () {
        
        let allergies = Allergies(129)
        
        XCTAssertTrue(allergies.hasAllergy(Allergies.eggs))
        XCTAssertTrue(allergies.hasAllergy(Allergies.cats))
        XCTAssertFalse(allergies.hasAllergy(Allergies.chocolate))
        
    }
    
    func test_none() {
        let allergies = Allergies(0)
        
        XCTAssertFalse(allergies.hasAllergy(Allergies.pollen))
    }
    
    func testAll() {
        
        let allInt =  UInt(Array(0...7).reduce(0){ return ($0 | (1 << $1)) })
        let allergies = Allergies(allInt)
        
        XCTAssertTrue(allergies.hasAllergy(Allergies.eggs))
        XCTAssertTrue(allergies.hasAllergy(Allergies.peanuts))
        XCTAssertTrue(allergies.hasAllergy(Allergies.shellfish))
        XCTAssertTrue(allergies.hasAllergy(Allergies.strawberries))
        XCTAssertTrue(allergies.hasAllergy(Allergies.tomatoes))
        XCTAssertTrue(allergies.hasAllergy(Allergies.chocolate))
        XCTAssertTrue(allergies.hasAllergy(Allergies.pollen))
        XCTAssertTrue(allergies.hasAllergy(Allergies.cats))
        
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

TestRunner().runTests(AllergiesTest)
