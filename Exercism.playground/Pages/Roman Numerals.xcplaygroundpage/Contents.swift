//: [Previous](@previous)

/*:

# Roman Numerals

Write a function to convert from normal numbers to Roman Numerals: e.g.

The Romans were a clever bunch. They conquered most of Europe and ruled
it for hundreds of years. They invented concrete and straight roads and
even bikinis. One thing they never discovered though was the number
zero. This made writing and dating extensive histories of their exploits
slightly more challenging, but the system of numbers they came up with
is still in use today. For example the BBC uses Roman numerals to date
their programmes.

The Romans wrote numbers using letters - I, V, X, L, C, D, M. (notice
these letters have lots of straight lines and are hence easy to hack
into stone tablets).

```
1  => I
10  => X
7  => VII
```

There is no need to be able to convert numbers larger than about 3000.
(The Romans themselves didn't tend to go any higher)

Wikipedia says: Modern Roman numerals ... are written by expressing each
digit separately starting with the left most digit and skipping any
digit with a value of zero.

To see this in practice, consider the example of 1990.

In Roman numerals 1990 is MCMXC:

1000=M
900=CM
90=XC

2008 is written as MMVIII:

2000=MM
8=VIII

See also: http://www.novaroma.org/via_romana/numbers.html

## Setup

Go through the project setup instructions for Xcode using Swift:

http://help.exercism.io/getting-started-with-swift.html


## Source

The Roman Numeral Kata [view source](http://codingdojo.org/cgi-bin/wiki.pl?KataRomanNumerals)


*/

//: ## Code


let romanNumerals = [
    (1,"I"),
    (4,"IV"),
    (5,"V"),
    (9,"IX"),
    (10,"X"),
    (40,"XL"),
    (50,"L"),
    (90,"XC"),
    (100,"C"),
    (400,"CD"),
    (500,"D"),
    (900,"CM"),
    (1000,"M")
]

extension Int {
    var toRoman:String {
        var digits:[String] = []
        var remainder = self
        
        for (number, numeral) in romanNumerals.reverse() {
            while remainder >= number {
                digits.append(numeral)
                remainder -= number
            }
        }
        
        return digits.joinWithSeparator("")
    }
}


//: ## Tests

import XCTest

class  RomanNumeralsTest: XCTestCase {
    func test1() {
        XCTAssertEqual("I", 1.toRoman)
    }
    
    func test2() {
        XCTAssertEqual("II", 2.toRoman)
    }
    
    func test3() {
        XCTAssertEqual("III", 3.toRoman)
    }
    
    func test4() {
        XCTAssertEqual("IV", 4.toRoman)
    }
    
    func test5() {
        XCTAssertEqual("V", 5.toRoman)
    }
    
    func test6() {
        XCTAssertEqual("VI", 6.toRoman)
    }
    
    func test9() {
        XCTAssertEqual("IX", 9.toRoman)
    }
    
    func test27() {
        XCTAssertEqual("XXVII", 27.toRoman)
    }
    
    func test48() {
        XCTAssertEqual("XLVIII", 48.toRoman)
    }
    
    func test59() {
        XCTAssertEqual("LIX", 59.toRoman)
    }
    
    func test93() {
        XCTAssertEqual("XCIII", 93.toRoman)
    }
    
    func test141() {
        XCTAssertEqual("CXLI", 141.toRoman)
    }
    
    func test163() {
        XCTAssertEqual("CLXIII", 163.toRoman)
    }
    
    func test402() {
        XCTAssertEqual("CDII", 402.toRoman)
    }
    
    func test575() {
        XCTAssertEqual("DLXXV", 575.toRoman)
    }
    
    func test911() {
        XCTAssertEqual("CMXI", 911.toRoman)
    }
    
    func test1024() {
        XCTAssertEqual("MXXIV", 1024.toRoman)
    }
    
    func test3000() {
        XCTAssertEqual("MMM", 3000.toRoman)
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

TestRunner().runTests(RomanNumeralsTest)
