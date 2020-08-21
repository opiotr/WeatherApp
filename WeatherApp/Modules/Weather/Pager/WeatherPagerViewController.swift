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
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.color = .gray
        activityIndicator.frame = view.bounds
        view.addSubview(activityIndicator)
        return activityIndicator
    }()
    
    private lazy var emptyDataView: EmptyDataView = {
        let customView = EmptyDataView(frame: view.bounds)
        customView.setupActionButton(image: Assets.refreshImage, action: refreshData)
        customView.isHidden = true
        view.addSubview(customView)
        return customView
    }()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupPageControl()
        setupBindings()
        activityIndicator.startAnimating()
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
    
    private func setupBindings() {
        viewModel.onLoadDataSuccess = { [weak self] data in
            self?.activityIndicator.stopAnimating()
            self?.hideEmptyDataView()
            self?.setupPagerViewControllers(with: data)
            self?.setFirstPage()
        }
        
        viewModel.onLoadDataError = { [weak self] error in
            self?.activityIndicator.stopAnimating()
            self?.showEmptyDataView(withTitle: error.localizedDescription)
        }
    }
    
    // MARK: - Actions
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? UIPageViewController {
            pageViewController = controller
            pageViewController.dataSource = self
        }
    }
    
    private func refreshData() {
        hideEmptyDataView()
        activityIndicator.startAnimating()
        viewModel.loadData()
    }
    
    private func showEmptyDataView(withTitle title: String) {
        emptyDataView.setupTitle(with: title)
        emptyDataView.isHidden = false
    }
    
    private func hideEmptyDataView() {
        emptyDataView.isHidden = true
    }
    
    // MARK: - Pager setup
    
    private func setupPagerViewControllers(with data: LocalWeatherDomain) {
        let dailyWeatherController = controllerFactory.makeDailyWeatherViewController(for: data.locationName, with: data.currentDayWeather, refreshDataAction: refreshData)
        let fiveDayWeatherController = controllerFactory.makeFiveDayWeatherViewController(with: data.fiveDayWeather)
        viewControllers = [dailyWeatherController, fiveDayWeatherController]
    }
    
    private func setFirstPage() {
        guard let controller = viewControllers.first else { return }
        pageViewController.setViewControllers([controller], direction: .forward, animated: false, completion: nil)
    }
}

// MARK: - UIPageViewControllerDataSource

extension WeatherPagerViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = viewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0, viewControllers.count > previousIndex else {
             return nil
        }
        
        return viewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = viewControllers.firstIndex(of: viewController) else {
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
            let firstViewControllerIndex = viewControllers.firstIndex(of: firstViewController) else {
                return 0
        }
        
        return firstViewControllerIndex
    }
}
