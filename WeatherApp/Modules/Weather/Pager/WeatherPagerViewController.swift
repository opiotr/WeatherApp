//
//  WeatherPagerViewController.swift
//  WeatherApp
//
//  Created by Piotr Olech on 14/03/2019.
//  Copyright © 2019 Piotr Olech. All rights reserved.
//

import UIKit

final class WeatherPagerViewController: UIViewController {

    // MARK: - Private properties
    
    private let controllerFactory: WeatherPagerViewControllerFactory
    private let viewModel: WeatherPagerViewModel
    private let containerView: UIView = UIView()
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
    
    // MARK: - Init
    
    init(viewModel: WeatherPagerViewModel, controllerFactory: WeatherPagerViewControllerFactory) {
        self.viewModel = viewModel
        self.controllerFactory = controllerFactory
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        edgesForExtendedLayout = []
        view.backgroundColor = .white
        
        setupAutoLayout()
        setupPageController()
        setupPageControl()
        setupRefreshButton()
        setupBindings()
        activityIndicator.startAnimating()
        viewModel.loadData()
    }
    
    // MARK: - Setup
    
    private func setupAutoLayout() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            containerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            containerView.topAnchor.constraint(equalTo: view.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupPageController() {
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.dataSource = self
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        addChild(pageViewController)
        containerView.addSubview(pageViewController.view)
        NSLayoutConstraint.activate([
            pageViewController.view.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            pageViewController.view.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            pageViewController.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        pageViewController.didMove(toParent: self)
    }
    
    private func setupPageControl() {
        let pageControl = UIPageControl.appearance(whenContainedInInstancesOf: [type(of: self)])
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .gray
        pageControl.backgroundColor = .clear
    }
    
    private func setupRefreshButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: Assets.refreshImage,
            style: .plain,
            target: self,
            action: #selector(refreshData)
        )
    }
    
    // MARK: - Data binding
    
    private func setupBindings() {
        viewModel.onLoadDataSuccess = { [weak self] data in
            self?.activityIndicator.stopAnimating()
            self?.hideEmptyDataView()
            self?.title = data.locationName
            self?.setupPagerViewControllers(with: data)
            self?.setFirstPage()
        }
        
        viewModel.onLoadDataError = { [weak self] error in
            self?.activityIndicator.stopAnimating()
            self?.showEmptyDataView(withTitle: error.localizedDescription)
        }
    }
    
    // MARK: - Actions
    
    @objc private func refreshData() {
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
        let dailyWeatherController = controllerFactory.makeDailyWeatherViewController(with: data.currentDayWeather)
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
