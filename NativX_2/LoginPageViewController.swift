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


class LoginPageViewController: UIViewController, FBSDKLoginButtonDelegate{
    

    @IBOutlet weak var emailLoginText: UITextField!
    @IBOutlet weak var passwordLoginText: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var FBloginButton: FBSDKLoginButton!
    @IBOutlet weak var twitterLogin: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // get public profile, email, and user friends from Facebook
        self.FBloginButton.delegate = self
        self.FBloginButton.readPermissions = perm
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // Twitter Login
    @IBAction func twitterLoginTapped(sender: UIButton) {
        self.twitterLoginController()
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
            
            firebaseLogin(credential)
            facebookEmailLink()
            FBUserDataToFirbase()
            getFBUserLikes ()
            
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
    
    // Facebook Logout
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        try! FIRAuth.auth()!.signOut()
        print("User Logged Out")
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
    
    }

