//
//  DailyWeatherMainTableViewCell.swift
//  WeatherApp
//
//  Created by Piotr Olech on 18/03/2019.
//  Copyright © 2019 Piotr Olech. All rights reserved.
//

import UIKit

class DailyWeatherMainTableViewCell: BaseTableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherStateImageView: UIImageView!
    @IBOutlet weak var weatherStateLabel: UILabel!
    
    // MARK: - Setup

    override func awakeFromNib() {
        super.awakeFromNib()

        setupTemperatureLabel()
        setupWeatherStateImageView()
        setupWeatherStateLabel()
    }
    
    private func setupTemperatureLabel() {
        temperatureLabel.font = Font.helveticaNeueRegular(size: 100)
        temperatureLabel.textAlignment = .center
    }
    
    private func setupWeatherStateImageView() {
        weatherStateImageView.kf.indicatorType = .activity
        weatherStateImageView.contentMode = .scaleAspectFit
    }
    
    private func setupWeatherStateLabel() {
        weatherStateLabel.font = Font.helveticaNeueRegular(size: 17)
        weatherStateLabel.textAlignment = .center
    }
    
    override func setup(_ item: CellItem) {
        super.setup(item)
        
        guard let data = item.data as? DailyWeatherMainCellData else { return }
        
        temperatureLabel.text = data.temperature
        weatherStateImageView.kf.setImage(with: data.weatherStateIconUrl)
        weatherStateLabel.text = data.weatherStateName
    }
}
