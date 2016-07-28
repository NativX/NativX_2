//
//  PopularCities.swift
//  NativX_2
//
//  Created by Sean Coleman on 7/25/16.
//  Copyright © 2016 Sean Coleman. All rights reserved.
//

import Foundation
import UIKit

class PopularCities {
    var name = ""
    var featuredImage: UIImage!
    
    init (name: String, featuredImage: UIImage!) {
        self.name = name
        self.featuredImage = featuredImage
    }
    
    static func createCities () -> [PopularCities] {
        return [
            PopularCities(name: "Denver", featuredImage: UIImage(named: "denver")!),
            PopularCities(name: "Austin", featuredImage: UIImage(named: "austin")!),
            PopularCities(name: "London", featuredImage: UIImage(named: "london")!),
            PopularCities(name: "Boston", featuredImage: UIImage(named: "boston")!),
        ]
    }
}