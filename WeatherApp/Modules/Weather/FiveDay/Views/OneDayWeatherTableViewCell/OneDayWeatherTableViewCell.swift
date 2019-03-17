//
//  OneDayWeatherTableViewCell.swift
//  WeatherApp
//
//  Created by Piotr Olech on 16/03/2019.
//  Copyright © 2019 Piotr Olech. All rights reserved.
//

import UIKit
import Kingfisher

class OneDayWeatherTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherStateImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    // MARK: - Setup
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        setupDateLabel()
        setupTemperatureLabel()
        setupWeatherStateImageView()
    }
    
    private func setupDateLabel() {
        dateLabel.font = Font.helveticaNeueRegular(size: 16)
        dateLabel.numberOfLines = 2
        dateLabel.lineBreakMode = .byWordWrapping
    }
    
    private func setupTemperatureLabel() {
        temperatureLabel.font = Font.helveticaNeueRegular(size: 20)
        temperatureLabel.textAlignment = .right
    }
    
    private func setupWeatherStateImageView() {
        weatherStateImageView.contentMode = .scaleAspectFit
    }
    
    func setup(with data: OneDayWeatherCellData) {
        dateLabel.text = data.applicableDate
        weatherStateImageView.kf.setImage(with: data.weatherStateIconUrl)
        temperatureLabel.text = data.temperature
    }
}
