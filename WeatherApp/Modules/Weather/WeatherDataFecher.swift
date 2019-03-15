//
//  WeatherDataFecher.swift
//  WeatherApp
//
//  Created by Piotr Olech on 15/03/2019.
//  Copyright © 2019 Piotr Olech. All rights reserved.
//

import Foundation

class WeatherDataFetcher {
    
    // MARK: - Private properties
    
    private let networkingService: HTTPClient
    
    // MARK: - Init
    
    init(networkingService: HTTPClient = HTTPClient()) {
        self.networkingService = networkingService
    }
    
    // MARK: - Data fetching
    
    func fetchWeatherData(for locationId: Int, success: @escaping (LocalWeatherRemote) -> Void, failure: @escaping (Error) -> Void) {
        let path = "/\(locationId)"
        let endpoint = Endpoint<LocalWeatherRemote>(path: path)
        networkingService.request(endpoint, success: success, failure: failure)
    }
}
