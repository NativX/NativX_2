//
//  InterestsViewController.swift
//  NativX_2
//
//  Created by Sean Coleman on 7/27/16.
//  Copyright © 2016 Sean Coleman. All rights reserved.
//

import UIKit
import Foundation
import IntervalSlider


class InterestsViewController: UIViewController {
    @IBOutlet weak var desitinationImageTopView: UIImageView!

    @IBOutlet weak var interestsCollectionView: UICollectionView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentStackView: UIStackView!
    @IBOutlet weak var getSuggestionButton: UIButton!
    let step: Float = 1
    
    @IBOutlet weak var sliderView1: UIView!
    @IBOutlet weak var sliderView2: UIView!

    var interests =
        Interests.createEatInterests()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Sliders
        let result = self.createSources1()
        self.intervalSlider1 = IntervalSlider(frame: self.sliderView1.bounds, sources: result.sources, options: result.options)
        
        let result2 = self.createSources2()
        self.intervalSlider2 = IntervalSlider(frame: self.sliderView2.bounds, sources: result2.sources, options: result2.options)
        
        // Configure Scroll View
        scrollView.contentSize = CGSize(width: contentStackView.frame.width, height: contentStackView.frame.height)
        
        // Get Suggestion Button 
        getSuggestionButton.layer.borderWidth = 1
        getSuggestionButton.layer.cornerRadius = 5
        getSuggestionButton.layer.borderColor = nativxColor.CGColor
    }
    
    
    private struct Storyboard {
        static let CellIdentifier = "Interests Cell"
    }
    
    
    @IBAction func indexChanged(sender: UISegmentedControl) {
        
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            print("eat")
            interests = Interests.createEatInterests()
            
        case 1:
            print("play")
            interests = Interests.createPlayInterests()
        case 2:
            print("stay")
            interests = Interests.createStayInterests()
        default:
            break; 
        }
        
        self.interestsCollectionView.reloadData()
    }
    
    
    
    private var intervalSlider1: IntervalSlider! {
        didSet {
            self.intervalSlider1.tag = 1
            self.sliderView1.addSubview(self.intervalSlider1)
        }
    }
    private var intervalSlider2: IntervalSlider! {
        didSet {
            self.intervalSlider2.tag = 1
            self.sliderView2.addSubview(self.intervalSlider2)
        }
    }
    
    private var data1: [Float] {
        return [0, 1, 2 , 3]
    }
    
    private var data2: [Float] {
        return [0, 1, 2]
    }
    
    
    private func createSources1() -> (sources: [IntervalSliderSource], options: [IntervalSliderOption]) {
        // Sample of irregular inttervals
        var sources = [IntervalSliderSource]()
        var appearanceValue: Float = 5
        let data = self.data1
        
        let minLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 35, height: 20))
        minLabel.text = "$"
        minLabel.font = UIFont.systemFontOfSize(CGFloat(12))
        minLabel.textColor = nativxGrey
        minLabel.textAlignment = .Center
        let minSource = IntervalSliderSource(validValue: data[0], appearanceValue: appearanceValue, label: minLabel)
        sources.append(minSource)
        appearanceValue += 15
        
        let shortLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 35, height: 20))
        shortLabel.text = "$$"
        shortLabel.font = UIFont.systemFontOfSize(CGFloat(12))
        shortLabel.textColor = nativxGrey
        shortLabel.textAlignment = .Center
        let shortSource = IntervalSliderSource(validValue: data[1], appearanceValue: appearanceValue, label: shortLabel)
        sources.append(shortSource)
        appearanceValue += 15
        
        let longLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 35, height: 20))
        longLabel.text = "$$$"
        longLabel.font = UIFont.systemFontOfSize(CGFloat(12))
        longLabel.textColor = nativxGrey
        longLabel.textAlignment = .Center
        let longSource = IntervalSliderSource(validValue: data[2], appearanceValue: appearanceValue, label: longLabel)
        sources.append(longSource)
        appearanceValue += 15
        
        let maxLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 35, height: 20))
        maxLabel.text = "$$$$"
        maxLabel.font = UIFont.systemFontOfSize(CGFloat(12))
        maxLabel.textColor = nativxGrey
        maxLabel.textAlignment = .Center
        let maxSource = IntervalSliderSource(validValue: data[3], appearanceValue: appearanceValue, label: maxLabel)
        sources.append(maxSource)
        appearanceValue += 5
        
        let options: [IntervalSliderOption] = [
            .MaximumValue(appearanceValue),
            .MinimumValue(0),
            .AddMark(true),
            .LabelBottomPadding(1),
            .MinimumTrackTintColor(nativxColor)
            // .ThumbImage(UIImage(named: "thumb")!)
        ]
        return (sources, options)
    }
    
    private func createSources2() -> (sources: [IntervalSliderSource], options: [IntervalSliderOption]) {
        // Sample of irregular inttervals
        var sources = [IntervalSliderSource]()
        var appearanceValue: Float = 5
        let data = self.data2
        
        let minLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 60, height: 20))
        minLabel.text = "Popular"
        minLabel.font = UIFont.systemFontOfSize(CGFloat(12))
        minLabel.textColor = nativxGrey
        minLabel.textAlignment = .Center
        let minSource = IntervalSliderSource(validValue: data[0], appearanceValue: appearanceValue, label: minLabel)
        sources.append(minSource)
        appearanceValue += 15
        
        let shortLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 35, height: 20))
        shortLabel.text = "Mixed"
        shortLabel.font = UIFont.systemFontOfSize(CGFloat(12))
        shortLabel.textColor = nativxGrey
        shortLabel.textAlignment = .Center
        let shortSource = IntervalSliderSource(validValue: data[1], appearanceValue: appearanceValue, label: shortLabel)
        sources.append(shortSource)
        appearanceValue += 15
        
        let longLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 60, height: 20))
        longLabel.text = "Trailblazer"
        longLabel.font = UIFont.systemFontOfSize(CGFloat(12))
        longLabel.textColor = nativxGrey
        longLabel.textAlignment = .Center
        let longSource = IntervalSliderSource(validValue: data[2], appearanceValue: appearanceValue, label: longLabel)
        sources.append(longSource)
        appearanceValue += 5
        
        let options: [IntervalSliderOption] = [
            .MaximumValue(appearanceValue),
            .MinimumValue(0),
            .AddMark(true),
            .LabelBottomPadding(1),
            .MinimumTrackTintColor(nativxColor)
        ]
        return (sources, options)
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











