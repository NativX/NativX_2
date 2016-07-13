//
//  LoginFunctions.swift
//  NativX_2
//
//  Created by Sean Coleman on 7/6/16.
//  Copyright © 2016 Sean Coleman. All rights reserved.
//

import Foundation
import Firebase
import FBSDKLoginKit
import FBSDKCoreKit
import TwitterKit
import Fabric


extension UIViewController {
    
    // Firebase Link Social Media Function
    func firebaseLogin(credential: FIRAuthCredential) {
        // User is Signed in
        if let user = FIRAuth.auth()?.currentUser {
            // Link Credential
            user.linkWithCredential(credential) { (user, error) in
                if error != nil {
                    print("user is not linked")
                    return
                }
            }
        } else {
            // Sign In with Credential
            print("user signed in")
            FIRAuth.auth()?.signInWithCredential(credential) { (user, error) in
                if error != nil {
                    self.alertUser("Sign in Failed", message: "Something went wrong. Please try again,")
                    return
                }
            }
        }
    }
    
    // Error Handling Alert Function
    func alertUser (title: String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    // Firebase Link FB Login with Email Function
    func facebookEmailLink () {
        // Use FB Graph request to update email on Firebase
        FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "email, name"]).startWithCompletionHandler({ (connection, results, requestError) -> Void in
            //ERROR
            if requestError != nil {
                print(requestError)
                return
            }
            
            // Update email when they sign in with Facebook
            let userEmail = results["email"] as? String
            let user = FIRAuth.auth()?.currentUser
            
            user?.updateEmail(userEmail!) { error in
                //ERROR
                if error != nil {
                    print("email not updated")
                }
                //SUCCESS
                else {
                    print("email updated")
                }
            }
        })
    }
    
    // Twitter Login
    func twitterLoginController () {
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
    
    func FBUserDataToFirbase () {
        // Pull facebook data
        let params = ["fields" : "about, age_range, email, bio, birthday, gender, hometown, interested_in.limit(100), groups.limit(100), music.limit(100)"]
        FBSDKGraphRequest(graphPath: "me", parameters: params).startWithCompletionHandler({ (connection, results, requestError) -> Void in
            //ERROR
            if requestError != nil {
                print(requestError)
                return
            }
            // PULL FB DATA
            else {
                let bio = results!.valueForKey("bio")!
                print (bio)
                
                /*
                print(" \(results["age_range"]) \n\n")
                print(" \(results["email"]) \n\n")
                print(" \(results["birthday"]) \n\n")
                print(" \(results["gender"]) \n\n")
                print(" \(results["hometown"]) \n\n")
                print(" \(results["interested_in"]) \n\n")
                print(" \(results["books"]) \n\n") */
  
            }
        })
    }
    
    func getFBUserLikes () {
        FBSDKGraphRequest(graphPath: "me/likes", parameters: ["fields" : "id, name"]).startWithCompletionHandler({ (connection, results, requestError) -> Void in
            //ERROR
            if requestError != nil {
                print(requestError)
                return
            }
            // PULL FB DATA
            else {
                let books = results!.valueForKey("data")!
                print (books)
            }
        })
    }
    
    func getFBUserPosts () {
        FBSDKGraphRequest(graphPath: "me/posts", parameters: ["fields" : "message"]).startWithCompletionHandler({ (connection, results, requestError) -> Void in
            //ERROR
            if requestError != nil {
                print(requestError)
                return
            }
            // PULL FB DATA
            else {
                let posts = results!.valueForKey("data")!
                print (posts)
            }
        })
    }
}