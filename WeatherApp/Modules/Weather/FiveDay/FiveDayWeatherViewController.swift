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
        
        bindViewToViewModel()
        setupTableView()
        viewModel.buildSections()
    }
    
    // MARK: - Setup
    
    private func setupTableView() {
        tableView.register(UINib(nibName: String(describing: OneDayWeatherTableViewCell.self), bundle: .main), forCellReuseIdentifier: String(describing: OneDayWeatherTableViewCell.self))
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.rowHeight = 90
        tableView.sectionHeaderHeight = 80
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func bindViewToViewModel() {
        viewModel.onSectionsChange = { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource

extension FiveDayWeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sections[section].cellDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: OneDayWeatherTableViewCell.self)) as? OneDayWeatherTableViewCell else {
            return UITableViewCell()
        }
        let data = viewModel.sections[indexPath.section].cellDataList[indexPath.row]
        cell.setup(with: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = TitleLabelTableViewHeader()
        let title = viewModel.sections[section].title
        view.setupTitleLabel(withTitle: title)
        return view
    }
}
