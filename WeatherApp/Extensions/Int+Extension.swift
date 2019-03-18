//
//  Int+Extension.swift
//  WeatherApp
//
//  Created by Piotr Olech on 18/03/2019.
//  Copyright © 2019 Piotr Olech. All rights reserved.
//

import Foundation

extension Int {
    func formatToCelsiusTemperatureString() -> String {
        return "\(self)\u{2103}"
    }
}
