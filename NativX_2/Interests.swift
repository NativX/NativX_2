//
//  Interests.swift
//  NativX_2
//
//  Created by Sean Coleman on 7/28/16.
//  Copyright © 2016 Sean Coleman. All rights reserved.
//

import Foundation
import UIKit

class Interests {
    var name = ""

    var iconImage: UIImage!
    
    init (name: String, iconImage: UIImage!) {
        self.name = name
        self.iconImage = iconImage
    }
    
    // EAT
    func createEatInterests () -> [Interests] {
        return [
            Interests(name: "Foodie", iconImage: UIImage(named: "denver")!),
            Interests(name: "Water Bug", iconImage: UIImage(named: "austin")!),
            Interests(name: "Outdoors", iconImage: UIImage(named: "london")!),
        ]
    }
    
    // PLAY
    static func createPlayInterests () -> [Interests] {
        return [
            Interests(name: "Foodie", iconImage: UIImage(named: "CitySlickerIcon")!),
            Interests(name: "Water Bug", iconImage: UIImage(named: "beachIcon2")!),
            Interests(name: "Outdoors", iconImage: UIImage(named: "mountainIcon")!),
            Interests(name: "Artsy", iconImage: UIImage(named: "ArtsyIcon")!),
            Interests(name: "Thrill Seeker", iconImage: UIImage(named: "thrillSeekerIcon")!),
            Interests(name: "Brew Master", iconImage: UIImage(named: "MapIconLogo")!),
            Interests(name: "Win-O", iconImage: UIImage(named: "suburbanIcon")!),
            Interests(name: "Sporty", iconImage: UIImage(named: "beachIcon2")!),
            Interests(name: "Social Butterfly", iconImage: UIImage(named: "socialButterflyIcon1")!),
            Interests(name: "Shop-o-holic", iconImage: UIImage(named: "shopoholic1")!),
        ]
    }
    // STAY
    static func createStayInterests () -> [Interests] {
        return [
            Interests(name: "Denver", iconImage: UIImage(named: "denver")!),
            Interests(name: "Austin", iconImage: UIImage(named: "austin")!),
            Interests(name: "London", iconImage: UIImage(named: "london")!),
            Interests(name: "Boston", iconImage: UIImage(named: "boston")!),
        ]
    }
}

