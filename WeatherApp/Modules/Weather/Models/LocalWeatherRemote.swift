//
//  LocalWeatherRemote.swift
//  WeatherApp
//
//  Created by Piotr Olech on 14/03/2019.
//  Copyright © 2019 Piotr Olech. All rights reserved.
//

import Foundation

struct LocalWeatherRemote: Codable {
    let consolidatedWeather: [WeatherDetailsRemote]
    let title: String
    let locationType: String
    let woeid: Int
}
