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
    
    init(dataFetcher: WeatherDataFetcher = WeatherDataFetcher()) {
        self.dataFetcher = dataFetcher
    }
    
    // MARK: - Access methods
    
    func loadData() {
        dataFetcher.fetchWeatherData(for: locationId, success: { [weak self] data in
            print(data)
            }, failure: { error in
                print(error)
        })
    }
}
