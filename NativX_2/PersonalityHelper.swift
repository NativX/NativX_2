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
import Alamofire
import AlamofireObjectMapper


extension UIViewController {
    
    
    // Personality insights
    func personalityInsights (text: String?) {
        
        let personalityInsights = PersonalityInsights(username: ibmUsername, password: ibmPassword)
        
        let text = text
        let failure = { (error: NSError) in print(error) }
        
        personalityInsights.getProfile(text: text!, failure: failure) { profile in
            print(profile)
            
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
            
            for category in profile.tree.children! {
                self.addCategory(userRef, group: category)
            }
            
        }
    }
    
    
    //function to add each master element (personality, needs, values) and its child values to the db
    func addCategory(userRef: FIRDatabaseReference, group: TraitTreeNode) {
        
        //create new child on the userRef
        let groupRef = userRef.child(group.id)
        
        //get master trait
        let master = group.children![0]
        
        //add info about the master trait to Firebase
        groupRef.updateChildValues([
            master.name : master.percentage!
            ],  withCompletionBlock: {
                (error, ref) in
                if error != nil {
                    print(error)
                } else {
                    print("parent of " + group.id + " data saved successfully!")
                }
        })
        
        //get all other traits and add each to Firebase
        let children = master.children!
        for trait in children {
            //add main trait to the db
            //print(trait.name + " " + String(trait.percentage!) + " " + String(trait.samplingError!))
            self.addTrait(groupRef, trait: trait.name, percent: trait.percentage!, sampError: trait.samplingError!)
            
            //add subtraits if they exist
            if trait.children != nil {
                for subTrait in trait.children! {
                    //print(subTrait.name + " " + String(subTrait.percentage!) + " " + String(subTrait.samplingError!))
                    self.addTrait(groupRef, trait: subTrait.name, percent: subTrait.percentage!, sampError: subTrait.samplingError!)
                }
            }
        }
    }
    
    
    //outline for adding individual traits with a percent and sample_error to Firebase
    func addTrait(groupRef: FIRDatabaseReference, trait: String, percent: Double, sampError: Double) {
        let traitRef = groupRef.child(trait)
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