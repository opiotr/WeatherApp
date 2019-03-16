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
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.loadData()
    }
    
    // MARK: - Actions
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? UIPageViewController {
            pageViewController = controller
        }
    }
}
