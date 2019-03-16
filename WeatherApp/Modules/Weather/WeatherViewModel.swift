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
    private var weatherData: LocalWeatherDomain?
    
    // MARK: - Init
    
    init(dataFetcher: WeatherDataFetcher) {
        self.dataFetcher = dataFetcher
    }
    
    // MARK: - Access methods
    
    func loadData() {
        dataFetcher.fetchWeatherData(for: locationId, success: { [unowned self] data in
            self.prepareDataForView(from: data)
            print(self.weatherData)
        }, failure: { error in
            print(error)
        })
    }
    
    // MARK: - Data mapping
    
    private func prepareDataForView(from remoteObject: LocalWeatherRemote) {
        let domain = createLocalWeatherDomain(remoteObject: remoteObject)
        weatherData = domain
    }
    
    private func createLocalWeatherDomain(remoteObject: LocalWeatherRemote) -> LocalWeatherDomain {
        let consolidatedWeather = remoteObject.consolidatedWeather
            .sorted(by: { $0.applicableDate < $1.applicableDate })
            .map { createWeatherDetailsDomain(from: $0) }
        
        let currentDayWeather = consolidatedWeather.first! // TODO: Handle force unwrap
        let nextFiveDaysWeather = Array(consolidatedWeather.dropFirst())
        
        return LocalWeatherDomain(locationName: remoteObject.title.uppercased(),
                                  currentDayWeather: currentDayWeather,
                                  nextFiveDaysWeather: nextFiveDaysWeather)
    }
    
    private func createWeatherDetailsDomain(from remoteObject: WeatherDetailsRemote) -> WeatherDetailsDomain {
        let formattedApplicableDate = remoteObject.applicableDate
            .toDate(withFormat: "yyyy-mm-dd")?
            .toString(withFormat: "dd.mm") ?? ""
        
        return WeatherDetailsDomain(weatherStateName: remoteObject.weatherStateName,
                                    weatherStateAbbreviation: remoteObject.weatherStateAbbr,
                                    applicableDate: formattedApplicableDate,
                                    temperature: remoteObject.theTemp.roundToInt(),
                                    minTemperature: remoteObject.minTemp.roundToInt(),
                                    maxTemperature: remoteObject.maxTemp.roundToInt(),
                                    windSpeed: remoteObject.windSpeed.roundToInt(),
                                    airPressure: remoteObject.airPressure.roundToInt(),
                                    humidity: remoteObject.humidity)
    }
}
