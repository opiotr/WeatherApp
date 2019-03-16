//
//  LocalWeatherDomain.swift
//  WeatherApp
//
//  Created by Piotr Olech on 15/03/2019.
//  Copyright © 2019 Piotr Olech. All rights reserved.
//

import Foundation

struct LocalWeatherDomain {
    let locationName: String
    let currentDayWeather: WeatherDetailsDomain
    let fiveDayWeather: [WeatherDetailsDomain]
}
