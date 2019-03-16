//
//  WeatherPagerViewControllerFactory.swift
//  WeatherApp
//
//  Created by Piotr Olech on 16/03/2019.
//  Copyright © 2019 Piotr Olech. All rights reserved.
//

import SwinjectStoryboard

class WeatherPagerViewControllerFactory {
    
    // MARK: - Storyboard
    
    private let storyboard = SwinjectStoryboard.create(name: "Main", bundle: nil, container: DependencyContainer.container)
    
    // MARK: - Controller identifiers
    
    private let dailyWeatherViewControllerIdentifier = String(describing: DailyWeatherViewController.self)
    private let fiveDayWeatherViewControllerIdentifier = String(describing: FiveDayWeatherViewController.self)
    
    // MARK: - Factory methods
    
    func makeDailyWeatherViewController(for locationName: String, with data: WeatherDetailsDomain) -> UIViewController {
        guard let controller = storyboard.instantiateViewController(withIdentifier: dailyWeatherViewControllerIdentifier) as? DailyWeatherViewController else {
            fatalError("Couldn't instantinate controller with identifier \(dailyWeatherViewControllerIdentifier)")
        }
        
        controller.viewModel = DependencyContainer.container.resolve(DailyWeatherViewModel.self, arguments: locationName, data)
        return controller
    }
    
    func makeFiveDayWeatherViewController(with data: [WeatherDetailsDomain]) -> UIViewController {
        guard let controller = storyboard.instantiateViewController(withIdentifier: fiveDayWeatherViewControllerIdentifier) as? FiveDayWeatherViewController else {
            fatalError("Couldn't instantinate controller with identifier \(fiveDayWeatherViewControllerIdentifier)")
        }
        
        controller.viewModel = DependencyContainer.container.resolve(FiveDayWeatherViewModel.self,
                                                                     argument: data)
        return controller
    }
}
