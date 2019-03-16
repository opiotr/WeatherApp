//
//  FiveDayWeatherViewController.swift
//  WeatherApp
//
//  Created by Piotr Olech on 16/03/2019.
//  Copyright © 2019 Piotr Olech. All rights reserved.
//

import UIKit

class FiveDayWeatherViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Public properties
    
    var viewModel: FiveDayWeatherViewModel!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    // MARK: - Setup
    
    private func setupTableView() {
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource

extension FiveDayWeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.weatherDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
