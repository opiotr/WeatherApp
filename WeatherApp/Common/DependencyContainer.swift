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
        container.storyboardInitCompleted(WeatherViewController.self) { resolver, controller in
            controller.viewModel = resolver.resolve(WeatherViewModel.self)
        }
        container.register(WeatherViewModel.self) { resolver in
            WeatherViewModel(dataFetcher: resolver.resolve(WeatherDataFetcher.self)!)
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
