//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Piotr Olech on 15/03/2019.
//  Copyright © 2019 Piotr Olech. All rights reserved.
//

import Foundation

class WeatherViewModel {
    
    // MARK: - Private properties
    
    private let dataFetcher: WeatherDataFetcher
    private let locationId: Int = 523920
    
    // MARK: - Init
    
    init(dataFetcher: WeatherDataFetcher) {
        self.dataFetcher = dataFetcher
    }
    
    // MARK: - Access methods
    
    func loadData() {
        dataFetcher.fetchWeatherData(for: locationId, success: { [unowned self] data in
            let domain = self.mapToLocalWeatherDomain(remote: data)
            print(domain)
            }, failure: { error in
                print(error)
        })
    }
    
    // MARK: - Data mapping
    
    private func mapToLocalWeatherDomain(remote: LocalWeatherRemote) -> LocalWeatherDomain {
        let consolidatedWeather = remote.consolidatedWeather.map {
            WeatherDetailsDomain(weatherStateName: $0.weatherStateName,
                                 weatherStateAbbreviation: $0.weatherStateAbbr,
                                 applicableDate: $0.applicableDate,
                                 temperature: $0.theTemp.roundToInt(),
                                 minTemperature: $0.minTemp.roundToInt(),
                                 maxTemperature: $0.maxTemp.roundToInt(),
                                 windSpeed: $0.windSpeed.roundToInt(),
                                 airPressure: $0.airPressure.roundToInt(),
                                 humidity: $0.humidity)
        }
        
        return LocalWeatherDomain(locationName: remote.title.uppercased(),
                                  consolidatedWeather: consolidatedWeather)
    }
}
