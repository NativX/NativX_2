//
//  HomeViewController.swift
//  NativX_2
//
//  Created by Sean Coleman on 5/31/16.
//  Copyright © 2016 Sean Coleman. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import Fabric
import TwitterKit

class HomeViewController: UIViewController {
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var hometown: UILabel!
    @IBOutlet weak var travelLabel: UILabel!
    @IBOutlet weak var topUserView: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        personalInfo()
        navigationItem.title = "Home"
        
        // Rounded Profile Picture
        userImage.layer.borderWidth = 1
        userImage.layer.masksToBounds = false
        userImage.layer.borderColor = UIColor.clearColor().CGColor
        userImage.layer.cornerRadius = userImage.frame.height/2
        userImage.clipsToBounds = true
        
        // Travel Label font adjust to Hometown
        travelLabel.font = hometown.font
        
        // top view
        topUserView.layer.borderColor = UIColor.lightGrayColor().CGColor
        topUserView.layer.borderWidth = 0.7
        
    }

    func personalInfo () {
        if (FIRAuth.auth()?.currentUser) != nil {
            
            let userID = FIRAuth.auth()?.currentUser?.uid
            ref.child("users").child(userID!).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
                // First Name
                if let first = snapshot.value!["first"] {
                    if let firstName = first {
                        self.userName.text = " Hi, \(firstName)."
                    }
                }
                
            }) { (error) in
                print(error.localizedDescription)
            }
            ref.child("users").child(userID!).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
                // Photo
                if let photo = snapshot.value!["photo"] as? String {
                    if let url = NSURL(string: photo) {
                        if let data = NSData(contentsOfURL: url) {
                            self.userImage.image = UIImage(data: data)
                        }        
                    }
                }
                
            }) { (error) in
                print(error.localizedDescription)
            }
            ref.child("users").child(userID!).child ("Facebook Basic").observeSingleEventOfType(.Value, withBlock: { (snapshot) in
                // Photo
                if let hometown = snapshot.value!["Hometown"]{
                    if let home = hometown {
                        self.hometown.text = "Hometown: \(home)"
                    }
                }
                
            }) { (error) in
                print(error.localizedDescription)
            }


        }
        else {
            // No user is signed in.
            print("Home screen and no user")
        }
    }
    
    // logout button
    @IBAction func logOutTap(sender: UIButton) {
        // Firebase Logout
        try! FIRAuth.auth()!.signOut()
        
        // Facebook Logout
        FBSDKAccessToken.setCurrentAccessToken(nil)
        
        // Twitter Logout
        let store = Twitter.sharedInstance().sessionStore

        if let userID = store.session()?.userID {
            store.logOutUserID(userID)
        }
        self.performSegueWithIdentifier("logOutToHome", sender: self)
    }

}
