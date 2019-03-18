//
//  DailyWeatherViewModel.swift
//  WeatherApp
//
//  Created by Piotr Olech on 16/03/2019.
//  Copyright © 2019 Piotr Olech. All rights reserved.
//

import Foundation

class DailyWeatherViewModel {
    
    // MARK: - Public properties
    
    let locationName: String
    let onRefreshData: () -> Void
    var onSectionsChange: (() -> Void)?

    // MARK: - Private properties
    
    private(set) var sections: [SectionModel] = [] {
        didSet {
            onSectionsChange?()
        }
    }
    private let weatherDetails: WeatherDetailsDomain
    
    // MARK: - Init
    
    init(locationName: String, weatherDetails: WeatherDetailsDomain, refreshDataAction: @escaping () -> Void) {
        self.locationName = locationName.uppercased()
        self.weatherDetails = weatherDetails
        self.onRefreshData = refreshDataAction
    }
    
    // MARK: - Section building
    
    func buildSections() {
        let cellItems = [CellItem(identifier: DailyWeatherMainTableViewCell.identifier, data: createDailyWeatherMainCellData(with: weatherDetails))]
        let mainOneDayWeatherSection = SectionModel(title: "", cellItems: cellItems)
        sections = [mainOneDayWeatherSection]
    }
    
    private func createDailyWeatherMainCellData(with weatherDetails: WeatherDetailsDomain) -> DailyWeatherMainCellData {
        let formattedTemperature = weatherDetails.temperature.formatToCelsiusTemperatureString()
        let weatherStateIconUrl = createWeatherStateUrl(for: weatherDetails.weatherStateAbbreviation)
        let cellData = DailyWeatherMainCellData(temperature: formattedTemperature, weatherStateIconUrl: weatherStateIconUrl, weatherStateName: weatherDetails.weatherStateName)
        return cellData
    }
    
    // MARK: - Data formating
    
    private func createWeatherStateUrl(for weatherState: WeatherState) -> URL? {
        let path = String(format: Config.imageResourcePath, weatherState.rawValue)
        let url = URL(string: path)
        return url
    }
}
