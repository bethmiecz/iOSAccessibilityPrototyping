//
//  RestaurantView.swift
//  eam356_p5
//
//  Created by Beth Mieczkowski on 4/10/19.
//  Copyright © 2019 Beth Mieczkowski. All rights reserved.
//

import UIKit

class RestaurantView {
    
    var restaurantImageName: String
    var restaurantName: String
    var restaurantPrice: String
    var categories: [String]
    var displayed: Bool
    var photoDescription: String
    
    init(imageName: String, name: String, price: String, categories: [String], displayed: Bool, photoDescription: String) {
        self.restaurantImageName = imageName
        self.restaurantName = name
        self.restaurantPrice = price
        self.categories = categories
        self.displayed = displayed
        
        //NOTE: added for voiceover
        self.photoDescription = photoDescription
    }

}
