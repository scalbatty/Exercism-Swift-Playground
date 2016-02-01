//: [Previous](@previous)

/*:

# Meetup

Calculate the date of meetups.

Typically meetups happen on the same day of the week.

Examples are

- the first Monday
- the third Tuesday
- the Wednesteenth
- the last Thursday

Note that "Monteenth", "Tuesteenth", etc are all made up words. There
was a meetup whose members realised that there are exactly 7 days that
end in '-teenth'. Therefore, one is guaranteed that each day of the week
(Monday, Tuesday, ...) will have exactly one date that is named with '-teenth'
in every month.


## Source

Jeremy Hinegardner mentioned a Boulder meetup that happens on the Wednesteenth of every month [view source](https://twitter.com/copiousfreetime)

*/

//: ## Code

import Foundation

func lastDayOfMonth(month:Int, inYear year:Int, calendar:NSCalendar) -> Int {
    let date = dateForDay(1, month:month, year:year, withCalendar:calendar)!
    let range:Range = calendar.rangeOfUnit(.Day, inUnit: .Month, forDate: date).toRange()!
    return range.endIndex
}

func dateForDay(day:Int, month:Int, year:Int, withCalendar calendar:NSCalendar) -> NSDate? {
    let components = NSDateComponents()
    components.year = year
    components.month = month
    components.day = day
    return calendar.dateFromComponents(components)
}

struct Meetup {
    let year:Int
    let month:Int
    
    func day(targetWeekday:Int, which whichOption:String) -> NSDate {
        let calendar = NSCalendar.currentCalendar()
        
        let range:Range<Int>
        
        switch whichOption {
        case "1st":
            range = 1...7
        case "2nd":
            range = 8...14
        case "3rd":
            range = 15...21
        case "4th":
            range = 22...28
        case "teenth":
            range = 13...19
        case "last":
            let lastDay = lastDayOfMonth(month, inYear:year, calendar:calendar)
            range = (lastDay - 7)...lastDay
        default:
            range = 1...7
        }
        
        return range.map({ (day:Int) -> NSDate in
            return dateForDay(day, month:self.month, year:self.year, withCalendar:calendar)!
            })
            .filter ({ date in
                return targetWeekday == calendar.component(.Weekday, fromDate:date)
            }).first!
    }
}

//: ## Tests

import XCTest

class  MeetupTest: XCTestCase {
    
    func newDate(input:String) -> NSDate{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.dateFromString(input) ?? NSDate.distantFuture() as NSDate
    }
    
    
    let dayOfWeek = (Sunday:1, Monday:2,Tuesday:3,Wednesday:4,Thursday:5,Friday:6,Saturday:7)
    
    let whichOptions = (first:"1st", second:"2nd", third:"3rd", forth:"4th", last:"last",teenth:"teenth")
    
    
    func test_monteenth_of_may_2013(){
        let meetUp = Meetup(year: 2013, month: 5)
        XCTAssertEqual(newDate("2013-5-13"),  meetUp.day(dayOfWeek.Monday, which: whichOptions.teenth))
    }
    
    
    func test_saturteenth_of_february_2013(){
        let meetUp = Meetup(year: 2013, month: 2)
        XCTAssertEqual(newDate("2013-2-16"), meetUp.day(dayOfWeek.Saturday, which: whichOptions.teenth))
    }
    
    
    func test_first_tuesday_of_may_2013(){
        let meetUp = Meetup(year: 2013, month: 5)
        XCTAssertEqual(newDate("2013-5-7"), meetUp.day(dayOfWeek.Tuesday, which: whichOptions.first))
    }
    
    
    func test_second_monday_of_april_2013(){
        let meetUp = Meetup(year: 2013, month: 4)
        XCTAssertEqual(newDate("2013-4-8"), meetUp.day(dayOfWeek.Monday, which: whichOptions.second))
    }
    
    
    func test_third_thursday_of_september_2013(){
        let meetUp = Meetup(year: 2013, month: 9)
        XCTAssertEqual(newDate("2013-9-19"), meetUp.day(dayOfWeek.Thursday, which: whichOptions.third))
    }
    
    
    func test_fourth_sunday_of_march_2013(){
        let meetUp = Meetup(year: 2013, month: 3)
        XCTAssertEqual(newDate("2013-3-24"), meetUp.day(dayOfWeek.Sunday, which: whichOptions.forth))
    }
    
    
    func test_last_thursday_of_october_2013(){
        let meetUp = Meetup(year: 2013, month: 10)
        XCTAssertEqual(newDate("2013-10-31"), meetUp.day(dayOfWeek.Thursday, which: whichOptions.last))
    }
    
    
    func test_last_wednesday_of_february_2012(){
        let meetUp = Meetup(year: 2012, month: 2)
        XCTAssertEqual(newDate("2012-2-29"), meetUp.day(dayOfWeek.Wednesday, which: whichOptions.last))}
    
    func test_first_friday_of_december_2012(){
        let meetUp = Meetup(year: 2012, month: 12)
        XCTAssertEqual(newDate("2012-12-7"), meetUp.day(dayOfWeek.Friday, which: whichOptions.first)
        )}
    
    
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

TestRunner().runTests(MeetupTest)
