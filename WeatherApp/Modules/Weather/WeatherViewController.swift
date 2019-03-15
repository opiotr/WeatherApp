//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Piotr Olech on 14/03/2019.
//  Copyright © 2019 Piotr Olech. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    // MARK: - Public properties
    
    var viewModel: WeatherViewModel!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.loadData()
    }
}
