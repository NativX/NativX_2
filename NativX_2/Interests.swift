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
    static func createEatInterests () -> [Interests] {
        return [
            Interests(name: "Omnivore", iconImage: UIImage(named: "Foodie")!),
            Interests(name: "Herbivore", iconImage: UIImage(named: "herbivore")!),
            Interests(name: "Carnivore", iconImage: UIImage(named: "Carnivore")!),
        ]
    }
    
    // PLAY
    static func createPlayInterests () -> [Interests] {
        return [
            Interests(name: "Foodie", iconImage: UIImage(named: "Foodie")!),
            Interests(name: "Water Bug", iconImage: UIImage(named: "Water Bug")!),
            Interests(name: "Outdoorsy", iconImage: UIImage(named: "Outdoorsy")!),
            Interests(name: "Artsy", iconImage: UIImage(named: "Artsy")!),
            Interests(name: "Thrill Seeker", iconImage: UIImage(named: "Thrill Seeker")!),
            Interests(name: "Brew Master", iconImage: UIImage(named: "Brew Master")!),
            Interests(name: "Win-O", iconImage: UIImage(named: "Win-O")!),
            Interests(name: "Sporty", iconImage: UIImage(named: "Sporty1")!),
            Interests(name: "Social Butterfly", iconImage: UIImage(named: "Social Butterfly")!),
            Interests(name: "Shop-o-holic", iconImage: UIImage(named: "Shop-o-holic")!),
        ]
    }
    // STAY
    static func createStayInterests () -> [Interests] {
        return [
            Interests(name: "City Slicker", iconImage: UIImage(named: "City Slicker")!),
            Interests(name: "Rural", iconImage: UIImage(named: "rural")!),
            Interests(name: "Suburban", iconImage: UIImage(named: "suburban")!),
        ]
    }
}

