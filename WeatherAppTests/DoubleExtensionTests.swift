//
//  DoubleExtensionTests.swift
//  WeatherAppTests
//
//  Created by Piotr Olech on 19/03/2019.
//  Copyright © 2019 Piotr Olech. All rights reserved.
//

import XCTest
@testable import WeatherApp

class DoubleExtensionTests: XCTestCase {
    
    // MARK: - Tests
    
    func testRoundDoubleNearFloorIntegerValue() {
        let value: Double = 1.1
        
        let rounded: Int = value.roundToInt()
        
        XCTAssertEqual(rounded, 1)
    }
    
    func testRoundDoubleNearCeilIntegerValue() {
        let value: Double = 1.9
        
        let rounded: Int = value.roundToInt()
        
        XCTAssertEqual(rounded, 2)
    }
    
    func testRoundDoubleHalfwayBetweenTwoIntegralValues() {
        let value: Double = 1.5
        
        let rounded: Int = value.roundToInt()
        
        XCTAssertEqual(rounded, 2)
    }    
}
