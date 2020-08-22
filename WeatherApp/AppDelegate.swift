//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Piotr Olech on 14/03/2019.
//  Copyright © 2019 Piotr Olech. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupWindow()
        setupNavigationBar()
        return true
    }
    
    private func setupWindow() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        self.window = window
        
        let controller = WeatherPagerViewController(
            viewModel: DependencyContainer.container.resolve(WeatherPagerViewModel.self)!,
            controllerFactory: DependencyContainer.container.resolve(WeatherPagerViewControllerFactory.self)!
        )
        window.rootViewController = UINavigationController(rootViewController: controller)
    }
    
    private func setupNavigationBar() {
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().tintColor = .black
        UINavigationBar.appearance().backgroundColor = .white
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.black]
        UINavigationBar.appearance().isTranslucent = false
    }
}

