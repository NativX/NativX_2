//
//  HomeViewController.swift
//  NativX_2
//
//  Created by Sean Coleman on 5/31/16.
//  Copyright © 2016 Sean Coleman. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    @IBOutlet weak var logOutButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // logout button
    @IBAction func logOutTap(sender: UIButton) {
        try! FIRAuth.auth()!.signOut()
        
        print("logged out")
        self.performSegueWithIdentifier("logOutToHome", sender: self)
    }

}
