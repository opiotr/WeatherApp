//
//  DailyWeatherDetailsTableViewCell.swift
//  WeatherApp
//
//  Created by Piotr Olech on 18/03/2019.
//  Copyright © 2019 Piotr Olech. All rights reserved.
//

import UIKit

class DailyWeatherDetailsTableViewCell: BaseTableViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Setup
    
    override func awakeFromNib() {
        super.awakeFromNib()

        setupTitleLabel()
    }
    
    private func setupTitleLabel() {
        titleLabel.font = Font.helveticaNeueRegular(size: 18)
        titleLabel.textAlignment = .left
    }
    
    override func setup(_ item: CellItem) {
        super.setup(item)
        
        guard let data = item.data as? DailyWeatherDetailsCellData else { return }
        
        titleLabel.text = data.title
    }
}
