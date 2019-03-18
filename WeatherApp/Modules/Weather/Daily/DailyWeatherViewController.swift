//
//  DailyWeatherViewController.swift
//  WeatherApp
//
//  Created by Piotr Olech on 16/03/2019.
//  Copyright © 2019 Piotr Olech. All rights reserved.
//

import UIKit

class DailyWeatherViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Public properties
    
    var viewModel: DailyWeatherViewModel!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLocationNameLabel()
        setupRefreshButton()
        setupTableView()
        bindViewToViewModel()
        viewModel.buildSections()
    }
    
    // MARK: - Setup
    
    private func setupLocationNameLabel() {
        locationNameLabel.font = Font.helveticaNeueRegular(size: 26)
        locationNameLabel.textAlignment = .center
        locationNameLabel.text = viewModel.locationName
    }
    
    private func setupRefreshButton() {
        refreshButton.imageView?.contentMode = .scaleAspectFit
        refreshButton.setImage(Assets.refreshImage, for: .normal)
        refreshButton.addTarget(self, action: #selector(refreshButtonTapped), for: .touchUpInside)
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: DailyWeatherMainTableViewCell.identifier, bundle: .main), forCellReuseIdentifier: DailyWeatherMainTableViewCell.identifier)
        tableView.register(UINib(nibName: DailyWeatherDetailsTableViewCell.identifier, bundle: .main), forCellReuseIdentifier: DailyWeatherDetailsTableViewCell.identifier)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func bindViewToViewModel() {
        viewModel.onSectionsChange = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    // MARK: - Actions
    
    @objc private func refreshButtonTapped() {
        viewModel.onRefreshData()
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource

extension DailyWeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sections[section].cellItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellItem = viewModel.sections[indexPath.section].cellItems[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellItem.identifier) as? BaseTableViewCell else {
            return UITableViewCell()
        }
        cell.setup(cellItem)
        return cell
    }
}
