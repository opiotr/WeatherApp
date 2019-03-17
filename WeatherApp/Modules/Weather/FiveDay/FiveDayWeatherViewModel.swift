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
    
    var sections: [OneDayWeatherSectionModel] = [] {
        didSet {
            onSectionsChange?()
        }
    }
    
    var onSectionsChange: (() -> Void)?
    
    // MARK: - Private properties
    
    private let weatherDataList: [WeatherDetailsDomain]
    
    // MARK: - Init
    
    init(weatherDataList: [WeatherDetailsDomain]) {
        self.weatherDataList = weatherDataList
    }
    
    // MARK: - Section building
    
    func buildSections() {
        let oneDayWeatherCellDataList = createOneDayWeatherCellDataList()
        let fiveDayWeatherSection = OneDayWeatherSectionModel(title: "fiveDayWeatherTitle".localized, cellDataList: oneDayWeatherCellDataList)
        sections = [fiveDayWeatherSection]
    }
    
    private func createOneDayWeatherCellDataList() -> [OneDayWeatherCellData] {
        let cellDataList = weatherDataList.map { weatherDetails -> OneDayWeatherCellData in
            let formattedTemperature = "\(weatherDetails.temperature)\u{2103}"
            let weatherStateIconUrl = createWeatherStateUrl(for: weatherDetails.weatherStateAbbreviation)
            let cellData = OneDayWeatherCellData(applicableDate: weatherDetails.applicableDate, temperature: formattedTemperature, weatherStateIconUrl: weatherStateIconUrl)
            return cellData
        }
        return cellDataList
    }
    
    // MARK: - Data formating
    
    private func createWeatherStateUrl(for weatherState: WeatherState) -> URL? {
        let path = String(format: Config.imageResourcePath, weatherState.rawValue)
        let url = URL(string: path)
        return url
    }
}
