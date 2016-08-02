//
//  InterestsCollectionViewCell.swift
//  NativX_2
//
//  Created by Sean Coleman on 7/28/16.
//  Copyright © 2016 Sean Coleman. All rights reserved.
//

import UIKit

class InterestsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImage: UIButton!
    
    @IBOutlet weak var iconName: UILabel!
    
    var counter: Int = 1
    
    var interests: Interests! {
        didSet{
            updateUI()
        }
    }
    
    func updateUI () {
        iconName?.text! = interests.name
        iconImage?.setImage(interests.iconImage!, forState: UIControlState.Normal)
        
        // Rounded Profile Picture
        iconImage?.layer.borderWidth = 1
        iconImage?.layer.masksToBounds = false
        iconImage?.layer.borderColor = nativxColor.CGColor
        iconImage?.layer.cornerRadius = iconImage.frame.height/2
        iconImage?.clipsToBounds = true
    }
    @IBAction func interestButtonClicked(sender: AnyObject) {
        
        counter = (counter + 1) % 2
        
        if counter == 0 {
            iconImage.backgroundColor = nativxColor
        }
        else {
            iconImage.backgroundColor = UIColor.clearColor()
        }
    }
}
