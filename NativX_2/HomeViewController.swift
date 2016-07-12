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

class HomeViewController: UIViewController {
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = FIRAuth.auth()?.currentUser {
            
            // User is signed in.
            
            if let name = user.displayName {
                self.userName.text = "Hi \(name)."
            }
            else {
                self.userName.text = "Welcome to NativX."
            }
            
            
            if let photoUrl = user.photoURL {
                let data = NSData(contentsOfURL: photoUrl)
                self.userImage.image = UIImage(data: data!)
            }

        } else {
            // No user is signed in.
            print("Home screen and no user")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // logout button
    @IBAction func logOutTap(sender: UIButton) {
        try! FIRAuth.auth()!.signOut()
        FBSDKAccessToken.setCurrentAccessToken(nil)
        self.performSegueWithIdentifier("logOutToHome", sender: self)
    }

}
