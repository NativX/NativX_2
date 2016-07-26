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
            //get the user's id for adding to Firebase
            let userID = FIRAuth.auth()?.currentUser?.uid
            let userRef = ref.child(" ").child(userID!)

            //get data about the input text, add to Firebase
            let words = profile.wordCount
            let wordMsg = profile.wordCountMessage!
            userRef.updateChildValues([
                "word count": words,
                "word count message" : wordMsg
                ],  withCompletionBlock: {
                    (error, ref) in
                    if error != nil {
                        print(error)
                    } else {
                        print("Word data saved successfully!")
                    }
            })
            
            //get the parent node of the personality information, add to Firebase
            let big5 = profile.tree.children![0]
            let personalityMaster = big5.children![0]
            userRef.updateChildValues([
                personalityMaster.name : personalityMaster.percentage!
                ],  withCompletionBlock: {
                    (error, ref) in
                    if error != nil {
                        print(error)
                    } else {
                        print("parent personality data saved successfully!")
                    }
            })
        
            //get all other traits and add each to Firebase
            let personalities = personalityMaster.children!
            for trait in personalities {
                //print(trait.name + " " + String(trait.percentage!) + " " + String(trait.samplingError!))
                self.addTrait(userID!, trait: trait.name, percent: trait.percentage!, sampError: trait.samplingError!)
                for subTrait in trait.children! {
                    //print(subTrait.name + " " + String(subTrait.percentage!) + " " + String(subTrait.samplingError!))
                    self.addTrait(userID!, trait: subTrait.name, percent: subTrait.percentage!, sampError: subTrait.samplingError!)
                }
            }
        }
    }
    
    //outline for adding individual traits to Firebase for this user
    func addTrait(uid: String, trait: String, percent: Double, sampError: Double) {
        let traitRef = ref.child("users").child(uid).child(trait)
        traitRef.updateChildValues([
            "percentage": percent,
            "sampling error" : sampError
            ],  withCompletionBlock: {
                (error, ref) in
                if error != nil {
                    print(error)
                } else {
                    print( trait + " data saved successfully!")
                }
        })
    }
}