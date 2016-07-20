//
//  ViewHelper.swift
//  NativX_2
//
//  Created by Sean Coleman on 7/20/16.
//  Copyright © 2016 Sean Coleman. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func addBackground(background : String) {
        // screen width and height:
        let width = UIScreen.mainScreen().bounds.size.width
        let height = UIScreen.mainScreen().bounds.size.height
        
        let imageViewBackground = UIImageView(frame: CGRectMake(0, 0, width, height))
        imageViewBackground.image = UIImage(named: background)
        
        // you can change the content mode:
        imageViewBackground.contentMode = UIViewContentMode.ScaleAspectFill
        
        self.addSubview(imageViewBackground)
        self.sendSubviewToBack(imageViewBackground)
    }
}