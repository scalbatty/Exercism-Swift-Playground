//: [Previous](@previous)

/*:

# Triangle

Write a program that can tell you if a triangle is equilateral, isosceles, or scalene.

The program should raise an error if the triangle cannot exist.

Tests are provided, delete one `skip` at a time.

## Hint

The sum of the lengths of any two sides of a triangle always exceeds the
length of the third side, a principle known as the _triangle
inequality_.

## Setup

Go through the project setup instructions for Xcode using Swift:

http://help.exercism.io/getting-started-with-swift.html


## Source

The Ruby Koans triangle project, parts 1 & 2 [view source](http://rubykoans.com)


*/

//: ## Code

let triangleKind = (Equilateral:"Equilateral",Isosceles:"Isosceles",Scalene:"Scalene",ErrorKind:"ErrorKind")

func equalTo(reference:Double?) -> (Double) -> Bool {
    return { $0 == reference; }
}

public class Triangle {
    private var sides: [Double]
    public var kind:String {
        get {
            assert({ self.sides.count == 3 }(), "Triangle must have 3 sides")
            
            let kind:String;
            if (!self.isLegal()) {
                kind = triangleKind.ErrorKind
            }
            else if (sides.filter(equalTo(sides.first)).count == 3) {
                kind = triangleKind.Equilateral
            }
            else if (sides.filter(equalTo(sides.first)).count == 2
                || sides.filter(equalTo(sides.last)).count == 2) {
                    kind = triangleKind.Isosceles
            }
            else {
                kind = triangleKind.Scalene
            }
            return kind;
        }
    }
    
    public init(_ lengthA:Double,_ lengthB:Double,_ lengthC:Double) {
        sides = [lengthA, lengthB, lengthC]
    }
    
    private func isLegal() -> Bool {
        return sides.filter({$0 <= 0}).count == 0 && (0..<3).reduce(true) { (legal, sideIndex) -> Bool in
            if legal {
                var sidesCopy = sides
                let side = sidesCopy.removeAtIndex(sideIndex)
                return side < sidesCopy.reduce(0, combine: +)
            }
            else {
                return false
            }
        }
    }
}

//: ## Tests

import XCTest


class TriangleTest: XCTestCase {
    
    let triangleKind = (Equilateral:"Equilateral",Isosceles:"Isosceles",Scalene:"Scalene",ErrorKind:"ErrorKind")
    
    
    func testEquilateralTrianglesHaveEqualSides() {
        XCTAssertEqual(triangleKind.Equilateral,  Triangle(2, 2, 2).kind)
    }
    
    func testLargerEquilateralTrianglesAlsoHaveEqualSides() {
        XCTAssertEqual(triangleKind.Equilateral,  Triangle(10, 10, 10).kind)
    }
    
    func testIsoscelesTrianglesHaveLastTwoSidesEqual() {
        XCTAssertEqual(triangleKind.Isosceles,  Triangle(3, 4, 4).kind)
    }
    
    func testIsoscelesTrianglesHaveFirstAndLastSidesEqual() {
        XCTAssertEqual(triangleKind.Isosceles,  Triangle(4, 3, 4).kind)
    }
    
    func testIsoscelesTrianglesHaveTwoFirstSidesEqual() {
        XCTAssertEqual(triangleKind.Isosceles,  Triangle(4, 4, 3).kind)
    }
    
    func testIsoscelesTrianglesHaveInFactExactlyTwoSidesEqual() {
        XCTAssertEqual(triangleKind.Isosceles,  Triangle(10, 10, 2).kind)
    }
    
    func testScaleneTrianglesHaveNoEqualSides() {
        XCTAssertEqual(triangleKind.Scalene,  Triangle(3, 4, 5).kind)
    }
    
    func testScaleneTrianglesHaveNoEqualSidesAtALargerScaleToo() {
        XCTAssertEqual(triangleKind.Scalene,  Triangle(10, 11, 12).kind)
    }
    
    func testScaleneTrianglesHaveNoEqualSidesInDescendingOrderEither() {
        XCTAssertEqual(triangleKind.Scalene,  Triangle(5, 4, 2).kind)
    }
    
    func testVerySmallTrianglesAreLegal() {
        XCTAssertEqual(triangleKind.Scalene,  Triangle(0.4, 0.6, 0.3).kind)
    }
    
    func testTrianglesWithNoSizeAreIllegal() {
        XCTAssertEqual(triangleKind.ErrorKind,  Triangle(0, 0, 0).kind)
    }
    
    func testTrianglesWithNegativeSidesAreIllegal() {
        XCTAssertEqual(triangleKind.ErrorKind,  Triangle(3, 4, -5).kind)
    }
    
    func testTrianglesViolatingTriangleInequalityAreIllegal() {
        XCTAssertEqual(triangleKind.ErrorKind,  Triangle(1, 1, 3).kind)
    }
    
    func testTrianglesViolatingTriangleInequalityAreIllegal2() {
        XCTAssertEqual(triangleKind.ErrorKind,  Triangle(2, 4, 2).kind)
    }
    
    func testTrianglesViolatingTriangleInequalityAreIllegal3() {
        XCTAssertEqual(triangleKind.ErrorKind,  Triangle(7, 3, 2).kind)
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

TestRunner().runTests(TriangleTest)
