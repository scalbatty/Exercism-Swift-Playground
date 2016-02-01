//: [Previous](@previous)

/*: 

# Etl

We are going to do the `Transform` step of an Extract-Transform-Load.

This is a fancy way of saying, "We have some crufty, legacy data over in
this system, and now we need it in this shiny new system over here, so
we're going to migrate this."

(Typically, this is followed by, "We're only going to need to run this
once." That's then typically followed by much forehead slapping and
moaning about how stupid we could possibly be.)

We're going to extract some scrabble scores from a legacy system.

The old system stored a list of letters per score:

- 1 point: "A", "E", "I", "O", "U", "L", "N", "R", "S", "T",
- 2 points: "D", "G",
- 3 points: "B", "C", "M", "P",
- 4 points: "F", "H", "V", "W", "Y",
- 5 points: "K",
- 8 points: "J", "X",
- 10 points: "Q", "Z",

The shiny new scrabble system instead stores the score per letter, which
makes it much faster and easier to calculate the score for a word. It
also stores the letters in lower-case regardless of the case of the
input letters:

- "a" is worth 1 point.
- "b" is worth 3 points.
- "c" is worth 3 points.
- "d" is worth 2 points.
- Etc.

A final note about scoring, Scrabble is played around the world in a
variety of languages, each with its own unique scoring table. For
example, an "A" is scored at 14 in the Basque-language version of the
game while being scored at 9 in the Latin-language version.

Your mission, should you choose to accept it, is to write a program that
transforms the legacy data format to the shiny new format.

Note that both the old and the new system use strings to represent
letters, even in languages that have a separate data type for
characters.


## Source

The Jumpstart Lab team [view source](http://jumpstartlab.com)

*/

//: ## Code

import Foundation

func | <K,V>(left: Dictionary<K,V>, right: Dictionary<K,V>)
    -> Dictionary<K,V>
{
    var union = Dictionary<K,V>()
    for (k, v) in left {
        union[k] = v
    }
    for (k, v) in right {
        union[k] = v
    }
    return union
}

struct ETL {
    static func transform(legacy:[Int:[String]]) -> [String:Int] {
        return legacy.reduce([String:Int]()) { dict, pair in
            return dict | pair.1.reduce([String:Int]()) { dict, letter in
                return dict | [letter.lowercaseString:pair.0]
            }
        }
    }
}

//: ## Tests

import XCTest

class EtlTest: XCTestCase {
    

    func testTransformOneValue() {
        let old = [ 1 : [ "A" ] ]
        let expected =  ["a" : 1 ]
        let results = ETL.transform(old)
        
        XCTAssertEqual(results, expected)
    }
    
    func testTransformMoreValues() {
        let old = [ 1 : [ "A", "E", "I", "O", "U" ] ]
        let expected =  ["a" : 1, "e": 1, "i": 1, "o": 1, "u": 1 ]
        let results = ETL.transform(old)
        
        XCTAssertEqual(results, expected)
    }
    
    func testMoreKeys() {
        let old = [ 1 : [ "A", "E" ], 2: ["D", "G"] ]
        let expected =  ["a" : 1, "e": 1, "d": 2, "g": 2 ]
        let results = ETL.transform(old)
        
        XCTAssertEqual(results, expected)
    }
    
    func testFullDataSet() {
        let old = [ 1 : [ "A", "E", "I", "O", "U", "L", "N", "R", "S", "T" ],
            2 : [ "D", "G" ],
            3 : [ "B", "C", "M", "P" ],
            4 : [ "F", "H", "V", "W", "Y" ],
            5 : [ "K"],
            8 : [ "J", "X" ],
            10 : [ "Q", "Z" ]
        ]
        let expected = [  "a" : 1, "b" : 3, "c" : 3, "d" : 2, "e" : 1,
            "f" : 4, "g" : 2, "h" : 4, "i" : 1, "j" : 8,
            "k" : 5, "l" : 1, "m" : 3, "n" : 1, "o" : 1,
            "p" : 3, "q" : 10, "r" : 1, "s" : 1, "t" : 1,
            "u" : 1, "v" : 4, "w" : 4, "x" : 8, "y" : 4,
            "z" : 10 ]
        
        let results = ETL.transform(old)
        
        XCTAssertEqual(results, expected)
        
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

TestRunner().runTests(EtlTest)
