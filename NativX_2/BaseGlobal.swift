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
let BASE_URL = "https://luminous-fire-6961.firebaseio.com/"

// database reference
let ref = FIRDatabase.database().reference()

// current user information
/* var CURRENT_USER: FIRDatabase
{
    let userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
    
   let currentUser = FIRDatabaseReference.setValue.childByAppendingPath("users").childByAppendingPath(userID)
    
    return currentUser!
} */
