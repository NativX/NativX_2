//
//  ViewHelper.swift
//  NativX_2
//
//  Created by Sean Coleman on 7/20/16.
//  Copyright © 2016 Sean Coleman. All rights reserved.
//

import Foundation
import UIKit
import FBSDKLoginKit

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

extension UIImageView {
    func tintImageColor(color : UIColor) {
        self.image = self.image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        self.tintColor = color
    }
}

func textViewSetup (textField: UITextField, pic: String) {
    let textOutlineColor = UIColor.lightGrayColor()
    textField.layer.borderWidth = 1
    textField.layer.cornerRadius = 5
    textField.layer.borderColor = textOutlineColor.CGColor
    let imageView = UIImageView()
    let image = UIImage(named: pic)
    imageView.frame = CGRect(x: 0, y: 0, width: 40 , height: 50)
    imageView.contentMode = UIViewContentMode.Center
    let view = UIViewController()
    view.view.addSubview(imageView)
    imageView.image = image
    textField.leftViewMode = UITextFieldViewMode.Always
    textField.leftView = imageView
}


    