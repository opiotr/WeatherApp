//
//  DailyWeatherDetailsTableViewCell.swift
//  WeatherApp
//
//  Created by Piotr Olech on 18/03/2019.
//  Copyright © 2019 Piotr Olech. All rights reserved.
//

import UIKit

final class DailyWeatherDetailsTableViewCell: BaseTableViewCell {

    // MARK: - Properties
    
    private let titleLabel: UILabel = UILabel()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupView() {
        setupAutoLayout()
        setupTitleLabel()
    }
    
    private func setupAutoLayout() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
    
    private func setupTitleLabel() {
        titleLabel.font = Font.helveticaNeueRegular(size: 18)
        titleLabel.textAlignment = .left
    }
    
    override func setup(_ item: CellItem) {
        super.setup(item)
        
        guard let data = item.data as? DailyWeatherDetailsCellData else { return }
        
        titleLabel.text = data.title
    }
}
