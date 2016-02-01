//: [Previous](@previous)

/*:

# Accumulate

Implement the `accumulate` operation, which, given a collection and an operation to perform on each element of the collection, returns a new collection containing the result of applying that operation to each element of the input collection.

For example, given the collection of numbers:

- 1, 2, 3, 4, 5

And the operation:

- square a number

Your code should be able to produce the collection of squares:

- 1, 4, 9, 16, 25

## Restrictions

Keep your hands off that collect/map/fmap/whatchamacallit functionality
provided by your standard library!
Solve this one yourself using other basic tools instead.

Elixir specific: it's perfectly fine to use `Enum.reduce` or
`Enumerable.reduce`.


## Source

Conversation with James Edward Gray II [view source](https://twitter.com/jeg2)


*/

//: ## Code

extension Array {
    func accumulate<U>(mod:(_:Element) -> U) -> [U] {
        var result:[U] = [U]()
        for element:Element in self {
            result.append(mod(element))
        }
        return result;
    }
}

//: ## Tests

import Foundation
import XCTest

extension String {
    
    var length: Int {return self.characters.count}
    
    func reverse() -> String {
        var result:String = ""
        for char in self.characters {
            result = "\(char)\(result)"
        }
        return result
    }
    
}

class AccumulateTest: XCTestCase {
    
    func test_empty_accumulation() {
        
        let input = [Int]([])
        let expected = []
        func square(input:Int) -> Int {
            return input * input
        }
        
        let result = input.accumulate(square)
        
        XCTAssert(expected == result)
    }
    
    func test_accumulate_squares() {
        
        let input = [1,2,3,4]
        let expected = [1,4,9,16]
        func square(input:Int) -> Int {
            return input * input
        }
        
        let result = input.accumulate(square)
        
        XCTAssert(expected == result)
    }
    
    
    func test_accumulate_upcases() {
        
        let input = ["hello","world"]
        let expected = ["HELLO","WORLD"]
        func toUpper(input:String) -> String {
            return input.uppercaseString
        }
        
        let result = input.accumulate(toUpper)
        
        XCTAssert(expected == result)
        
    }
    
    
    func test_accumulate_reversed_strings() {
        
        let input =    ["the","quick","brown","fox","etc"]
        let expected = ["eht","kciuq","nworb","xof","cte"]
        func reverse(input:String) -> String {
            return input.reverse()
        }
        
        let result = input.accumulate(reverse)
        
        XCTAssert(expected == result)
    }
    
    func test_accumulate_recursively() {
        
        let input =   ["a","b","c"]
        
        let expected = [
            ["a1","a2","a3"],
            ["b1","b2","b3"],
            ["c1","c2","c3"]
        ]
        
        func recurse(input:String) -> [String] {
            func appendTo(innerInput:String) -> String {
                return input+innerInput
            }
            let result = ["1","2","3"].accumulate(appendTo)
            return result
        }
        
        
        let result = input.accumulate(recurse)
        
        XCTAssert(expected == result)
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

TestRunner().runTests(AccumulateTest)
