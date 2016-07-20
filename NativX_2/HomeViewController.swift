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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        personalInfo()
        navigationItem.title = "Home"

    }

    func personalInfo () {
        if let user = FIRAuth.auth()?.currentUser {
            
            // User is signed in.
            if let name = user.displayName {
                self.userName.text = "Hi \(name)."
            }
            else {
                self.userName.text = "Welcome to NativX."
            }
            
            if let photoUrl = user.photoURL {
                if let data = NSData(contentsOfURL: photoUrl){
                    self.userImage.image = UIImage(data: data)
                }
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
