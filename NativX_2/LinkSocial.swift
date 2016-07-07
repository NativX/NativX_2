//
//  LinkSocial.swift
//  NativX_2
//
//  Created by Sean Coleman on 7/7/16.
//  Copyright © 2016 Sean Coleman. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
import FBSDKCoreKit
import TwitterKit
import Fabric

class LinkSocial: UIViewController, FBSDKLoginButtonDelegate {
    @IBOutlet weak var greeting: UILabel!
    @IBOutlet weak var FBloginButton: FBSDKLoginButton!
    @IBOutlet weak var twitterLogin: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.FBloginButton.delegate = self
        self.FBloginButton.readPermissions = ["public_profile", "email", "user_friends"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Twitter Login
    @IBAction func twitterLoginTapped(sender: UIButton) {
        self.twitterLoginController()
        // TODO: Pull Twitter Data
        
        
        
    }
    
    // Conform FBLoginButtonDelegate with following two functions
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        // ERROR
        if ((error) != nil)
        {
            self.alertUser("There was a problem", message: "Facebook Login Process Error. Please try again")
        }
            // CANCELLED
        else if result.isCancelled {
            self.alertUser("There was a problem", message: "Facebook Login Cancelled. Please try again.")
        }
            // SUCCESS
        else {
            let credential = FIRFacebookAuthProvider.credentialWithAccessToken(FBSDKAccessToken.currentAccessToken().tokenString)
            self.firebaseLogin(credential)
            // TODO: Pull FB information
            
            
            self.performSegueWithIdentifier("goToHome", sender: self)
        }
    }
    
    // Facebook Logout
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        try! FIRAuth.auth()!.signOut()
        print("User Logged Out")
    }
    

}
