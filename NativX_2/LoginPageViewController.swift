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

class LoginPageViewController: UIViewController, FBSDKLoginButtonDelegate {
    @IBOutlet weak var noAccountTapped: UIButton!
    @IBOutlet weak var emailLoginText: UITextField!
    @IBOutlet weak var passwordLoginText: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var register: UIButton!
    @IBOutlet weak var FBloginButton: FBSDKLoginButton!
    @IBOutlet weak var twitterLogin: UIButton!

    
    // function used to link their unique UserID with other social media or login
    func firebaseLogin(credential: FIRAuthCredential) {
        
        if let user = FIRAuth.auth()?.currentUser {
            // [START link_credential]
            user.linkWithCredential(credential) { (user, error) in
                // [START_EXCLUDE]
                if error != nil {
                    print("user linked")
                    return
                }
                
                // [END_EXCLUDE]
            }
            // [END link_credential]
        } else {
            // [START signin_credential]
            print("user signed in")
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
    
    // Error Handling Function
    func alertUser (title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        
        alertController.addAction(defaultAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get public profile, email, and user friends from Facebook
        self.FBloginButton.delegate = self
        self.FBloginButton.readPermissions = ["public_profile", "email", "user_friends"]
        

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // Twitter Login
    @IBAction func twitterLoginTapped(sender: UIButton) {
        Twitter.sharedInstance().logInWithCompletion { session, error in
            // Firebase login
            if (session != nil) {
                let credential = FIRTwitterAuthProvider.credentialWithToken(session!.authToken, secret: session!.authTokenSecret)
                self.firebaseLogin(credential)
                print("signed in as \(session!.userName)");
                self.performSegueWithIdentifier("goToHome", sender: self)
            // Handle error
            } else {
                
                self.alertUser("There was a problem", message: "Twitter Login Authentication Failed")
                print("error: \(error!.localizedDescription)");
            }
        }
        
    }
    
    // Conform FBLoginButtonDelegate with following two functions
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        if ((error) != nil)
        {
            // Process error
            self.alertUser("There was a problem", message: "Facebook Login Process Error. Please try again")
            

        }
        else if result.isCancelled {
            
            // Handle cancellations
            self.alertUser("There was a problem", message: "Facebook Login Cancelled. Please try again.")

        }
        else {
            let credential = FIRFacebookAuthProvider.credentialWithAccessToken(FBSDKAccessToken.currentAccessToken().tokenString)
            self.firebaseLogin(credential)
            
            // Use FB Graph request to update email on Firebase
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "email, name"]).startWithCompletionHandler({ (connection, results, requestError) -> Void in
                
                if requestError != nil {
                    print(requestError)
                    return
                }
                
                // Update email when they sign in with Facebook
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
            self.performSegueWithIdentifier("goToHome", sender: self)
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
            
            self.alertUser("Sign In Failed", message: "Please Enter a Valid Email and Password")
            
        }
        else {
            
            FIRAuth.auth()?.signInWithEmail(emailLoginText.text!, password: passwordLoginText.text!, completion: {
                
                user, error in
                
                if error != nil {
                    
                    self.alertUser("There was a problem", message: "The Email or Passwaord you entered was incorrect. Please try again.")
                    
                }
                else {
                    // print(FIRAuth.fetchProvidersForEmail(email))
                    print("user logged in")
                    
                    }
                })
            }

        }
    
    }

