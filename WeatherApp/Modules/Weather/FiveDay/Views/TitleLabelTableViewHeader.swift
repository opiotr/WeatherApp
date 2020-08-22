//
//  TitleLabelTableViewHeader.swift
//  WeatherApp
//
//  Created by Piotr Olech on 17/03/2019.
//  Copyright © 2019 Piotr Olech. All rights reserved.
//

import UIKit

class TitleLabelTableViewHeader: UIView {

    // MARK: - Private properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.clipsToBounds = true
        label.font = Font.helveticaNeueRegular(size: 26)
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        setupConstraints()
    }
    
    // MARK: - Setup
    
    private func setupConstraints() {
        let multiplier: CGFloat = 1
        addConstraints([
            NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: multiplier, constant: 25),
            NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: multiplier, constant: 25),
            NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: multiplier, constant: 12),
            NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: titleLabel, attribute: .trailing, multiplier: multiplier, constant: 12)
            ])
    }
    
    func setupTitleLabel(withTitle title: String) {
        titleLabel.text = title
    }
}
