//
//  ExampleOverlayView.swift
//  NativX_2
//
//  Created by Sean Coleman on 8/1/16.
//  Copyright © 2016 Sean Coleman. All rights reserved.
//

import UIKit
import Koloda

private let overlayRightImageName = "yesOverlayImage"
private let overlayLeftImageName = "noOverlayImage"

class ExampleOverlayView: OverlayView {
    
    
    // image for left and right swipe
    @IBOutlet lazy var overlayImageView: UIImageView! = {
        [unowned self] in
            
        var imageView = UIImageView(frame: self.bounds)
        self.addSubview(imageView)
            
        return imageView
        }()
        
    override var overlayState: SwipeResultDirection? {
        didSet {
            switch overlayState {
            case .Left? :
                overlayImageView.image = UIImage(named: overlayLeftImageName)
               case .Right? :
                overlayImageView.image = UIImage(named: overlayRightImageName)
            default:
                overlayImageView.image = nil
            }
        }
    }
        
}

