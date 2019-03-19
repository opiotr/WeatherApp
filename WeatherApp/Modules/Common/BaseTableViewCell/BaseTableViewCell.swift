//
//  BaseTableViewCell.swift
//  WeatherApp
//
//  Created by Piotr Olech on 18/03/2019.
//  Copyright © 2019 Piotr Olech. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    static var identifier: String { return String(describing: self) }
    
    func setup(_ item: CellItem) {
        selectionStyle = .none
    }
}
