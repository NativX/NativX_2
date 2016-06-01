//
//  ProtectedViewController.swift
//  NativX_2
//
//  Created by Sean Coleman on 5/19/16.
//  Copyright © 2016 Sean Coleman. All rights reserved.
//

import UIKit
import Firebase


class ProtectedViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        if ((FIRAuth.auth()?.currentUser) != nil) {
            self.performSegueWithIdentifier("goto_home", sender: self)
        } else {
            self.performSegueWithIdentifier("goto_login", sender: self)
        }
        
    }

}
