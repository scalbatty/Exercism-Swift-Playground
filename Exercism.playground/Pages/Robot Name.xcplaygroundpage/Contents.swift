//: [Previous](@previous)

/*:

# Robot Name

Write a program that manages robot factory settings.

When robots come off the factory floor, they have no name.

The first time you boot them up, a random name is generated, such as
RX837 or BC811.

Every once in a while we need to reset a robot to its factory settings,
which means that their name gets wiped. The next time you ask, it gets a
new name.


## For bonus points

Did you get the tests passing and the code clean? If you want to, these
are some additional things you could try:

- Random names means a risk of collisions. Make sure the same name is
never used twice. Feel free to introduce additional tests.

Then please share your thoughts in a comment on the submission. Did this
experiment make the code better? Worse? Did you learn anything from it?


## Source

A debugging session with Paul Blackwell at gSchool. [view source](http://gschool.it)


*/

//: ## Code

public class Robot {
    
    // Class variable struct workaround
    private struct NamesStruct { static var generatedNames:[String] = [String]() }
    private class var generatedNames:[String]
        {
        get { return NamesStruct.generatedNames }
        set { NamesStruct.generatedNames = newValue }
    }
    
    private var _name:String? = nil
    
    public var name:String {
        get {
            if (_name == nil) {
                let newName = Robot.generateNewName()
                Robot.generatedNames.append(newName)
                _name = newName
            }
            return _name!
        }
    }
    
    public func resetName() {
        if (_name == nil) {
            return
        }
        if let index = Robot.generatedNames.indexOf(_name!) {
            Robot.generatedNames.removeAtIndex(index)
        }
        _name = nil
    }
    
    private class func generateNewName() -> String {
        var newName:String = ""
        repeat {
            newName = generateName()
        } while (generatedNames.indexOf(newName) !=  nil)
        return newName
    }
    
    private class func generateName() -> String {
        return "\(randomAlphabetic)\(randomAlphabetic)\(randomDigit)\(randomDigit)\(randomDigit)"
    }
    
    // Random string generation from John Regner's post at
    // http://blog.johnregner.com/post/93646505478/swift-random-strings
    
    private class var arrayOfAThroughZ:[String] {
        return Array(0x61...0x7A).map {String(UnicodeScalar($0))}
    }
    private class var randomAlphabetic:String {
        return arrayOfAThroughZ.randomItem()
    }
    
    private class var arrayOfZeroThroughNine:[String] {
        return Array(0...9).map{ String($0) }
    }
    private class var randomDigit:String {
        return arrayOfZeroThroughNine.randomItem()
    }
}

extension Array {
    func randomItem() -> Element {
        let randomIndex = random() % self.count
        return self[randomIndex]
    }
}

//: ## Tests

import Foundation
import XCTest

class RobotNameTest: XCTestCase {
    
    func robotNameIsCorrectlyFormatted(name: String) -> Bool
    {
        let robotNameRegex = try? NSRegularExpression(pattern: "\\A\\w{2}\\d{3}\\z", options: NSRegularExpressionOptions.CaseInsensitive)
        let matches = robotNameRegex?.matchesInString(name, options: .WithoutAnchoringBounds, range: NSMakeRange(0, name.characters.count))
        
        return matches!.count > 0
    }
    
    func testHasName() {
        let robot = Robot()
        XCTAssert(robotNameIsCorrectlyFormatted(robot.name))
    }
    
    func testNameSticks() {
        let robot = Robot()
        let name = robot.name
        XCTAssertEqual(name, robot.name)
    }
    
    func testDifferentRobotsHaveDifferentNames() {
        let firstRobot = Robot()
        let secondRobot = Robot()
        XCTAssertNotEqual(firstRobot.name, secondRobot.name)
    }
    
    func testResetName() {
        let robot = Robot()
        let firstName = robot.name
        robot.resetName()
        let secondName = robot.name
        XCTAssertNotEqual(firstName, secondName)
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

TestRunner().runTests(RobotNameTest)
