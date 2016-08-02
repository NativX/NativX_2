//
//  SuggestionViewController.swift
//  NativX_2
//
//  Created by Sean Coleman on 8/1/16.
//  Copyright © 2016 Sean Coleman. All rights reserved.
//

import UIKit
import Koloda

var numberOfCards: UInt = 5

class SuggestionViewController: UIViewController {

    @IBOutlet weak var kolodaView: KolodaView!
    
    @IBOutlet weak var buttonView: UIView!
    
    
    private var dataSource: Array<UIImage> = {
        var array: Array<UIImage> = []
        for index in 0..<numberOfCards {
            array.append(UIImage(named: "Card_like_\(index + 1)")!)
        }
        
        return array
    }()
    
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonView.layer.cornerRadius = 5
        buttonView.layer.borderWidth = 1
        buttonView.layer.borderColor = UIColor.clearColor().CGColor
        
        kolodaView.dataSource = self
        kolodaView.delegate = self
        
        self.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
    }
    
    @IBAction func dislikeButtonClicked(sender: UIButton) {
        kolodaView?.swipe(SwipeResultDirection.Left)
        
    }
    
    @IBAction func likeButtonClicked(sender: UIButton) {
        kolodaView?.swipe(SwipeResultDirection.Right)
    }
    
    @IBAction func backButtonClicked(sender: UIButton) {
        kolodaView?.revertAction()
    }
    
}

//MARK: KolodaViewDelegate
extension SuggestionViewController: KolodaViewDelegate {
    
    func kolodaDidRunOutOfCards(koloda: KolodaView) {
        dataSource.insert(UIImage(named: "Card_like_6")!, atIndex: kolodaView.currentCardIndex - 1)
        let position = kolodaView.currentCardIndex
        kolodaView.insertCardAtIndexRange(position...position, animated: true)
    }
    
    func koloda(koloda: KolodaView, didSelectCardAtIndex index: UInt) {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://nativxtravel.com")!)
    }
}

//MARK: KolodaViewDataSource
extension SuggestionViewController: KolodaViewDataSource {
    
    func kolodaNumberOfCards(koloda:KolodaView) -> UInt {
        return UInt(dataSource.count)
    }
    
    func koloda(koloda: KolodaView, viewForCardAtIndex index: UInt) -> UIView {
        return UIImageView(image: dataSource[Int(index)])
    }
    
    func koloda(koloda: KolodaView, viewForCardOverlayAtIndex index: UInt) -> OverlayView? {
        return NSBundle.mainBundle().loadNibNamed("OverlayView",
                                                  owner: self, options: nil)[0] as? OverlayView
    }
}

