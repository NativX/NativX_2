//
//  InterestsViewController.swift
//  NativX_2
//
//  Created by Sean Coleman on 7/27/16.
//  Copyright © 2016 Sean Coleman. All rights reserved.
//

import UIKit
import Foundation

class InterestsViewController: UIViewController {
    @IBOutlet weak var desitinationImageTopView: UIImageView!

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var budgetSlider: UISlider!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentStackView: UIStackView!
    @IBOutlet weak var getSuggestionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure Scroll View
        scrollView.contentSize = CGSize(width: contentStackView.frame.width, height: contentStackView.frame.height)
        
        // Get Suggestion Button 
        getSuggestionButton.layer.borderWidth = 1
        getSuggestionButton.layer.cornerRadius = 5
        getSuggestionButton.layer.borderColor = nativxColor.CGColor
    }
}
