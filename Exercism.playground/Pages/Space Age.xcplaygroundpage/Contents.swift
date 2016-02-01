//: [Previous](@previous)

/*:

# Space Age

Write a program that, given an age in seconds, calculates how old someone is in terms of a given planet's solar years.

Given an age in seconds, calculate how old someone would be on:

- Earth: orbital period 365.25 Earth days, or 31557600 seconds
- Mercury: orbital period 0.2408467 Earth years
- Venus: orbital period 0.61519726 Earth years
- Mars: orbital period 1.8808158 Earth years
- Jupiter: orbital period 11.862615 Earth years
- Saturn: orbital period 29.447498 Earth years
- Uranus: orbital period 84.016846 Earth years
- Neptune: orbital period 164.79132 Earth years

So if you were told someone were 1,000,000,000 seconds old, you should
be able to say that they're 31 Earth-years old.

If you're wondering why Pluto didn't make the cut, go watch [this
youtube video](http://www.youtube.com/watch?v=Z_2gbGXzFbs).


## Source

Partially inspired by Chapter 1 in Chris Pine's online Learn to Program tutorial. [view source](http://pine.fm/LearnToProgram/?Chapter=01)


*/

//: ## Code

import Foundation

func roundToSecondDecimal(number:Double) -> Double {
    return round(number * 100)/100
}

public class SpaceAge {
    
    let SECONDS_IN_A_YEAR_ON_EARTH:Double = 31557600
    
    init (_ ageInSeconds:Int) {
        self.seconds = Double(ageInSeconds)
    }
    
    let seconds:Double
    private var earth:Double {
        get { return seconds/SECONDS_IN_A_YEAR_ON_EARTH }
    }
    var on_earth:Double {
        get { return roundToSecondDecimal(earth) }
    }
    var on_mercury:Double {
        get { return roundToSecondDecimal(earth/0.2408467)}
    }
    var on_venus:Double {
        get { return roundToSecondDecimal(earth/0.61519726) }
    }
    var on_mars:Double {
        get { return roundToSecondDecimal(earth/1.8808158) }
    }
    var on_jupiter:Double {
        get { return roundToSecondDecimal(earth/11.862615) }
    }
    var on_saturn:Double {
        get { return roundToSecondDecimal(earth/29.447498) }
    }
    var on_uranus:Double {
        get { return roundToSecondDecimal(earth/84.016846) }
    }
    var on_neptune:Double {
        get { return roundToSecondDecimal(earth/164.79132) }
    }
}

//: ## Tests

import XCTest


class SpaceAgeTest: XCTestCase {
    
    func test_age_in_seconds(){
        let age = SpaceAge(1_000_000)
        XCTAssertTrue(1_000_000 == age.seconds)
    }
    
    func test_age_in_earth_years(){
        let age = SpaceAge(1_000_000_000)
        XCTAssertTrue(31.69 == age.on_earth)
    }
    
    func test_age_in_mercury_years(){
        let age = SpaceAge(2_134_835_688)
        XCTAssertTrue(67.65 == age.on_earth)
        XCTAssertTrue(280.88 == age.on_mercury)
    }
    
    func test_age_in_venus_years(){
        let age = SpaceAge(189_839_836)
        XCTAssertTrue(6.02 == age.on_earth)
        XCTAssertTrue(9.78 == age.on_venus)
    }
    
    func test_age_on_mars(){
        let age = SpaceAge(2_329_871_239)
        XCTAssertTrue(73.83 == age.on_earth)
        XCTAssertTrue(39.25 == age.on_mars)
    }
    
    func test_age_on_jupiter(){
        let age = SpaceAge(901_876_382)
        XCTAssertTrue(28.58 == age.on_earth)
        XCTAssertTrue(2.41 == age.on_jupiter)
    }
    
    func test_age_on_saturn(){
        let age = SpaceAge(3_000_000_000)
        XCTAssertTrue(95.06 == age.on_earth)
        XCTAssertTrue(3.23 == age.on_saturn)
    }
    
    func test_age_on_uranus(){
        let age = SpaceAge(3_210_123_456)
        XCTAssertTrue(101.72 == age.on_earth)
        XCTAssertTrue(1.21 == age.on_uranus)
    }
    
    func test_age_on_neptune(){
        let age = SpaceAge(8_210_123_456)
        XCTAssertTrue(260.16 == age.on_earth)
        XCTAssertTrue(1.58 == age.on_neptune)
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

TestRunner().runTests(SpaceAgeTest)
