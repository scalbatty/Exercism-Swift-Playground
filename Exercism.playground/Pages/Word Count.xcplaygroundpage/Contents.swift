//: [Previous](@previous)
/*:
# Word Count

Write a program that given a phrase can count the occurrences of each word in that phrase.

For example for the input `"olly olly in come free"`

olly: 2
in: 1
come: 1
free: 1

## Source

The golang tour [view source](http://tour.golang.org)

*/

//: ## Code

import Foundation

let splitCharSet = NSCharacterSet.alphanumericCharacterSet().invertedSet

struct WordCount {
    var words:String
    
    func count() -> [String:Int] {
        
        let wordsArray = words.lowercaseString.componentsSeparatedByCharactersInSet(splitCharSet);
        
        return wordsArray.filter() {word in
            return !word.isEmpty
            }
            .reduce([:]) { (var dict, word) in
                let currentCount = dict[word]
                dict[word] = currentCount != nil ? currentCount! + 1 : 1
                return dict
        }
    }
}

//: ## Tests

import XCTest

class WordCountTest: XCTestCase {
    
    func testCountOneWord() {
        let words = WordCount(words: "word")
        let expected = ["word": 1]
        let result = words.count()
        
        XCTAssertEqual(expected, result)
    }
    
    func testCountOneOfEeach() {
        let words = WordCount(words: "one of each")
        let expected = ["one" : 1, "of" : 1, "each" : 1 ]
        let result = words.count();
        
        XCTAssertEqual(expected, result)
    }
    
    func testCountMultipleOccurrences() {
        let words = WordCount(words: "one fish two fish red fish blue fish")
        let expected = ["one" : 1, "fish" : 4, "two" : 1, "red" : 1, "blue" : 1 ]
        let result = words.count()
        
        XCTAssertEqual(expected, result)
    }
    
    func testIgnorePunctation() {
        let words = WordCount(words: "car : carpet as java : javascript!!&$%^&")
        let expected = ["car" : 1, "carpet" : 1, "as" : 1, "java" : 1, "javascript" : 1 ]
        let result = words.count()
        
        XCTAssertEqual(expected, result)
    }
    
    func testIncludeNumbers() {
        let words = WordCount(words: "testing, 1, 2 testing")
        let expected = [ "testing" : 2, "1" : 1, "2" : 1 ]
        let result = words.count()
        
        XCTAssertEqual(expected, result)
    }
    
    func testNormalizeCase() {
        let words = WordCount(words:"go Go GO")
        let expected = [ "go" : 3]
        let result = words.count()
        
        XCTAssertEqual(expected, result)
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

TestRunner().runTests(WordCountTest)
