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
        let mainSection = createMainDailyWeatherSection()
        let detailsSection = createDailyWeatherDetailsSection()
        sections = [mainSection, detailsSection]
    }
    
    private func createMainDailyWeatherSection() -> SectionModel {
        let cellData = createDailyWeatherMainCellData(with: weatherDetails)
        let cellItem = CellItem(identifier: DailyWeatherMainTableViewCell.identifier, data: cellData)
        let section = SectionModel(title: "", cellItems: [cellItem])
        return section
    }
    
    private func createDailyWeatherMainCellData(with weatherDetails: WeatherDetailsDomain) -> DailyWeatherMainCellData {
        let formattedTemperature = weatherDetails.temperature.formatToCelsiusTemperatureString()
        let weatherStateIconUrl = createWeatherStateUrl(for: weatherDetails.weatherStateAbbreviation)
        let cellData = DailyWeatherMainCellData(temperature: formattedTemperature, weatherStateIconUrl: weatherStateIconUrl, weatherStateName: weatherDetails.weatherStateName)
        return cellData
    }
    
    private func createDailyWeatherDetailsSection() -> SectionModel {
        let cellItems = createDailyWeatherDetailsCellItems()
        let section = SectionModel(title: "", cellItems: cellItems)
        return section
    }
    
    private func createDailyWeatherDetailsCellItems() -> [CellItem] {
        let orderedCellDataList = createOrderedDailyWeatherDetailsCellDataList()
        let cellItems = orderedCellDataList.map {
            CellItem(identifier: DailyWeatherDetailsTableViewCell.identifier, data: $0)
        }
        return cellItems
    }
    
    private func createOrderedDailyWeatherDetailsCellDataList() -> [DailyWeatherDetailsCellData] {
        let humidityCellData = DailyWeatherDetailsCellData(title: String(format: "weatherHumidity".localized, weatherDetails.humidity))
        let minTempCellData = DailyWeatherDetailsCellData(title: String(format: "weatherMinTemp".localized, weatherDetails.minTemperature.formatToCelsiusTemperatureString()))
        let maxTempCellData = DailyWeatherDetailsCellData(title: String(format: "weatherMaxTemp".localized, weatherDetails.maxTemperature.formatToCelsiusTemperatureString()))
        let windSpeedCellData = DailyWeatherDetailsCellData(title: String(format: "weatherWindSpeed".localized, weatherDetails.windSpeed))
        let airPressureCellData = DailyWeatherDetailsCellData(title: String(format: "weatherAirPressure".localized, weatherDetails.airPressure))
        
        return [humidityCellData, minTempCellData, maxTempCellData, windSpeedCellData, airPressureCellData]
    }
    
    // MARK: - Data formating
    
    private func createWeatherStateUrl(for weatherState: WeatherState) -> URL? {
        let path = String(format: Config.imageResourcePath, weatherState.rawValue)
        let url = URL(string: path)
        return url
    }
}
