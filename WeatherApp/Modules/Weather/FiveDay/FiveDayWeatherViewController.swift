//
//  FiveDayWeatherViewController.swift
//  WeatherApp
//
//  Created by Piotr Olech on 16/03/2019.
//  Copyright © 2019 Piotr Olech. All rights reserved.
//

import UIKit

class FiveDayWeatherViewController: UIViewController {
    
    // MARK: - Properties
    
    private let tableView: UITableView = UITableView()
    private let viewModel: FiveDayWeatherViewModel
    
    // MARK: - Init
    
    init(viewModel: FiveDayWeatherViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAutoLayout()
        setupTableView()
        setupBindings()
        viewModel.buildSections()
    }
    
    // MARK: - Setup
    
    private func setupAutoLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupTableView() {
        tableView.register(OneDayWeatherTableViewCell.self, forCellReuseIdentifier: OneDayWeatherTableViewCell.identifier)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = .zero
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 90
        tableView.sectionHeaderHeight = 70
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // MARK: - Data binding
    
    private func setupBindings() {
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
