//
//  Double+Extension.swift
//  WeatherApp
//
//  Created by Piotr Olech on 15/03/2019.
//  Copyright © 2019 Piotr Olech. All rights reserved.
//

import Foundation

extension Double {
    func roundToInt() -> Int {
        var value = self
        value.round()
        return Int(value)
    }
}
