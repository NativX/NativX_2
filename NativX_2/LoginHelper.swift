//
//  LoginFunctions.swift
//  NativX_2
//
//  Created by Sean Coleman on 7/6/16.
//  Copyright © 2016 Sean Coleman. All rights reserved.
//

import Foundation
import UIKit
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
                print("twitterlogged")
                let credential = FIRTwitterAuthProvider.credentialWithToken(session!.authToken, secret: session!.authTokenSecret)
                self.firebaseLogin(credential)
                print("signed in as \(session!.userName)")
                self.performSegueWithIdentifier("goToHome", sender: self)
            // Handle error
            } else {
                self.alertUser("There was a problem", message: "Twitter Login Authentication Failed")
                print("error: \(error!.localizedDescription)");
            }
        }
    }
    
    func userTweets (tweetsString : String) {
        print ("Tweets not updated")
    }
    
    // Twitter Link Social and use Tweets for Watson
    func twitterLinkSocialController (twitterLogin: UIButton!) {
        Twitter.sharedInstance().logInWithCompletion { session, error in
            // Firebase login
            if (session != nil) {
                print("twitterlogged")
                let credential = FIRTwitterAuthProvider.credentialWithToken(session!.authToken, secret: session!.authTokenSecret)
                self.firebaseLogin(credential)
                print("signed in as \(session!.userName)")
                let userID = Twitter.sharedInstance().sessionStore.session()?.userID
                let client = TWTRAPIClient(userID: userID)
                let statusesShowEndpoint = "https://api.twitter.com/1.1/statuses/user_timeline.json"
                let params = ["user_id" : userID!, "count" : "400"]
                var clientError : NSError?
                
                let request = client.URLRequestWithMethod("GET", URL: statusesShowEndpoint, parameters: params, error: &clientError)
                
                client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
                    if connectionError != nil {
                        print("Error: \(connectionError)")
                    }
                    do {
                        let json = try NSJSONSerialization.JSONObjectWithData(data!, options: [])
                        
                        let tweets = json.valueForKey("text")!
                        let tweetsString = (tweets as! [String]).joinWithSeparator(". ")
                        self.userTweets(tweetsString)
                        twitterLogin.setImage(UIImage(named: "ContentDeliveryCheckmark"), forState: UIControlState.Normal)
                    } catch let jsonError as NSError {
                        print("json error: \(jsonError.localizedDescription)")
                    }
                }
            // Handle error
            } else {
                
                self.alertUser("There was a problem", message: "Twitter Login Authentication Failed")
                print("error: \(error!.localizedDescription)");
                
            }
        }
    }
    
    func facebookPicture () {
        let pictureRequest = FBSDKGraphRequest(graphPath: "me/picture?type=normal&redirect=false", parameters: ["fields" : "url"])
        pictureRequest.startWithCompletionHandler({
            (connection, result, error: NSError!) -> Void in
            if error == nil {
                
                FIRAuth.auth()?.addAuthStateDidChangeListener { auth, user in
                    if user != nil {
                        guard let uid = user?.uid else {
                            return
                        }
                        
                        let userRef = ref.child("users").child(uid)
                        
                        // AGE
                        if let photoURL = result.valueForKey("data")!.valueForKey("url") {
                            let photo_fir = ["photo" : photoURL]
                            userRef.updateChildValues(photo_fir, withCompletionBlock: {
                                (err, ref) in
                                
                                if err != nil {
                                    print (err)
                                    return
                                }
                            })
                        }
                    }
                }
            }
            else {
                print(error)
            }
        })
    }
    
    func FBUserDataToFirbase () {
        let params = ["fields" : "about, age_range, email, bio, birthday, gender, hometown, interested_in.limit(100), groups.limit(100), events.limit(20), music.limit(50)"]
        FBSDKGraphRequest(graphPath: "me", parameters: params).startWithCompletionHandler({ (connection, results, requestError) -> Void in
            //ERROR
            if requestError != nil {
                print(requestError)
                return
            }
            // PULL FB DATA + FIREBASE PUSH
            else {
                // Check for logged in fire user
                FIRAuth.auth()?.addAuthStateDidChangeListener { auth, user in
                    if user != nil {
                        guard let uid = user?.uid else {
                            return
                        }
                        let fbBasicRef = ref.child("users").child(uid).child("Facebook Basic")
                        
                        let userRef = ref.child("users").child(uid)
                        
                        // HOMETOWN 
                        if let hometown: AnyObject? = results!.valueForKey("hometown")!.valueForKey("name")! {
                            print (hometown!)
                            let home = ["Hometown" : hometown!]
                            fbBasicRef.updateChildValues(home, withCompletionBlock: {
                                (err, ref) in
                                
                                if err != nil {
                                    print (err)
                                    return
                                }
                            })
                        }

                        // AGE
                        if let age_range: AnyObject? = results!.valueForKey("age_range")!.valueForKey("min")! {
                            let age_fir = ["age" : age_range!]
                            fbBasicRef.updateChildValues(age_fir, withCompletionBlock: {
                                (err, ref) in
                                
                                if err != nil {
                                    print (err)
                                    return
                                }
                            })
                        }
                        
                        // BIRTHDAY
                        if let bday: AnyObject? = results!.valueForKey("birthday")! {
                            let bday_fir = ["birthday" : bday!]
                            fbBasicRef.updateChildValues(bday_fir, withCompletionBlock: {
                                (err, ref) in
                                
                                if err != nil {
                                    print (err)
                                    return
                                }
                            })
                        }
                        
                        // GENDER
                        if let gender: AnyObject? = results!.valueForKey("gender")! {
                            let gender_fir = ["gender" : gender!]
                            fbBasicRef.updateChildValues(gender_fir, withCompletionBlock: {
                                (err, ref) in
                                
                                if err != nil {
                                    print (err)
                                    return
                                }
                            })
                        }
                        
                        // MUSIC LIKES
                        if let music: AnyObject? = results!.valueForKey("music")!.valueForKey("data")!.valueForKey("name")! {
                            let music_fir = ["Facebook Music" : music!]
                            userRef.updateChildValues(music_fir, withCompletionBlock: {
                                (err, ref) in
                                
                                if err != nil {
                                    print (err)
                                    return
                                }
                            })
                        }
                        
                        // EVENTS ATTENDED
                        if let events: AnyObject? = results!.valueForKey("events")!.valueForKey("data")!.valueForKey("name")! {
                            let events_fir = ["Facebook Events" : events!]
                            userRef.updateChildValues(events_fir, withCompletionBlock: {
                                (err, ref) in
                                
                                if err != nil {
                                    print (err)
                                    return
                                }
                            })

                        }

                    } else {
                        // No user is signed in.
                        // TODO: Spinner
                    }
                }
            }
        })
    }
    
    // PULL FB Likes + Push to database
    func getFBUserLikes () {
        FBSDKGraphRequest(graphPath: "me/likes", parameters: ["fields" : "name"]).startWithCompletionHandler({ (connection, results, requestError) -> Void in
            // ERROR
            if requestError != nil {
                print(requestError)
                return
            }
            // SUCCESS
            else {
                FIRAuth.auth()?.addAuthStateDidChangeListener { auth, user in
                    if user != nil {
                        // User is signed in.
                        guard let uid = user?.uid else {
                            return
                        }
                        let fbLikesRef = ref.child("users").child(uid)
                        let likes = results!.valueForKey("data")!.valueForKey("name")!
                        let likes_fir = ["Facebook Likes": likes]
                        fbLikesRef.updateChildValues(likes_fir, withCompletionBlock: {
                            (err, ref) in
                            
                            if err != nil {
                                print (err)
                                return
                            }
                        })
                    } else {
                        // No user is signed in.
                        // TODO: Spinner
                    }
                }

            }
        })
    }
    
    func userPosts (post: String){
        
        print("Error, Facebook Post Variable did not Update")
        
    }

    
    func getFBUserPosts () {
        FBSDKGraphRequest(graphPath: "me/posts", parameters: ["fields" : "message"]).startWithCompletionHandler({ (connection, results, requestError) -> Void in
            // ERROR
            if requestError != nil {
                print(requestError)
                return
            }
            // PULL FB DATA
            else {
                let posts = results!.valueForKey("data")!.valueForKey("message") as? NSArray
                let postArray : NSArray = posts!
                let filteredPosts = postArray.filter({!($0 is NSNull)})
                let postText = (filteredPosts as! [String]).joinWithSeparator(". ")
                self.userPosts(postText)
            }
        })
    }
    
    func userBio (bio : String) {
        print ("ERROR BIO NOT UPDATED")
    }
    
    func getFBUserBio () {
        FBSDKGraphRequest(graphPath: "me", parameters: ["fields" : "bio"]).startWithCompletionHandler({ (connection, results, requestError) -> Void in
            // ERROR
            if requestError != nil {
                print(requestError)
                return
            }
            // PULL FB DATA
            else {
                let bio: AnyObject? = results!.valueForKey("bio")!
                let bioForWatson = String(bio!)
                self.userBio(bioForWatson)
            }
        })
    }
}