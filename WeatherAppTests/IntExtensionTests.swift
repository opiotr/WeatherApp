//
//  IntExtensionTests.swift
//  WeatherAppTests
//
//  Created by Piotr Olech on 19/03/2019.
//  Copyright © 2019 Piotr Olech. All rights reserved.
//

import XCTest
@testable import WeatherApp

class IntExtensionTests: XCTestCase {
    
    // MARK: - Private properties
    
    private let temperatureUnit = "℃"
    
    // MARK: - Tests
    
    func testFormatTemperatureToCelsiusWithPositiveValue() {
        let temperature: Int = 10
        
        let formattedTemperature = temperature.formatToCelsiusTemperatureString()
        
        XCTAssertEqual(formattedTemperature, "\(temperature)" + temperatureUnit)
    }
    
    func testFormatTemperatureToCelsiusWithNegativeValue() {
        let temperature: Int = -2
        
        let formattedTemperature = temperature.formatToCelsiusTemperatureString()
        
        XCTAssertEqual(formattedTemperature, "\(temperature)" + temperatureUnit)
    }
    
    func testFormatTemperatureWithZeroValue() {
        let temperature: Int = 0
        
        let formattedTemperature = temperature.formatToCelsiusTemperatureString()
        
        XCTAssertEqual(formattedTemperature, "\(temperature)" + temperatureUnit)
    }
}
