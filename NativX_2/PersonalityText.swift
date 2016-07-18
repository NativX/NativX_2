//
//  PersonalityText.swift
//  NativX_2
//
//  Created by Sean Coleman on 7/16/16.
//  Copyright © 2016 Sean Coleman. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FBSDKLoginKit
import FBSDKCoreKit
import TwitterKit
import Fabric


class PersonalityText: NSObject {
    
    var facebookBio : String
    
    var facebookPosts : String
    
    var tweets : String
    
    var aggregatedText : String
    
    
    func getFBUserPosts () {
        
        FBSDKGraphRequest(graphPath: "me/posts", parameters: ["fields" : "message"]).startWithCompletionHandler({ (connection, results, requestError) -> Void in
            // ERROR
            if requestError != nil {
                print(requestError)
                return             }
            // PULL FB DATA
            else {
                let posts = results!.valueForKey("data")!.valueForKey("message") as? NSArray
                let postArray : NSArray = posts!
                let filteredPosts = postArray.filter({!($0 is NSNull)})
                let postText = (filteredPosts as! [String]).joinWithSeparator(".")
                self.facebookPosts = postText
                print (self.facebookPosts)
            }
        })
    }
    
    /* init (facebookBio: String, facebookPosts : String, tweets : String, aggregatedText : String) {
     self.facebookBio = facebookBio
     self.facebookPosts = facebookPosts
     self.tweets = tweets
     self.aggregatedText = facebookBio + facebookPosts + tweets
     }*/
    
}