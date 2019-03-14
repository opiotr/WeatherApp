//
//  WeatherDetailsRemote.swift
//  WeatherApp
//
//  Created by Piotr Olech on 14/03/2019.
//  Copyright © 2019 Piotr Olech. All rights reserved.
//

import Foundation

struct WeatherDetailsRemote: Decodable {
    let id: Int
    let weatherStateName: String
    let weatherStateAbbr: WeatherState
    let windDirectionCompass: String
    let applicableDate: String
    let minTemp: Double
    let maxTemp: Double
    let theTemp: Double
    let windSpeed: Double
    let airPressure: Double
    let humidity: Int
}
