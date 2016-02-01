//: [Previous](@previous)

/*:

# Phone Number

Write a program that cleans up user-entered phone numbers so that they can be sent SMS messages.

The rules are as follows:

- If the phone number is less than 10 digits assume that it is bad
number
- If the phone number is 10 digits assume that it is good
- If the phone number is 11 digits and the first number is 1, trim the 1
and use the first 10 digits
- If the phone number is 11 digits and the first number is not 1, then
it is a bad number
- If the phone number is more than 11 digits assume that it is a bad
number

We've provided tests, now make them pass.

Hint: Only make one test pass at a time. Disable the others, then flip
each on in turn after you get the current failing one to pass.


## Source

Event Manager by JumpstartLab [view source](http://tutorials.jumpstartlab.com/projects/eventmanager.html)


*/

//: ## Code

//
//  PhoneNumber.swift
//  PhoneNumber
//
//  Created on 07/11/2014.
//

import Foundation

class PhoneNumber {
    
    private let errorNumber:String = "0000000000"
    private var startingNumber:String
    private var cleansedNumber:String?
    
    init(startingNumber:String) {
        self.startingNumber = startingNumber
    }
    
    func number() -> String {
        if (cleansedNumber == nil) {
            self.processNumber()
        }
        return cleansedNumber!;
    }
    
    func areaCode() -> String {
        let number = self.number()
        return number.substringToIndex(number.startIndex.advancedBy(3))
    }
    
    private var firstPart:String {
        get {
            let number = self.number()
            return number.substringWithRange(Range(start:number.startIndex.advancedBy(3), end:number.startIndex.advancedBy(6)))
        }
    }
    
    private var secondPart:String {
        get {
            let number = self.number()
            return number.substringFromIndex(number.startIndex.advancedBy(6))
        }
    }
    
    
    func description() -> String {
        return "(\(self.areaCode())) \(self.firstPart)-\(self.secondPart)"
        
    }
    
    private func processNumber() {
        var number = String(startingNumber.characters.filter {return ($0 >= "0" && $0 <= "9")})
        let digitCount = number.characters.count
        
        if (digitCount != 10) {
            if (digitCount == 11 && number.hasPrefix("1")) {
                number = number.substringFromIndex(number.startIndex.advancedBy(1))
            }
            else {
                number = errorNumber;
            }
        }
        
        self.cleansedNumber = number
    }
}

//: ## Tests

import Foundation
import XCTest

class PhoneNumberTest : XCTestCase {
    
    func testValidWithTenDigits() {
        let startingNumber = "1234567890"
        let expected = "1234567890"
        let number = PhoneNumber(startingNumber: startingNumber)
        let result = number.number()
        XCTAssertEqual(result, expected)
    }
    
    func testCleansNumber() {
        let startingNumber = "(123) 456-7890"
        let expected = "1234567890"
        let number = PhoneNumber(startingNumber: startingNumber)
        let result = number.number()
        XCTAssertEqual(result, expected)
    }
    
    func testCleansNumberWithDots() {
        let startingNumber = "123.456.7890"
        let expected = "1234567890"
        let number = PhoneNumber(startingNumber: startingNumber)
        let result = number.number()
        XCTAssertEqual(result, expected)
    }
    
    func testValidWithElevenDigitsAndFirstIsOne() {
        let startingNumber = "11234567890"
        let expected = "1234567890"
        let number = PhoneNumber(startingNumber: startingNumber)
        let result = number.number()
        XCTAssertEqual(result, expected)
    }
    
    func testInvalidWhenElevenDigits() {
        let startingNumber = "21234567890"
        let expected = "0000000000"
        let number = PhoneNumber(startingNumber: startingNumber)
        let result = number.number()
        XCTAssertEqual(result, expected)
    }
    
    func testInvalidWhenNineDigits() {
        let startingNumber = "123456789"
        let expected = "0000000000"
        let number = PhoneNumber(startingNumber: startingNumber)
        let result = number.number()
        XCTAssertEqual(result, expected)
    }
    
    func testAreaCode() {
        let startingNumber = "1234567890"
        let expected = "123"
        let number = PhoneNumber(startingNumber: startingNumber)
        let result = number.areaCode()
        XCTAssertEqual(result, expected)
    }
    
    func testPrettyPrint() {
        let startingNumber = "1234567890"
        let expected = "(123) 456-7890"
        let number = PhoneNumber(startingNumber: startingNumber)
        let result = number.description()
        XCTAssertEqual(result, expected)
    }
    
    func testPrettyPrintWithFullUSPhoneNumber() {
        let startingNumber = "11234567890"
        let expected = "(123) 456-7890"
        let number = PhoneNumber(startingNumber: startingNumber)
        let result = number.description()
        XCTAssertEqual(result, expected)
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

TestRunner().runTests(PhoneNumberTest)
