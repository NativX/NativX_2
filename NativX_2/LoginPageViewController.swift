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



class LoginPageViewController: UIViewController, FBSDKLoginButtonDelegate {
    @IBOutlet weak var noAccountTapped: UIButton!
    @IBOutlet weak var emailLoginText: UITextField!
    @IBOutlet weak var passwordLoginText: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var register: UIButton!
    @IBOutlet weak var FBloginButton: FBSDKLoginButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.FBloginButton.delegate = self
        self.FBloginButton.readPermissions = ["public_profile", "email"]

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Conform FBLoginButtonDelegate with following two functions
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        if ((error) != nil)
        {
            // Process error
            // Handle cancellations
            let alertController = UIAlertController(title: "There was a problem.", message: "Facebook Login process error", preferredStyle: .Alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            
            alertController.addAction(defaultAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
            

        }
        else if result.isCancelled {
            // Handle cancellations
            let alertController = UIAlertController(title: "There was a problem.", message: "Facebook Login cancelled", preferredStyle: .Alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            
            alertController.addAction(defaultAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)

        }
        else {
            print("User Logged In")
            let credential = FIRFacebookAuthProvider.credentialWithAccessToken(FBSDKAccessToken.currentAccessToken().tokenString)
            self.firebaseLogin(credential)
            
            // Use FB Graph request to update email on Firebase
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "email, name"]).startWithCompletionHandler({ (connection, results, requestError) -> Void in
                
                if requestError != nil {
                    print(requestError)
                    return
                }
                
                // TODO: fix this
                let userEmail = results["email"] as? String
                print(userEmail)
                let user = FIRAuth.auth()?.currentUser
                user?.updateEmail(userEmail!) { error in
                    if error != nil {
                        
                        print("email not updated")
                        
                    } else {
                        
                        print("email updated")
                        
                    }
                }
            })
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        try! FIRAuth.auth()!.signOut()
        print("User Logged Out")
    }
    
    @IBAction func LoginTapped(sender: UIButton) {
        
        let email:NSString = emailLoginText.text!
        let password:NSString = passwordLoginText.text!
        
        // left something blank
        if (email.isEqualToString("") || password.isEqualToString("") ) {
            
            let alertController = UIAlertController(title: "Sign In Failed!", message: "Please Enter a Valid Email and Password", preferredStyle: .Alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            
            alertController.addAction(defaultAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        else {
            
            FIRAuth.auth()?.signInWithEmail(emailLoginText.text!, password: passwordLoginText.text!, completion: {
                
                user, error in
                
                if error != nil {
                    let alertController = UIAlertController(title: "There was a problem", message: "Your email or password was incorrect. Please try again.", preferredStyle: .Alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    
                    alertController.addAction(defaultAction)
                    
                    self.presentViewController(alertController, animated: true, completion: nil)
                }
                else {
                    print("user logged in")
                    
                }
            })
        }

    }
    
    
    func firebaseLogin(credential: FIRAuthCredential) {

            if let user = FIRAuth.auth()?.currentUser {
                // [START link_credential]
                user.linkWithCredential(credential) { (user, error) in
                    // [START_EXCLUDE]
                    if error != nil {
                        
                        return
                    }

                    // [END_EXCLUDE]
                }
                // [END link_credential]
            } else {
                // [START signin_credential]
                FIRAuth.auth()?.signInWithCredential(credential) { (user, error) in
                    // [START_EXCLUDE]
                    if error != nil {

                        return
                    }
                  
                    // [END_EXCLUDE]
                }
                // [END signin_credential]
            }
        
        }
    }

