//
//  DailyWeatherMainCellData.swift
//  WeatherApp
//
//  Created by Piotr Olech on 18/03/2019.
//  Copyright © 2019 Piotr Olech. All rights reserved.
//

import Foundation

class DailyWeatherMainCellData: CellData {
    let temperature: String
    let weatherStateIconUrl: URL?
    let weatherStateName: String
    
    init(temperature: String, weatherStateIconUrl: URL?, weatherStateName: String) {
        self.temperature = temperature
        self.weatherStateIconUrl = weatherStateIconUrl
        self.weatherStateName = weatherStateName
    }
}
