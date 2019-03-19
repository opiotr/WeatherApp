//
//  EmptyDataView.swift
//  WeatherApp
//
//  Created by Piotr Olech on 19/03/2019.
//  Copyright © 2019 Piotr Olech. All rights reserved.
//

import UIKit

class EmptyDataView: UIView {
    
    // MARK: - Private properties
    
    private var onActionButton: (() -> Void)?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = Font.helveticaNeueRegular(size: 17)
        addSubview(label)
        return label
    }()
    
    private lazy var actionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(actionButtonClicked), for: .touchUpInside)
        addSubview(button)
        return button
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
        setupTitleLabelConstraints()
        setupActionButtonConstraints()
    }
    
    // MARK: - Setup
    
    private func setupTitleLabelConstraints() {
        let multiplier: CGFloat = 1
        
        addConstraints([
            NSLayoutConstraint(item: titleLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: multiplier, constant: 0),
            NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: titleLabel, attribute: .centerY, multiplier: multiplier, constant: 0),
            NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: multiplier, constant: 12),
            NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: titleLabel, attribute: .trailing, multiplier: multiplier, constant: 12),
            ])
    }
    
    private func setupActionButtonConstraints() {
        let multiplier: CGFloat = 1
        
        addConstraints([
            NSLayoutConstraint(item: actionButton, attribute: .centerX, relatedBy: .equal, toItem: titleLabel, attribute: .centerX, multiplier: multiplier, constant: 0),
            NSLayoutConstraint(item: actionButton, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .top, multiplier: multiplier, constant: 30),
            NSLayoutConstraint(item: actionButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: multiplier, constant: 30),
            NSLayoutConstraint(item: actionButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: multiplier, constant: 30)
            ])
    }
    
    // MARK: - Actions
    
    @objc private func actionButtonClicked() {
        onActionButton?()
    }
    
    func setupTitle(with text: String) {
        titleLabel.text = text
    }
    
    func setupActionButton(image: UIImage?, action: (() -> Void)?) {
        actionButton.setImage(image, for: .normal)
        onActionButton = action
    }
}
