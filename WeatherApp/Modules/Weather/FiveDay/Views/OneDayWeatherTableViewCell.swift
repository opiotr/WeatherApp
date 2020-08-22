//
//  OneDayWeatherTableViewCell.swift
//  WeatherApp
//
//  Created by Piotr Olech on 16/03/2019.
//  Copyright © 2019 Piotr Olech. All rights reserved.
//

import UIKit
import Kingfisher

class OneDayWeatherTableViewCell: BaseTableViewCell {
    
    // MARK: - IBOutlets
    
    private let dateLabel: UILabel = UILabel()
    private let weatherStateImageView: UIImageView = UIImageView()
    private let temperatureLabel: UILabel = UILabel()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
        // MARK: - Setup

    private func setupView() {
        setupAutoLayout()
        setupDateLabel()
        setupTemperatureLabel()
        setupWeatherStateImageView()
    }
    
    private func setupAutoLayout() {
        [dateLabel, weatherStateImageView, temperatureLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        NSLayoutConstraint.activate([
            dateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -18),
            weatherStateImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            weatherStateImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            weatherStateImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 3/7),
            weatherStateImageView.widthAnchor.constraint(equalTo: weatherStateImageView.heightAnchor, multiplier: 0.66),
            weatherStateImageView.leftAnchor.constraint(equalTo: dateLabel.rightAnchor, constant: 18),
            temperatureLabel.leftAnchor.constraint(equalTo: weatherStateImageView.rightAnchor, constant: 18),
            temperatureLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12),
            temperatureLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18),
            temperatureLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -18)
        ])
    }
    
    private func setupDateLabel() {
        dateLabel.font = Font.helveticaNeueRegular(size: 17)
        dateLabel.numberOfLines = 2
        dateLabel.lineBreakMode = .byWordWrapping
    }
    
    private func setupTemperatureLabel() {
        temperatureLabel.font = Font.helveticaNeueRegular(size: 22)
        temperatureLabel.textAlignment = .right
    }
    
    private func setupWeatherStateImageView() {
        weatherStateImageView.kf.indicatorType = .activity
        weatherStateImageView.contentMode = .scaleAspectFit
    }
    
    override func setup(_ item: CellItem) {
        super.setup(item)
        
        guard let data = item.data as? OneDayWeatherCellData else { return }
        
        dateLabel.text = data.applicableDate
        weatherStateImageView.kf.setImage(with: data.weatherStateIconUrl)
        temperatureLabel.text = data.temperature
    }
}
