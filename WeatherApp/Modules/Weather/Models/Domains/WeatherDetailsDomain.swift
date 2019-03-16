//
//  WeatherDetailsDomain.swift
//  WeatherApp
//
//  Created by Piotr Olech on 15/03/2019.
//  Copyright © 2019 Piotr Olech. All rights reserved.
//

import Foundation

struct WeatherDetailsDomain {
    let weatherStateName: String
    let weatherStateAbbreviation: WeatherState
    let applicableDate: String
    let temperature: Int
    let minTemperature: Int
    let maxTemperature: Int
    let windSpeed: Int
    let airPressure: Int
    let humidity: Int
}
