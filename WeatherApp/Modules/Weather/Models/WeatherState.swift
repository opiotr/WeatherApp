//
//  WeatherState.swift
//  WeatherApp
//
//  Created by Piotr Olech on 14/03/2019.
//  Copyright © 2019 Piotr Olech. All rights reserved.
//

import Foundation

enum WeatherState: String, Decodable {
    case snow = "sn"
    case sleet = "sl"
    case hail = "h"
    case thunderstorm = "t"
    case heavyRain = "hr"
    case lightRain = "lr"
    case showers = "s"
    case heavyCloud = "hc"
    case lightCloud = "lc"
    case clear = "c"
}
