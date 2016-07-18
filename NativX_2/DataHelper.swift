//
//  DataHelper.swift
//  NativX_2
//
//  Created by Sean Coleman on 7/8/16.
//  Copyright © 2016 Sean Coleman. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FBSDKLoginKit
import FBSDKCoreKit
import TwitterKit
import Fabric


class FirebaseData: NSObject  {
    
    // FB Data to Firebase
    
    var bio : String?
    
    var age : String?
    
    var birthday : String?
    
    var gender : String?
    
    var hometown : String?
    
    var interested_in : NSObject?
    
    var groups : NSObject?
    
    var music : NSObject?

}

class PersonalityText: NSObject {
    
    var facebookBio : String
    
    var facebookPosts : String
    
    var tweets : String
    
    var aggregatedText : String
    
    init (facebookBio: String, facebookPosts : String, tweets : String, aggregatedText : String) {
        self.facebookBio = facebookBio
        self.facebookPosts = facebookPosts
        self.tweets = tweets
        self.aggregatedText = facebookBio + facebookPosts + tweets
    }
    
}
