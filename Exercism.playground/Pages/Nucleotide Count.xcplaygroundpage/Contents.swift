//: [Previous](@previous)

/*:

# Nucleotide Count

Write a class `DNA` that takes a DNA string and tells us how many times each nucleotide occurs in the string.

DNA is represented by an alphabet of the following symbols: 'A', 'C',
'G', and 'T'.

Each symbol represents a nucleotide, which is a fancy name for the
particular molecules that happen to make up a large part of DNA.

Shortest intro to biochemistry EVAR:

- twigs are to birds nests as
- nucleotides are to DNA and RNA as
- amino acids are to proteins as
- sugar is to starch as
- oh crap lipids

I'm not going to talk about lipids because they're crazy complex.

So back to nucleotides.

DNA contains four types of them: adenine (`A`), cytosine (`C`), guanine
(`G`), and thymine (`T`).

RNA contains a slightly different set of nucleotides, but we don't care
about that for now.


## Source

The Calculating DNA Nucleotides_problem at Rosalind [view source](http://rosalind.info/problems/dna/)


*/

//: ## Code

import Foundation

let ALLOWED_NUCLEOTIDES = ["A","T","C","G"]

public class DNA {
    
    private var strand:String
    private var _nucleotideCounts:[String:Int]?
    private var sanitizedStrand:[String]
    
    public var nucleotideCounts:[String:Int] {
        get {
            if (_nucleotideCounts == nil) {
                self.processNucleotideCount()
            }
            return _nucleotideCounts!
        }
    }
    
    private func processNucleotideCount() {
        
        _nucleotideCounts = ["A" : count("A") ?? 0,
            "T" : count("T") ?? 0,
            "C" : count("C") ?? 0,
            "G" : count("G") ?? 0]
    }
    
    public class func withStrand(strand:String) -> DNA? {
        return strand.containsOnlyCharacters(ALLOWED_NUCLEOTIDES) ? DNA(strand) : nil
    }
    
    private init(_ strand:String) {
        self.strand = strand.uppercaseString
        self.sanitizedStrand = strand.characters.map({String($0)})
    }
    
    public func count(nucleotide:String) -> Int? {
        return ALLOWED_NUCLEOTIDES.contains(nucleotide) ?
            self.sanitizedStrand.filter(equals(nucleotide)).count
            : nil;
    }
}

func equals (template:String) -> (candidate:String) -> Bool {
    return {(candidate:String) -> Bool in return candidate == template}
}

extension String {
    public func containsOnlyCharacters(chars:[String]) -> Bool {
        return self.rangeOfCharacterFromSet(NSCharacterSet(charactersInString: chars.joinWithSeparator("")).invertedSet) == nil
    }
}

//: ## Tests

import XCTest

class NucleotideCountTest: XCTestCase
{
    func testEmptyDNAStringHasNoAdenosine() {
        let dna = DNA.withStrand("")!
        let result = dna.count("A")
        let expected = 0
        XCTAssertEqual(result, expected)
    }
    
    func testEmptyDNAStringHasNoNucleotides() {
        let dna = DNA.withStrand("")!
        let results = dna.nucleotideCounts
        let expected = [ "A": 0, "T" : 0, "C" : 0, "G" : 0 ]
        XCTAssertEqual(results, expected)
    }
    
    func testRepetitiveCytidineGetsCounted() {
        let dna = DNA.withStrand("CCCCC")!
        let result = dna.count("C")!
        let expected = 5
        XCTAssertEqual(result, expected)
    }
    
    func testRepetitiveSequenceHasOnlyGuanosine() {
        let dna = DNA.withStrand("GGGGGGGG")!
        let results = dna.nucleotideCounts
        let expected = [ "A": 0, "T" : 0, "C" : 0, "G" : 8 ]
        XCTAssertEqual(results, expected)
    }
    
    func testCountsByThymidine() {
        let dna = DNA.withStrand("GGGGGTAACCCGG")!
        let result = dna.count("T")!
        let expected = 1
        XCTAssertEqual(result, expected)
    }
    
    func testCountsANucleotideOnlyOnce() {
        let dna = DNA.withStrand("CGATTGGG")!
        let result = dna.count("T")!
        let expected = 2
        XCTAssertEqual(result, expected)
    }
    
    func testDNAHasNoUracil() {
        let dna = DNA.withStrand("GATTACA")!
        let result = dna.count("U")
        XCTAssertNil(result)
    }
    
    func testValidatesDNANotRNA() {
        let dna = DNA.withStrand("ACGU")
        XCTAssertNil(dna)
    }
    
    func testValidatesDNA() {
        let dna = DNA.withStrand("John")
        XCTAssertNil(dna)
    }
    
    func testCountsAllNucleotides() {
        let longStrand = "AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC"
        let dna = DNA.withStrand(longStrand)!
        let results = dna.nucleotideCounts
        let expected = [ "A": 20, "T" : 21, "C" : 12, "G" : 17 ]
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

TestRunner().runTests(NucleotideCountTest)
