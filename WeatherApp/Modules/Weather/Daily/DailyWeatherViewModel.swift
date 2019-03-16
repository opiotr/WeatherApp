//
//  DailyWeatherViewModel.swift
//  WeatherApp
//
//  Created by Piotr Olech on 16/03/2019.
//  Copyright © 2019 Piotr Olech. All rights reserved.
//

import Foundation

class DailyWeatherViewModel {
    
    // MARK: - Public properties
    
    let locationName: String
    let weatherDetails: WeatherDetailsDomain
    
    // MARK: - Init
    
    init(locationName: String, weatherDetails: WeatherDetailsDomain) {
        self.locationName = locationName
        self.weatherDetails = weatherDetails
    }
}
