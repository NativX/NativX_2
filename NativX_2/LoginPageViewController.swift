//
//  loginPgViewController.swift
//  NativX_2
//
//  Created by Sean Coleman on 5/19/16.
//  Copyright © 2016 Sean Coleman. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
import FBSDKCoreKit
import TwitterKit
import Fabric
import PersonalityInsightsV2

class LoginPageViewController: UIViewController, FBSDKLoginButtonDelegate {
    

    @IBOutlet weak var emailLoginText: UITextField!
    @IBOutlet weak var passwordLoginText: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var FBloginButton: FBSDKLoginButton!
    @IBOutlet weak var twitterLogin: TWTRLogInButton!
    
    @IBOutlet weak var registerButton: UIButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // background 
        self.view.addBackground ("background1")
        // get public profile, email, and user friends from Facebook
        self.FBloginButton.delegate = self
        self.FBloginButton.readPermissions = perm
        // Sign in Button
        loginButton.layer.cornerRadius = 5
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = nativxGrey.CGColor
        // Twitter Button
        twitterLogin.layer.borderWidth = 1
        twitterLogin.layer.borderColor = UIColor.darkGrayColor().CGColor
        twitterLogin.layer.cornerRadius = 5
        twitterLogin.frame.size.width = 50
        // Facebook Button
        FBloginButton.layer.cornerRadius = 5
        // Email
        textViewSetup (emailLoginText, pic: "email")
        // Password
        textViewSetup (passwordLoginText, pic: "lock")
        // Register
        registerButton.setTitleColor(nativxColor, forState: .Normal)
    }
    

    // Twitter Login
    @IBAction func twitterLoginTapped(sender: TWTRLogInButton) {
        twitterLoginController()
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
            firebaseLogin(credential)
            // facebookEmailLink()
            facebookPicture()
            FBUserDataToFirbase()
            getFBUserLikes ()
            getFBUserBio ()
            
            FIRAuth.auth()?.addAuthStateDidChangeListener { auth, user in
                if user != nil {
                    // User is signed in.
                    self.performSegueWithIdentifier("goToHome", sender: self)
                } else {
                    // No user is signed in.
                    // TODO: Spinner
                }
            }
        }
    }
    
    
    // Email Login
    @IBAction func LoginTapped(sender: UIButton) {
        
        let email:NSString = emailLoginText.text!
        let password:NSString = passwordLoginText.text!
        
        // left something blank
        if (email.isEqualToString("") || password.isEqualToString("") ) {
            self.alertUser("Sign In Failed", message: "Please Enter a Valid Email and Password")
        }
        else {
            // Firebase email auth
            FIRAuth.auth()?.signInWithEmail(emailLoginText.text!, password: passwordLoginText.text!, completion: {
                user, error in
                if error != nil {
                    self.alertUser("There was a problem", message: "The Email or Password you entered was incorrect. Please try again.")
                }
                else {
                    // print(FIRAuth.fetchProvidersForEmail(email))
                    print("user logged in")
                    }
                })
            }
        }
    
    // Facebook Logout
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        try! FIRAuth.auth()!.signOut()
        print("User Logged Out")
    }
}

