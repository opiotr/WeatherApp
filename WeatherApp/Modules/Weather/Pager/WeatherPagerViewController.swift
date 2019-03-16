//
//  WeatherPagerViewController.swift
//  WeatherApp
//
//  Created by Piotr Olech on 14/03/2019.
//  Copyright © 2019 Piotr Olech. All rights reserved.
//

import UIKit

class WeatherPagerViewController: UIViewController {
    
    // MARK: - Public properties
    
    var controllerFactory: WeatherPagerViewControllerFactory!
    var viewModel: WeatherPagerViewModel!
    
    // MARK: - Private properties
    
    private var pageViewController: UIPageViewController!
    private var viewControllers: [UIViewController] = []
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupPageControl()
        bindViewToViewModel()
        viewModel.loadData()
    }
    
    // MARK: - Setup
    
    private func setupPageControl() {
        let pageControl = UIPageControl.appearance(whenContainedInInstancesOf: [type(of: self)])
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .gray
        pageControl.backgroundColor = .clear
    }
    
    // MARK: - Data binding
    
    private func bindViewToViewModel() {
        viewModel.onLoadDataSuccess = { [weak self] data in
            self?.setupPagerViewControllers(with: data)
            self?.setFirstPage()
        }
        
        viewModel.onLoadDataError = { [weak self] error in
            self?.presentAlert(with: error.localizedDescription)
        }
    }
    
    // MARK: - Actions
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? UIPageViewController {
            pageViewController = controller
            pageViewController.dataSource = self
        }
    }
    
    private func setupPagerViewControllers(with data: LocalWeatherDomain) {
        let dailyWeatherController = controllerFactory.makeDailyWeatherViewController(for: data.locationName, with: data.currentDayWeather)
        let fiveDayWeatherController = controllerFactory.makeFiveDayWeatherViewController(with: data.fiveDayWeather)
        viewControllers = [dailyWeatherController, fiveDayWeatherController]
    }
    
    private func setFirstPage() {
        guard let controller = viewControllers.first else { return }
        pageViewController.setViewControllers([controller], direction: .forward, animated: true, completion: nil)
    }
    
    private func presentAlert(with message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertController, animated: true)
    }
}

// MARK: - UIPageViewControllerDataSource

extension WeatherPagerViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = viewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0, viewControllers.count > previousIndex else {
             return nil
        }
        
        return viewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = viewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        guard viewControllers.count != nextIndex, viewControllers.count > nextIndex else {
             return nil
        }
        
        return viewControllers[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return viewControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers.first,
            let firstViewControllerIndex = viewControllers.index(of: firstViewController) else {
                return 0
        }
        
        return firstViewControllerIndex
    }
}