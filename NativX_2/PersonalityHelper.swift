//
//  PersonalityHelper.swift
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
import PersonalityInsightsV2

extension UIViewController {
    
    
    // Personality insights
    func personalityInsights (text: String?) {

        let personalityInsights = PersonalityInsights(username: ibmUsername, password: ibmPassword)
        
        let text = text
        let failure = { (error: NSError) in print(error) }
        personalityInsights.getProfile(text: text!, failure: failure) { profile in
            // TODO: Parse JSON + Firebase Push
            print(profile)
        }
    }
}