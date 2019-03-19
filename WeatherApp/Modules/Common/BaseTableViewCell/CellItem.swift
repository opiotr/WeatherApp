//
//  CellItem.swift
//  WeatherApp
//
//  Created by Piotr Olech on 18/03/2019.
//  Copyright © 2019 Piotr Olech. All rights reserved.
//

import Foundation

class CellItem {
    var identifier: String
    var data: CellData
    
    init(identifier: String, data: CellData) {
        self.identifier = identifier
        self.data = data
    }
}
