//
//  DailyWeatherMainTableViewCell.swift
//  WeatherApp
//
//  Created by Piotr Olech on 18/03/2019.
//  Copyright © 2019 Piotr Olech. All rights reserved.
//

import UIKit

final class DailyWeatherMainTableViewCell: BaseTableViewCell {
    
    // MARK: - Properties
    
    private let temperatureLabel: UILabel = UILabel()
    private let weatherStateImageView: UIImageView = UIImageView()
    private let weatherStateLabel: UILabel = UILabel()
    
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
        setupTemperatureLabel()
        setupWeatherStateImageView()
        setupWeatherStateLabel()
    }
    
    private func setupAutoLayout() {
        [temperatureLabel, weatherStateImageView, weatherStateLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        NSLayoutConstraint.activate([
            temperatureLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            temperatureLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12),
            temperatureLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18),
            weatherStateImageView.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 40),
            weatherStateImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            weatherStateImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            weatherStateImageView.heightAnchor.constraint(equalTo: weatherStateImageView.widthAnchor, multiplier: 0.66),
            weatherStateLabel.topAnchor.constraint(equalTo: weatherStateImageView.bottomAnchor, constant: 20),
            weatherStateLabel.leftAnchor.constraint(equalTo: temperatureLabel.leftAnchor),
            weatherStateLabel.rightAnchor.constraint(equalTo: temperatureLabel.rightAnchor),
            weatherStateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -70)
        ])
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
