//: [Previous](@previous)

/*: 

# Hamming

Write a program that can calculate the Hamming difference between two DNA strands.

A mutation is simply a mistake that occurs during the creation or
copying of a nucleic acid, in particular DNA. Because nucleic acids are
vital to cellular functions, mutations tend to cause a ripple effect
throughout the cell. Although mutations are technically mistakes, a very
rare mutation may equip the cell with a beneficial attribute. In fact,
the macro effects of evolution are attributable by the accumulated
result of beneficial microscopic mutations over many generations.

The simplest and most common type of nucleic acid mutation is a point
mutation, which replaces one base with another at a single nucleotide.

By counting the number of differences between two homologous DNA strands
taken from different genomes with a common ancestor, we get a measure of
the minimum number of point mutations that could have occurred on the
evolutionary path between the two strands.

This is called the 'Hamming distance'

GAGCCTACTAACGGGAT
CATCGTAATGACGGCCT
^ ^ ^  ^ ^    ^^

The Hamming distance between these two DNA strands is 7.


## Source

The Calculating Point Mutations problem at Rosalind [view source](http://rosalind.info/problems/hamm/)

*/

//: ## Code

struct Hamming {
    static func compute(leftStrand:String, against rightStrand:String) -> Int {
        
        return zip(leftStrand.characters, rightStrand.characters).filter({ pair in
            let (leftNuc, rightNuc) = pair
            return leftNuc != rightNuc
            }).count
        
    }
}

//: ## Tests

import XCTest

class HammingTests: XCTestCase {
    func testNoDifferenceBetweenEmptyStrands() {
        let result = Hamming.compute("", against: "")
        let expected = 0
        XCTAssertEqual(expected, result)
    }
    
    func testNoDifferenceBetweenIdenticalStrands() {
        let result = Hamming.compute("GGACTGA", against:"GGACTGA")
        let expected = 0
        XCTAssertEqual(expected,result)
    }
    
    func testCompleteHammingDistanceInSmallStrand() {
        let result = Hamming.compute("ACT", against: "GGA")
        let expected = 3
        XCTAssertEqual(expected,result)
    }
    
    func testSmallHammingDistanceInMiddleSomewhere() {
        let result = Hamming.compute("GGACG", against:"GGTCG")
        let expected = 1
        XCTAssertEqual(expected,result)
    }
    
    func testLargerDistance() {
        let result = Hamming.compute("ACCAGGG", against:"ACTATGG")
        let expected = 2
        XCTAssertEqual(expected,result)
    }
    
    func testIgnoreExtraLengthOnOtherStrandWhenLonger() {
        let result = Hamming.compute("AAACTAGGGG", against:"AGGCTAGCGGTAGGAC")
        let expected = 3
        XCTAssertEqual(expected,result)
    }
    
    func testIgnoresExtraLengthOnOriginalStrandWhenLonger() {
        let result = Hamming.compute("GACTACGGACAGGGTAGGGAAT", against:"GACATCGCACACC")
        let expected = 5
        XCTAssertEqual(expected,result)
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

TestRunner().runTests(HammingTests)
