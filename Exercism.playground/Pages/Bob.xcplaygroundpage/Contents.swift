//: [Previous](@previous)

/*: 

# Bob

Bob is a lackadaisical teenager. In conversation, his responses are very limited.

Bob answers 'Sure.' if you ask him a question.

He answers 'Whoa, chill out!' if you yell at him.

He says 'Fine. Be that way!' if you address him without actually saying
anything.

He answers 'Whatever.' to anything else.

## Instructions

Run the test file, and fix each of the errors in turn. When you get the
first test to pass, go to the first pending or skipped test, and make
that pass as well. When all of the tests are passing, feel free to
submit.

Remember that passing code is just the first step. The goal is to work
towards a solution that is as readable and expressive as you can make
it.

Please make your solution as general as possible. Good code doesn't just
pass the test suite, it works with any input that fits the
specification.

Have fun!



## Source

Inspired by the 'Deaf Grandma' exercise in Chris Pine's Learn to Program tutorial. [view source](http://pine.fm/LearnToProgram/?Chapter=06)

*/

//: ## Source

import Foundation

public class Bob {
    public class func hey(input:String) -> String {
        let trimmedInput = input.trim()
        var response:BobResponse = .AnythingElse
        
        if (trimmedInput.isSilence) {
            response = .Silence
        }
        else if (trimmedInput.isShout) {
            response = .Shout
        }
        else if (trimmedInput.isQuestion) {
            response = .Question
        }
        return response.rawValue
    }
}

enum BobResponse: String {
    case Silence = "Fine, be that way."
    case Shout = "Woah, chill out!"
    case Question = "Sure."
    case AnythingElse = "Whatever."
}

extension String {
    func trim() -> String {
        return stringByTrimmingCharactersInSet(.whitespaceCharacterSet())
    }
    
    var isIntelligible:Bool {
        return self.rangeOfCharacterFromSet(.letterCharacterSet()) != nil
    }
    
    var isShout:Bool {
        return self.isIntelligible && self == self.uppercaseString
    }
    
    var isQuestion:Bool {
        return self.hasSuffix("?")
    }
    
    var isSilence:Bool {
        return self == ""
    }
}

//: ## Tests

import XCTest

class BobTests: XCTestCase {
    
    func testStatingSomething() {
        let input = "Tom-ay-to, tom-aaaah-to."
        let expected = "Whatever."
        let result = Bob.hey(input)
        XCTAssertEqual(expected, result)
    }
    
    func testShouting() {
        let input = "WATCH OUT!"
        let expected = "Woah, chill out!"
        let result = Bob.hey(input)
        XCTAssertEqual(expected, result)
    }
    
    func testAskingAQustion() {
        let input = "Does this cryogenic chamber make me look fat?"
        let expected = "Sure."
        let result = Bob.hey(input)
        XCTAssertEqual(expected, result)
    }
    
    func testTalkingForcefully() {
        let input = "Let's go make out behind the gym!"
        let expected = "Whatever."
        let result = Bob.hey(input)
        XCTAssertEqual(expected, result)
    }
    
    func testUsingAcronyms() {
        let input = "It's OK if you don't want to go to the DMV."
        let expected = "Whatever."
        let result = Bob.hey(input)
        XCTAssertEqual(expected, result)
    }
    
    func testForcefulQuestions() {
        let input = "WHAT THE HELL WERE YOU THINKING?"
        let expected = "Woah, chill out!"
        let result = Bob.hey(input)
        XCTAssertEqual(expected, result)
    }
    
    func testShoutingNumbers() {
        let input = "1, 2, 3 GO!"
        let expected = "Woah, chill out!"
        let result = Bob.hey(input)
        XCTAssertEqual(expected, result)
    }
    
    func testOnlyNumbers() {
        let input = "1, 2, 3."
        let expected = "Whatever."
        let result = Bob.hey(input)
        XCTAssertEqual(expected, result)
    }
    
    func testQuestionWithOnlyNumbers() {
        let input = "4?"
        let expected = "Sure."
        let result = Bob.hey(input)
        XCTAssertEqual(expected, result)
    }
    
    func testShoutingWithSpecialCharacters() {
        let input = "ZOMG THE %^*@#$(*^ ZOMBIES ARE COMING!!11!!1!"
        let expected = "Woah, chill out!"
        let result = Bob.hey(input)
        XCTAssertEqual(expected, result)
    }
    
    func testShoutingWithUmlautsCharacters() {
        let input = "ÄMLÄTS!"
        let expected = "Woah, chill out!"
        let result = Bob.hey(input)
        XCTAssertEqual(expected, result)
    }
    
    func testCalmlySpeakingAboutUmlauts() {
        let input = "ÄMLäTS!"
        let expected = "Whatever."
        let result = Bob.hey(input)
        XCTAssertEqual(expected, result)
    }
    
    func testShoutingWithNoExclamationmark() {
        let input = "I HATE YOU"
        let expected = "Woah, chill out!"
        let result = Bob.hey(input)
        XCTAssertEqual(expected, result)
    }
    
    func testStatementContainingQuestionsMark() {
        let input = "Ending with a ? means a question."
        let expected = "Whatever."
        let result = Bob.hey(input)
        XCTAssertEqual(expected, result)
    }
    
    func testPrattlingOn() {
        let input = "Wait! Hang on.  Are you going to be OK?"
        let expected = "Sure."
        let result = Bob.hey(input)
        XCTAssertEqual(expected, result)
    }
    
    func testSilence() {
        let input = ""
        let expected = "Fine, be that way."
        let result = Bob.hey(input)
        XCTAssertEqual(expected, result)
    }
    
    func testProlongedSilence() {
        let input = "     "
        let expected = "Fine, be that way."
        let result = Bob.hey(input)
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

TestRunner().runTests(BobTests)
