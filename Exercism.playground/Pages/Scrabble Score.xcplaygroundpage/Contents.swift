//: [Previous](@previous)

/*:

# Scrabble Score

Write a program that, given a word, computes the scrabble score for that word.

## Letter Values

You'll need these:

```plain
Letter                           Value
A, E, I, O, U, L, N, R, S, T       1
D, G                               2
B, C, M, P                         3
F, H, V, W, Y                      4
K                                  5
J, X                               8
Q, Z                               10
```

## Examples
"cabbage" should be scored as worth 14 points:

- 3 points for C
- 1 point for A, twice
- 3 points for B, twice
- 2 points for G
- 1 point for E

And to total:

- `3 + 2*1 + 2*3 + 2 + 1`
- = `3 + 2 + 6 + 3`
- = `5 + 9`
- = 14

## Extensions
- You can play a `:double` or a `:triple` letter.
- You can play a `:double` or a `:triple` word.

## Setup

Go through the project setup instructions for Xcode using Swift:

http://help.exercism.io/getting-started-with-swift.html


## Source

Inspired by the Extreme Startup game [view source](https://github.com/rchatley/extreme_startup)


*/

//: ## Code

let scores =    [(score:1,letters:["A", "E", "I", "O", "U", "L", "N", "R", "S", "T"])
    ,(score:2,letters:["D","G"])
    ,(score:3,letters:["B","C","M","P"])
    ,(score:4,letters:["F","H","V","W","Y"])
    ,(score:5,letters:["K"])
    ,(score:8,letters:["J","X"])
    ,(score:10,letters:["Q","Z"])]

func scoreForLetter(letter:Character) -> Int {
    return scores.filter { (score, letters) -> Bool in
        return letters.filter{$0 == String(letter).uppercaseString}.count > 0
        }.first?.score ?? 0
}


struct Scrabble {
    let word:String
    
    var score:Int {
        get {
            return Scrabble.score(word)
        }
    }
    
    init(_ word:String?) {
        self.word = word ?? ""
    }
    
    static func score(word:String) -> Int {
        return word.characters.map(){scoreForLetter($0)}.reduce(0, combine: +)
    }
    
}

//: ## Tests

import XCTest

class ScrambbleScoreTest: XCTestCase {
    
    func testEmptyWordScoresZero() {
        XCTAssertEqual( 0, Scrabble("").score)
    }
    
    func testWhitespaceScoresZero() {
        XCTAssertEqual( 0, Scrabble(" \t\n").score)
    }
    
    func testNilScoresZero() {
        XCTAssertEqual( 0, Scrabble(nil).score)
    }
    
    func testScoresVeryShortWord() {
        XCTAssertEqual( 1, Scrabble("a").score)
    }
    
    func testScoresOtherVeryShortWord() {
        XCTAssertEqual( 4, Scrabble("f").score)
    }
    
    func testSimpleWordScoresTheNumberOfLetters() {
        XCTAssertEqual( 6, Scrabble("street").score)
    }
    
    func testComplicatedWordScoresMore() {
        XCTAssertEqual( 22, Scrabble("quirky").score)
    }
    
    func testScoresAreCaseInsensitive() {
        XCTAssertEqual( 20, Scrabble("MULTIBILLIONAIRE").score)
    }
    
    func testConvenientScoring() {
        XCTAssertEqual( 13, Scrabble.score("alacrity"))
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

TestRunner().runTests(ScrambbleScoreTest)
