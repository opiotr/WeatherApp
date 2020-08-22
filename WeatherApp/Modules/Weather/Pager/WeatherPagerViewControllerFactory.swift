//
//  WeatherPagerViewControllerFactory.swift
//  WeatherApp
//
//  Created by Piotr Olech on 16/03/2019.
//  Copyright © 2019 Piotr Olech. All rights reserved.
//

import UIKit

class WeatherPagerViewControllerFactory {
    
    // MARK: - Factory methods
    
    func makeDailyWeatherViewController(with data: WeatherDetailsDomain) -> UIViewController {
        let viewModel = DependencyContainer.container.resolve(DailyWeatherViewModel.self, argument: data)!
        let controller = DailyWeatherViewController(viewModel: viewModel)
        return controller
    }
    
    func makeFiveDayWeatherViewController(with weatherDataList: [WeatherDetailsDomain]) -> UIViewController {
        let viewModel = DependencyContainer.container.resolve(FiveDayWeatherViewModel.self, argument: weatherDataList)!
        let controller = FiveDayWeatherViewController(viewModel: viewModel)
        return controller
    }
}
