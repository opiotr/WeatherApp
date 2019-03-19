//
//  WeatherPagerViewModel.swift
//  WeatherApp
//
//  Created by Piotr Olech on 15/03/2019.
//  Copyright © 2019 Piotr Olech. All rights reserved.
//

import Foundation

class WeatherPagerViewModel {
    
    // MARK: - Public properties
    
    var onLoadDataSuccess: ((LocalWeatherDomain) -> Void)?
    var onLoadDataError: ((NSError) -> Void)?
    
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
            do {
                let domain = try self.prepareDataForView(from: data)
                self.onLoadDataSuccess?(domain)
            } catch {
                self.onLoadDataError?(error as NSError)
            }
        }, failure: { [unowned self] error in
            self.onLoadDataError?(error as NSError)
        })
    }
    
    // MARK: - Data mapping
    
    private func prepareDataForView(from remoteObject: LocalWeatherRemote) throws -> LocalWeatherDomain {
        let domain = try createLocalWeatherDomain(remoteObject: remoteObject)
        return domain
    }
    
    private func createLocalWeatherDomain(remoteObject: LocalWeatherRemote) throws -> LocalWeatherDomain {
        let consolidatedWeather = remoteObject.consolidatedWeather
            .sorted(by: { $0.applicableDate < $1.applicableDate })
            .map { createWeatherDetailsDomain(from: $0) }
        
        guard let currentDayWeather = consolidatedWeather.first else {
            throw NSError(domain: "insufficientDataError", code: -1, userInfo: nil)
        }
        let fiveDayWeather = Array(consolidatedWeather.dropFirst())
        
        return LocalWeatherDomain(locationName: remoteObject.title.uppercased(),
                                  currentDayWeather: currentDayWeather,
                                  fiveDayWeather: fiveDayWeather)
    }
    
    private func createWeatherDetailsDomain(from remoteObject: WeatherDetailsRemote) -> WeatherDetailsDomain {
        let formattedApplicableDate = remoteObject.applicableDate
            .toDate(withFormat: "yyyy-MM-dd")?
            .toString(withFormat: "EEEE\nMMM d") ?? ""
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
