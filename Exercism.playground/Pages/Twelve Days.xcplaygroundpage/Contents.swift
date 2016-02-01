//: [Previous](@previous)

/*:

# Twelve Days

Write a program that outputs the lyrics to 'The Twelve Days of Christmas'

```ruby
On the first day of Christmas my true love gave to me, a Partridge in a Pear Tree.

On the second day of Christmas my true love gave to me, two Turtle Doves, and a Partridge in a Pear Tree.

On the third day of Christmas my true love gave to me, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.

On the fourth day of Christmas my true love gave to me, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.

On the fifth day of Christmas my true love gave to me, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.

On the sixth day of Christmas my true love gave to me, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.

On the seventh day of Christmas my true love gave to me, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.

On the eighth day of Christmas my true love gave to me, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.

On the ninth day of Christmas my true love gave to me, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.

On the tenth day of Christmas my true love gave to me, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.

On the eleventh day of Christmas my true love gave to me, eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.

On the twelfth day of Christmas my true love gave to me, twelve Drummers Drumming, eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.
```


## Source

Wikipedia [view source](http://en.wikipedia.org/wiki/The_Twelve_Days_of_Christmas_(song))


*/

//: ## Code

import Foundation

struct TwelveDaysSong {
    static let numerals = ["first",
        "second",
        "third",
        "fourth",
        "fifth",
        "sixth",
        "seventh",
        "eighth",
        "ninth",
        "tenth",
        "eleventh",
        "twelfth"]
    
    static let sentences = ["a Partridge in a Pear Tree.",
        "two Turtle Doves,",
        "three French Hens,",
        "four Calling Birds,",
        "five Gold Rings,",
        "six Geese-a-Laying,",
        "seven Swans-a-Swimming,",
        "eight Maids-a-Milking,",
        "nine Ladies Dancing,",
        "ten Lords-a-Leaping,",
        "eleven Pipers Piping,",
        "twelve Drummers Drumming,"]
    
    static let introFormat = "On the %@ day of Christmas my true love gave to me,"
    
    static func verse (verseNumber:Int) -> String {
        
        if (verseNumber < 1 || verseNumber > 12) {
            return ""
        }
        
        let intro = String(format: introFormat, numerals[verseNumber - 1])
        var selectedSentences:[String]
        
        if (verseNumber == 1) {
            selectedSentences = [intro, sentences[0]]
        }
        else {
            selectedSentences = Array(sentences[0..<verseNumber]).reverse()
            selectedSentences.insert("and", atIndex:selectedSentences.endIndex - 1)
            selectedSentences.insert(intro, atIndex:0)
        }
        
        return selectedSentences.joinWithSeparator(" ") + "\n"
    }
    
    static func verses (firstVerseNumber:Int, _ lastVerseNumber:Int) -> String {
        return (firstVerseNumber...lastVerseNumber).map(TwelveDaysSong.verse).joinWithSeparator("\n") + "\n"
    }
    
    static func sing() -> String {
        return verses(1, 12)
    }
}

//: ## Tests

import XCTest


class TwelveDaysTest: XCTestCase {
    
    
    func test_verse1(){
        let expected = "On the first day of Christmas my true love gave to me, a Partridge in a Pear Tree.\n"
        let result = TwelveDaysSong.verse(1)
        XCTAssertEqual(expected, result)
    }
    
    func test_verse2(){
        let expected = "On the second day of Christmas my true love gave to me, two Turtle Doves, and a Partridge in a Pear Tree.\n"
        let result = TwelveDaysSong.verse(2)
        XCTAssertEqual(expected, result)
    }
    
    func test_verse3(){
        let expected = "On the third day of Christmas my true love gave to me, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.\n"
        let result = TwelveDaysSong.verse(3)
        XCTAssertEqual(expected, result)
    }
    
    func test_verse4(){
        let expected = "On the fourth day of Christmas my true love gave to me, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.\n"
        let result = TwelveDaysSong.verse(4)
        XCTAssertEqual(expected, result)
    }
    
    func test_verse5(){
        let expected = "On the fifth day of Christmas my true love gave to me, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.\n"
        let result = TwelveDaysSong.verse(5)
        XCTAssertEqual(expected, result)
    }
    
    func test_verse6(){
        let expected = "On the sixth day of Christmas my true love gave to me, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.\n"
        let result = TwelveDaysSong.verse(6)
        XCTAssertEqual(expected, result)
    }
    
    func test_verse7(){
        let expected = "On the seventh day of Christmas my true love gave to me, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.\n"
        let result = TwelveDaysSong.verse(7)
        XCTAssertEqual(expected, result)
    }
    
    func test_verse8(){
        let expected = "On the eighth day of Christmas my true love gave to me, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.\n"
        let result = TwelveDaysSong.verse(8)
        XCTAssertEqual(expected, result)
    }
    
    func test_verse9(){
        let expected = "On the ninth day of Christmas my true love gave to me, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.\n"
        let result = TwelveDaysSong.verse(9)
        XCTAssertEqual(expected, result)
    }
    
    func test_verse10(){
        let expected = "On the tenth day of Christmas my true love gave to me, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.\n"
        let result = TwelveDaysSong.verse(10)
        XCTAssertEqual(expected, result)
    }
    
    func test_verse11(){
        let expected = "On the eleventh day of Christmas my true love gave to me, eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.\n"
        let result = TwelveDaysSong.verse(11)
        XCTAssertEqual(expected, result)
    }
    
    func test_verse12(){
        let expected = "On the twelfth day of Christmas my true love gave to me, twelve Drummers Drumming, eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.\n"
        let result = TwelveDaysSong.verse(12)
        XCTAssertEqual(expected, result)
    }
    
    func test_multiple_verses(){
        let expected = (
            "On the first day of Christmas my true love gave to me, a Partridge in a Pear Tree.\n\n" +
                "On the second day of Christmas my true love gave to me, two Turtle Doves, and a Partridge in a Pear Tree.\n\n" +
            "On the third day of Christmas my true love gave to me, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.\n\n")
        let result = TwelveDaysSong.verses(1, 3)
        XCTAssertEqual(expected, result)
    }
    
    func test_the_whole_song(){
        
        XCTAssertEqual(TwelveDaysSong.verses(1, 12), TwelveDaysSong.sing())
        
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

TestRunner().runTests(TwelveDaysTest)
