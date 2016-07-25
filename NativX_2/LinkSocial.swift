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
    @IBOutlet weak var linkView: UIView!
    @IBOutlet weak var register: UIButton!

    
    // Aggregate facebook and twitter info to pass into Watson
    var posts: String = ""
    var bio: String = ""
    var tweets: String = ""
    
    override func userPosts (post: String){
        self.posts = post
    }
    override func userBio (userBio : String) {
        self.bio = userBio
    }
    
    override func userTweets (userTweets : String) {
        self.tweets = userTweets
    }
    
    @IBAction func continueTapped(sender: AnyObject) {
        let socialTextForWatson = (posts + bio + tweets)
        personalityInsights(socialTextForWatson)
        self.performSegueWithIdentifier("linkToHome", sender: self)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Background 
        self.view.addBackground ("background1")
        
        // LinkView
        linkView.layer.cornerRadius = 8.0
        

        
        // Facebook
        FBloginButton.delegate = self
        FBloginButton.readPermissions = perm
        FBloginButton.layer.cornerRadius = 5
        
        // Twitter
        twitterLogin.layer.cornerRadius = 5
        
        // Register
        register.layer.cornerRadius = 5
        register.layer.borderWidth = 1

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
        
        // TODO: add a listener?
        let twitterUserID = Twitter.sharedInstance().sessionStore.session()?.userID
        if twitterUserID != nil {
            // User is signed in.
            self.twitterLogin.setImage(UIImage(named: "ContentDeliveryCheckmark"), forState: UIControlState.Normal)
        }
    }

    @IBAction func twitterLoginTapped(sender: UIButton) {
        self.twitterLinkSocialController()
    }

    
    // Conform FBLoginButtonDelegate with following two functions
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        // ERROR
        if ((error) != nil){
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
                    self.getFBUserBio ()
                    
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
