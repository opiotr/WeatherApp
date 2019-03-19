//
//  DateExtensionTests.swift
//  WeatherAppTests
//
//  Created by Piotr Olech on 19/03/2019.
//  Copyright © 2019 Piotr Olech. All rights reserved.
//

import XCTest
@testable import WeatherApp

class DateExtensionTests: XCTestCase {
    
    // MARK: - Tests
    
    func testFormatDateToStringWithDayMonthYearFormat() {
        let date = Date(timeIntervalSince1970: 0)
        
        let dateString = date.toString(withFormat: "dd-MM-yyyy")
        
        XCTAssertEqual(dateString, "01-01-1970")
    }
    
    func testFormatDateToStringWithLiteralDayAndMonthFormat() {
        let date = Date(timeIntervalSince1970: 0)
        
        let dateString = date.toString(withFormat: "EEEE, MMM")
        
        XCTAssertEqual(dateString, "Thursday, Jan")
    }
}
