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

    @IBOutlet weak var interestsCollectionView: UICollectionView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var budgetSlider: UISlider!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentStackView: UIStackView!
    @IBOutlet weak var getSuggestionButton: UIButton!
    @IBOutlet weak var localPopularSlider: UISlider!
    let step: Float = 1
    
    private var interests =
        Interests.createPlayInterests()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure Scroll View
        scrollView.contentSize = CGSize(width: contentStackView.frame.width, height: contentStackView.frame.height)
        
        // Get Suggestion Button 
        getSuggestionButton.layer.borderWidth = 1
        getSuggestionButton.layer.cornerRadius = 5
        getSuggestionButton.layer.borderColor = nativxColor.CGColor
        
        // Sliders 
        customSliderView(budgetSlider)
        customSliderView(localPopularSlider)
    }
    
    func customSliderView (slider: UISlider!) {
        slider.minimumTrackTintColor = nativxColor
        slider.maximumTrackTintColor = nativxGrey
    }

    @IBAction func budgetValueChanged(sender: UISlider) {
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
    }
    
    @IBAction func localPopularValueChanged(sender: UISlider) {
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
    }
    
    private struct Storyboard {
        static let CellIdentifier = "Interests Cell"
    }
    
}

// Extension for UICollectionView Functionality
extension InterestsViewController: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interests.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Storyboard.CellIdentifier, forIndexPath: indexPath) as! InterestsCollectionViewCell
        
        cell.interests = self.interests[indexPath.item]
        return cell
    }
}











