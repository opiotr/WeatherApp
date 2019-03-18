//
//  FiveDayWeatherViewModel.swift
//  WeatherApp
//
//  Created by Piotr Olech on 16/03/2019.
//  Copyright © 2019 Piotr Olech. All rights reserved.
//

import Foundation

class FiveDayWeatherViewModel {
    
    // MARK: - Public properties
    
    var onSectionsChange: (() -> Void)?
    
    // MARK: - Private properties
    
    private(set) var sections: [SectionModel] = [] {
        didSet {
            onSectionsChange?()
        }
    }
    private let weatherDataList: [WeatherDetailsDomain]
    
    // MARK: - Init
    
    init(weatherDataList: [WeatherDetailsDomain]) {
        self.weatherDataList = weatherDataList
    }
    
    // MARK: - Section building
    
    func buildSections() {
        let cellItems = createOneDayWeatherCellItems()
        let fiveDayWeatherSection = SectionModel(title: "fiveDayWeatherTitle".localized, cellItems: cellItems)
        sections = [fiveDayWeatherSection]
    }
    
    private func createOneDayWeatherCellItems() -> [CellItem] {
        let cellDataList = weatherDataList.map {
            createOneDayWeatherCellData(with: $0)
        }
        let cellItems = cellDataList.map {
            CellItem(identifier: OneDayWeatherTableViewCell.identifier, data: $0)
        }
        
        return cellItems
    }
    
    private func createOneDayWeatherCellData(with weatherDetails: WeatherDetailsDomain) -> OneDayWeatherCellData {
        let formattedTemperature = weatherDetails.temperature.formatToCelsiusTemperatureString()
        let weatherStateIconUrl = createWeatherStateUrl(for: weatherDetails.weatherStateAbbreviation)
        let cellData = OneDayWeatherCellData(applicableDate: weatherDetails.applicableDate, temperature: formattedTemperature, weatherStateIconUrl: weatherStateIconUrl)
        return cellData
    }
    
    // MARK: - Data formating
    
    private func createWeatherStateUrl(for weatherState: WeatherState) -> URL? {
        let path = String(format: Config.imageResourcePath, weatherState.rawValue)
        let url = URL(string: path)
        return url
    }
}
