//
//  OneDayWeatherCellData.swift
//  WeatherApp
//
//  Created by Piotr Olech on 16/03/2019.
//  Copyright © 2019 Piotr Olech. All rights reserved.
//

import Foundation

class OneDayWeatherCellData: CellData {
    let applicableDate: String
    let temperature: String
    let weatherStateIconUrl: URL?
    
    init(applicableDate: String, temperature: String, weatherStateIconUrl: URL?) {
        self.applicableDate = applicableDate
        self.temperature = temperature
        self.weatherStateIconUrl = weatherStateIconUrl
    }
}
