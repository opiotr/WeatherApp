//
//  MockWeatherFetcher.swift
//  WeatherAppTests
//
//  Created by Piotr Olech on 19/03/2019.
//  Copyright © 2019 Piotr Olech. All rights reserved.
//

import Foundation
@testable import WeatherApp

class MockWeatherFetcher: WeatherDataFetcher {
    
    // MARK: - FetchingCompletionState enum
    
    enum FetchingCompletionState {
        case success
        case failure
        case successWithInsufficientData
    }
    
    // MARK: - Static property
    
    static var fetchingCopletionState: FetchingCompletionState = .success
    
    // MARK: - Override
    
    override func fetchWeatherData(for locationId: Int, success: @escaping (LocalWeatherRemote) -> Void, failure: @escaping (Error) -> Void) {

        switch MockWeatherFetcher.fetchingCopletionState {
        case .success:
            let mockData = generateMockWeatherData(locationId: locationId)
            success(mockData)
        case .failure:
            let error = NSError(domain: "Fetching data error", code: -1, userInfo: nil) as Error
            failure(error)
        case .successWithInsufficientData:
            let mockData = LocalWeatherRemote(consolidatedWeather: [], title: "Warsaw", locationType: "City", woeid: locationId)
            success(mockData)
        }
    }
    
    // MARK: - Mock data
    
    private func generateMockWeatherData(locationId: Int) -> LocalWeatherRemote {
        let mockConsolidatedWeather = [
            WeatherDetailsRemote(id: 1, weatherStateName: "Clear", weatherStateAbbr: .clear, windDirectionCompass: "", applicableDate: "2019-03-19", minTemp: 7, maxTemp: 11, theTemp: 10, windSpeed: 10, airPressure: 1000, humidity: 50),
            WeatherDetailsRemote(id: 2, weatherStateName: "Sleet", weatherStateAbbr: .sleet, windDirectionCompass: "", applicableDate: "2019-03-20", minTemp: 3, maxTemp: 8, theTemp: 8, windSpeed: 5, airPressure: 999, humidity: 35)
        ]
        let mockData = LocalWeatherRemote(consolidatedWeather: mockConsolidatedWeather, title: "Warsaw", locationType: "City", woeid: locationId)
        return mockData
    }
}
