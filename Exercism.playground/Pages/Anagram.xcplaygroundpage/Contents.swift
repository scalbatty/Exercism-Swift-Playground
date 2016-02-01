//: [Previous](@previous)

/*:
# Anagram

Write a program that, given a word and a list of possible anagrams, selects the correct sublist.

Given `"listen"` and a list of candidates like `"enlists" "google"
"inlets" "banana"` the program should return a list containing
`"inlets"`.


## Source

Inspired by the Extreme Startup game [view source](https://github.com/rchatley/extreme_startup)

*/

//: ## Code

import Foundation

func isAnagramButNotEqual (to reference:String) -> (String) -> Bool {
    return { (candidate) -> Bool in
        reference.lowercaseString != candidate.lowercaseString && reference === candidate
    }
    
};

func === (l:String, r:String) -> Bool {
    return l.lowercaseString.characters.sort() == r.lowercaseString.characters.sort()
}

public struct Anagram {
    
    var word:String;
    
    public func match(words:[String]) -> [String] {
        let anagramButNotEqual = isAnagramButNotEqual(to:word)
        return words.filter(anagramButNotEqual)
    }
}

//: ## Tests

import XCTest

class AnagramTest: XCTestCase {
    
    func testNoMatches() {
        let anagram = Anagram(word: "diaper")
        let results = anagram.match(["hello","world","zombies","pants"])
        let expected = []
        XCTAssertEqual(results, expected)
    }
    
    
    func testDetectSimpleAnagram() {
        let anagram = Anagram(word: "ant")
        let results = anagram.match(["tan","stand","at"])
        let expected = ["tan"]
        XCTAssertEqual(results, expected)
    }
    
    func testDetectMultipleAnagrams() {
        let anagram = Anagram(word: "master")
        let results = anagram.match(["stream","pigeon","maters"])
        let expected = ["stream","maters"]
        XCTAssertEqual(results, expected)
    }
    
    func testDoesNotConfuseDifferentDuplicates() {
        let anagram = Anagram(word: "galea")
        let results = anagram.match(["eagle"])
        let expected = []
        XCTAssertEqual(results, expected)
    }
    
    func testIdenticalWordIsNotAnagram() {
        let anagram = Anagram(word: "corn")
        let results = anagram.match(["corn", "dark", "Corn", "rank", "CORN", "cron", "park"])
        let expected = ["cron"]
        XCTAssertEqual(results, expected)
    }
    
    func testEliminateAnagramsWithSameChecksum() {
        let anagram = Anagram(word: "mass")
        let results = anagram.match(["last"])
        let expected = []
        XCTAssertEqual(results, expected)
    }
    
    func testEliminateAnagramSubsets() {
        let anagram = Anagram(word: "good")
        let results = anagram.match(["dog","goody"])
        let expected = []
        XCTAssertEqual(results, expected)
    }
    
    func testDetectAnagram() {
        let anagram = Anagram(word: "listen")
        let results = anagram.match(["enlists","google","inlets","banana"])
        let expected = ["inlets"]
        XCTAssertEqual(results, expected)
    }
    
    func testMultipleAnagrams() {
        let anagram = Anagram(word: "allergy")
        let results = anagram.match(["gallery","ballerina","regally","clergy","largely","leading"])
        let expected = ["gallery","regally","largely"]
        XCTAssertEqual(results, expected)
    }
    
    func testAnagramsAreCaseInsensitive() {
        let anagram = Anagram(word: "Orchestra")
        let results = anagram.match(["cashregister","Carthorse","radishes"])
        let expected = ["Carthorse"]
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

TestRunner().runTests(AnagramTest)
