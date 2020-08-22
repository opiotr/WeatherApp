//
//  DependencyContainer.swift
//  WeatherApp
//
//  Created by Piotr Olech on 15/03/2019.
//  Copyright © 2019 Piotr Olech. All rights reserved.
//

import Swinject

final class DependencyContainer {
    static var container: Container = {
        let container = Container()
        
        // MARK: - View models
        
        container.register(WeatherPagerViewModel.self) { resolver in
            WeatherPagerViewModel(dataFetcher: resolver.resolve(WeatherDataFetcher.self)!)
        }
        container.register(DailyWeatherViewModel.self) { resolver, weatherDetails in
            DailyWeatherViewModel(weatherDetails: weatherDetails)
        }
        container.register(FiveDayWeatherViewModel.self) { resolver, weatherDataList in
            FiveDayWeatherViewModel(weatherDataList: weatherDataList)
        }
        
        // MARK: - Others
        
        container.register(WeatherPagerViewControllerFactory.self) { resolver in
            WeatherPagerViewControllerFactory()
        }
        container.register(WeatherDataFetcher.self) { resolver in
            WeatherDataFetcher(networkingService: resolver.resolve(HTTPClient.self)!)
        }
        container.register(HTTPClient.self) { _ in
            HTTPClient()
        }.inObjectScope(.container)
        
        return container
    }()
}
