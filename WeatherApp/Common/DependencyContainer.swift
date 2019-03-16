//
//  DependencyContainer.swift
//  WeatherApp
//
//  Created by Piotr Olech on 15/03/2019.
//  Copyright © 2019 Piotr Olech. All rights reserved.
//

import Swinject
import SwinjectStoryboard

final class DependencyContainer {
    static var container: Container = {
        let container = Container()
        
        // MARK: - Controllers
        
        container.storyboardInitCompleted(WeatherPagerViewController.self) { resolver, controller in
            controller.viewModel = resolver.resolve(WeatherPagerViewModel.self)
            controller.controllerFactory = resolver.resolve(WeatherPagerViewControllerFactory.self)
        }
        container.storyboardInitCompleted(DailyWeatherViewController.self) { _, _ in }
        container.storyboardInitCompleted(FiveDayWeatherViewController.self) { _, _ in }
        container.storyboardInitCompleted(UIPageViewController.self) { _, _ in }
        
        // MARK: - View models
        
        container.register(WeatherPagerViewModel.self) { resolver in
            WeatherPagerViewModel(dataFetcher: resolver.resolve(WeatherDataFetcher.self)!)
        }
        container.register(DailyWeatherViewModel.self) { resolver, locationName, weatherDetails in
            DailyWeatherViewModel(locationName: locationName, weatherDetails: weatherDetails)
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
