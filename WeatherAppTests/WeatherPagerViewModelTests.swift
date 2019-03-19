//
//  WeatherPagerViewModelTests.swift
//  WeatherAppTests
//
//  Created by Piotr Olech on 19/03/2019.
//  Copyright © 2019 Piotr Olech. All rights reserved.
//

import XCTest
@testable import WeatherApp

class WeatherPagerViewModelTests: XCTestCase {
    
    // MARK: - Private properties
    
    private var mockWeatherFetcher: MockWeatherFetcher!
    private var viewModel: WeatherPagerViewModel!
    
    // MARK: - Setup
    
    override func setUp() {
        mockWeatherFetcher = MockWeatherFetcher(networkingService: HTTPClient())
        viewModel = WeatherPagerViewModel(dataFetcher: mockWeatherFetcher)
    }
    
    // MARK: - Tests
    
    func testLoadDataShouldSucceed() {
        MockWeatherFetcher.fetchingCopletionState = .success
        var weatherData: LocalWeatherDomain?
        var errorData: Error?
        let callbackExpectation = expectation(description: "Callback called")
        viewModel.onLoadDataSuccess = { data in
            weatherData = data
            callbackExpectation.fulfill()
        }
        viewModel.onLoadDataError = { error in
            errorData = error
            callbackExpectation.fulfill()
        }
        
        viewModel.loadData()
        
        waitForExpectations(timeout: 3, handler: nil)
        XCTAssertNotNil(weatherData)
        XCTAssertNil(errorData)
    }
    
    func testLoadDataShouldFail() {
        MockWeatherFetcher.fetchingCopletionState = .failure
        var weatherData: LocalWeatherDomain?
        var errorData: Error?
        let callbackExpectation = expectation(description: "Callback called")
        viewModel.onLoadDataSuccess = { data in
            weatherData = data
            callbackExpectation.fulfill()
        }
        viewModel.onLoadDataError = { error in
            errorData = error
            callbackExpectation.fulfill()
        }
        
        viewModel.loadData()
        
        waitForExpectations(timeout: 3, handler: nil)
        XCTAssertNil(weatherData)
        XCTAssertNotNil(errorData)
    }
    
    func testLoadDataShouldFailDueToDataInsufficiency() {
        MockWeatherFetcher.fetchingCopletionState = .successWithInsufficientData
        var weatherData: LocalWeatherDomain?
        var errorData: Error?
        let callbackExpectation = expectation(description: "Callback called")
        viewModel.onLoadDataSuccess = { data in
            weatherData = data
            callbackExpectation.fulfill()
        }
        viewModel.onLoadDataError = { error in
            errorData = error
            callbackExpectation.fulfill()
        }
        
        viewModel.loadData()
        
        waitForExpectations(timeout: 3, handler: nil)
        XCTAssertNil(weatherData)
        XCTAssertNotNil(errorData)
    }
}
