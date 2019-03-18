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
    let onRefreshData: () -> Void

    // MARK: - Private properties
    
    private let weatherDetails: WeatherDetailsDomain
    
    // MARK: - Init
    
    init(locationName: String, weatherDetails: WeatherDetailsDomain, refreshDataAction: @escaping () -> Void) {
        self.locationName = locationName.uppercased()
        self.weatherDetails = weatherDetails
        self.onRefreshData = refreshDataAction
    }
}
