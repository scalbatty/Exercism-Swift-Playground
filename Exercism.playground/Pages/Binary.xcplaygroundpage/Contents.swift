//: [Previous](@previous)

//: ## Code

struct Binary {
    let value:Int
    
    init?(_ input:String) {
        
        let chars = input.characters
        guard chars.filter({ return $0 != "0" && $0 != "1" }).count == 0 else { return nil }
        
        let bits = chars.flatMap({ $0 == "1" }).reverse()
        
        self.value = bits.enumerate().reduce(0, combine: { acc, tuple in
            
            let bit = tuple.element
            let power = tuple.index
            
            let add = bit ? pow(2, power) : 0
            return acc + Int(add)
        })
    }
}


func pow(a: Int, _ b: Int) -> Int {
    return Int(pow(Double(a), Double(b)))
}

extension Int {
    init?(_ binary:Binary?) {
        guard let binary = binary else { return nil }
        self.init(binary.value)
    }
}

import XCTest

//: ## Tests

class BinaryTests: XCTestCase {
    
    func testBinary0IsDecimal0() {
        XCTAssertEqual( 0, Int(Binary("0")))
    }
    
    func testBinary1isDecimal1() {
        XCTAssertEqual( 1, Int(Binary("1")))
    }
    
    func testBinary10isDecimal2() {
        XCTAssertEqual( 2, Int(Binary("10")))
    }
    
    func testBinary11isDecimal3() {
        XCTAssertEqual( 3, Int(Binary("11")))
    }
    
    func testBinary100isDecimal4() {
        XCTAssertEqual( 4, Int(Binary("100")))
    }
    
    func testBinary1001isDecimal9() {
        XCTAssertEqual( 9, Int(Binary("1001")))
    }
    
    func testBinary11010isDecimal26() {
        XCTAssertEqual( 26, Int(Binary("11010")))
    }
    
    func testBinary10001101000isDecimal1128() {
        XCTAssertEqual( 1128, Int(Binary("10001101000")))
    }
    
    func testBinaryIgnoresLeadingZeros() {
        XCTAssertEqual( 31, Int(Binary("000011111")))
    }
    
    func testInvalidBinaryIsDecimal0() {
        XCTAssertNil ( Binary("carrot123"))
    }
    
    func testInvalidBinaryNumbers() {
        XCTAssertNil ( Binary("012"))
        XCTAssertNil ( Binary("10nope"))
        XCTAssertNil ( Binary("nope10"))
        
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

TestRunner().runTests(BinaryTests)
