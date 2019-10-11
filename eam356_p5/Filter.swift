//
//  Filter.swift
//  eam356_p5
//
//  Created by Beth Mieczkowski on 4/11/19.
//  Copyright © 2019 Beth Mieczkowski. All rights reserved.
//

import UIKit

class Filter {
    
    var name: String 
    var color: UIColor
    var isSelected: Bool

    init(name: String, color: UIColor, isSelected: Bool) {
        self.name = name
        self.color = color
        self.isSelected = isSelected
    }
    
}
