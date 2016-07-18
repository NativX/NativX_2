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
import FirebaseDatabase

class LinkSocial: UIViewController, FBSDKLoginButtonDelegate {
    @IBOutlet weak var greeting: UILabel!
    @IBOutlet weak var FBloginButton: FBSDKLoginButton!
    @IBOutlet weak var twitterLogin: UIButton!
    
    // Aggregate facebook and twitter info to pass into Watson
    var posts: String = ""
    var bio: String = ""
    var tweets: String = ""
    
    override func userPosts (post: String){
        self.posts = post
    }
    override func userBio (bio : String) {
        self.bio = bio
    }
    
    override func userTweets (tweets : String) {
        self.tweets = tweets
    }
    
    @IBAction func continueTapped(sender: AnyObject) {
        print (posts)
        print (bio)
        print (tweets)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.FBloginButton.delegate = self
        self.FBloginButton.readPermissions = perm
        
        // Update Greeting
        let userID = FIRAuth.auth()?.currentUser?.uid
        ref.child("users").child(userID!).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            // Get user value
            if let first = snapshot.value!["first"] {
            self.greeting.text = " Hi, \(first!)."
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Twitter Login
    @IBAction func twitterLoginTapped(sender: UIButton) {
        self.twitterLinkSocialController()
        self.twitterLogin.setImage(UIImage(named: "ContentDeliveryCheckmark"), forState: UIControlState.Normal)
        
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

            // Make sure user is signed in
            FIRAuth.auth()?.addAuthStateDidChangeListener { auth, user in
                if user != nil {
                    // User is signed in.
                    self.FBloginButton.setImage(UIImage(named: "ContentDeliveryCheckmark"), forState: UIControlState.Normal)
                    
                    // Pull facebook data
                    self.FBUserDataToFirbase()
                    self.getFBUserLikes ()
                    self.getFBUserPosts()
                    
                } else {
                    // No user is signed in.
                    self.alertUser("Something went wrong.", message: "Facebook linkage failed")
                }
            }
        }
    }
    
    // Facebook Logout
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        
        try! FIRAuth.auth()!.signOut()
        print("User Logged Out")
        
    }
}
