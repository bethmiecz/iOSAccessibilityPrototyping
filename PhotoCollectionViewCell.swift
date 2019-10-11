//
//  PhotoCollectionViewCell.swift
//  eam356_p5
//
//  Created by Beth Mieczkowski on 4/10/19.
//  Copyright © 2019 Beth Mieczkowski. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    var photoImageView: UIImageView!
    var name: UILabel!
    var cost: UILabel!
    
    // have to add a description to photos for voiceover
    var photoDescription: String = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let lightgray = UIColor.gray
        
        photoImageView = UIImageView(frame: .zero)
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.clipsToBounds = true
        photoImageView.layer.borderWidth = 1
        photoImageView.layer.borderColor = lightgray.cgColor
        contentView.addSubview(photoImageView)
        
        name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.backgroundColor = .white
        name.layer.borderWidth = 1
        name.layer.borderColor = lightgray.cgColor
        name.textColor = .black
        name.font = UIFont(name: "American Typewriter", size: 16)
        contentView.addSubview(name)
        
        cost = UILabel()
        cost.translatesAutoresizingMaskIntoConstraints = false
        cost.backgroundColor = .white
        cost.layer.borderWidth = 1
        cost.textColor = .red
        cost.layer.borderColor = lightgray.cgColor
        cost.font = UIFont(name: "American Typewriter", size: 12)
        contentView.addSubview(cost)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 70),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ]);
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 2),
            name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            name.heightAnchor.constraint(equalToConstant: 40),
            name.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40)
            ]);
        NSLayoutConstraint.activate([
            cost.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 2),
            cost.leadingAnchor.constraint(equalTo: name.trailingAnchor, constant: 5),
            cost.heightAnchor.constraint(equalToConstant: 40),
            cost.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ]);
    }
    
    func configure(for restaurant: RestaurantView) {
        photoImageView.image = UIImage(named: restaurant.restaurantImageName)
        name.text = restaurant.restaurantName
        cost.text = restaurant.restaurantPrice
        
        applyAccessibility(restaurant)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PhotoCollectionViewCell {
    func applyAccessibility(_ restaurant: RestaurantView) {
        
        // how to make images accessible for voiceover
        photoImageView.accessibilityTraits = UIAccessibilityTraits.image
        photoImageView.accessibilityLabel = restaurant.photoDescription
        
        // how to make the cost ($, $$, $$$) translate to something meaningful in voiceover
        cost.isAccessibilityElement = true
        cost.accessibilityTraits = UIAccessibilityTraits.none
        cost.accessibilityLabel = "Price Range"
        
        switch cost.text {
        case "    $":
            cost.accessibilityValue = "Inexpensive"
        case "   $$":
            cost.accessibilityValue = "Regular-Priced"
        case "  $$$":
            cost.accessibilityValue = "Expensive"
        default:
            cost.accessibilityValue = "Unknown"
        }
        
        // dynamic resizing for restaurant name
        name.font = UIFont.preferredFont(forTextStyle: .body)
        name.adjustsFontForContentSizeCategory = true
        
        // dynamic resizing for restaurant cost
        cost.font = UIFont.preferredFont(forTextStyle: .body)
        cost.adjustsFontForContentSizeCategory = true
    }
}


