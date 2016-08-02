//
//  BaseGlobal.swift
//  NativX_2
//
//  Created by Sean Coleman on 5/20/16.
//  Copyright © 2016 Sean Coleman. All rights reserved.
//

import Foundation
import Firebase

// database url
let BASE_URL = "https://project-4293806605945612732.firebaseio.com/"

// facebook permissions
let perm = ["public_profile", "email", "user_about_me", "user_likes", "user_tagged_places", "user_location", "user_hometown", "user_events", "user_birthday", "user_status", "user_posts"]

// database reference
let ref = FIRDatabase.database().reference()

// Personality Insights Username and Password
let ibmUsername = "764ad7bc-5d1d-4e68-8969-37a4a43e3009"
let ibmPassword = "sA6IrVsa6dgL"

//let ibmUsername = "599d30f0-89e2-4d59-bd9b-11919b4b9ebc"
//let ibmPassword = "LJwNxRuuBPlf"

let nativxColor = UIColor(red: 94/255 , green: 200/255, blue: 210/255, alpha: 1)

let nativxGrey = UIColor(red: 81/255, green: 77/255, blue: 77/255, alpha: 1)
