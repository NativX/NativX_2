//
//  PopularCitiesCollectionViewCell.swift
//  NativX_2
//
//  Created by Sean Coleman on 7/25/16.
//  Copyright © 2016 Sean Coleman. All rights reserved.
//

import UIKit

class PopularCitiesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var featuredImageView: UIImageView!
    @IBOutlet weak var cityLabel : UILabel!
    
    
    
    var popularCities: PopularCities! {
        didSet{
            updateUI()
        }
    }
    
    private func updateUI () {
        cityLabel?.text! = popularCities.name
        featuredImageView?.image! = popularCities.featuredImage
    }
}
