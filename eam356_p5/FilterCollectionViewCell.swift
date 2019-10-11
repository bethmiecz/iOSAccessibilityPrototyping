//
//  FilterCollectionViewCell.swift
//  eam356_p5
//
//  Created by Beth Mieczkowski on 4/10/19.
//  Copyright © 2019 Beth Mieczkowski. All rights reserved.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {

    var filterLabel: UILabel!
    var filterHeight: CGFloat = 20
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let lightgray = UIColor.gray
        filterLabel = UILabel()
        filterLabel.translatesAutoresizingMaskIntoConstraints = false
        filterLabel.textColor = .black
        filterLabel.backgroundColor = .white
        filterLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        filterLabel.textAlignment = .center
        filterLabel.layer.borderWidth = 1
        filterLabel.layer.borderColor = lightgray.cgColor
        filterLabel.layer.cornerRadius = filterHeight / 2
        filterLabel.clipsToBounds = true
        contentView.addSubview(filterLabel)
        
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            filterLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            filterLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            filterLabel.heightAnchor.constraint(equalToConstant: 50),
            filterLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
    }
    
    func configure(for filter: Filter) {
        filterLabel.text = filter.name
        if filter.isSelected {
            filterLabel.backgroundColor = .blue
        }
        else {
            filterLabel.backgroundColor = .white
        }
        
        applyAccessibility(filter)
        
    }
    
}

extension FilterCollectionViewCell {
    func applyAccessibility(_ filter: Filter) {
        
        //dynamic resizing for filter name
        filterLabel.font = UIFont.preferredFont(forTextStyle: .body)
        filterLabel.adjustsFontForContentSizeCategory = true
    }
}
