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
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = .zero
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 90
        tableView.sectionHeaderHeight = 70
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = TitleLabelTableViewHeader()
        let title = viewModel.sections[section].title
        view.setupTitleLabel(withTitle: title)
        return view
    }
}
