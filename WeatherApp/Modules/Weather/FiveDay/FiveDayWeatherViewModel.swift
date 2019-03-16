//
//  FiveDayWeatherViewModel.swift
//  WeatherApp
//
//  Created by Piotr Olech on 16/03/2019.
//  Copyright © 2019 Piotr Olech. All rights reserved.
//

import Foundation

class FiveDayWeatherViewModel {
    
    // MARK: - Public properties
    
    let data: [WeatherDetailsDomain]
    
    // MARK: - Init
    
    init(data: [WeatherDetailsDomain]) {
        self.data = data
    }
}
