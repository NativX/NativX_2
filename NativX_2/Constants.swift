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



