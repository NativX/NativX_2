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
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    func load_image(urlString:String)
    {
        let imgURL: NSURL = NSURL(string: urlString)!
        let request: NSURLRequest = NSURLRequest(URL: imgURL)
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request){
            (data, response, error) -> Void in
            
            if (error == nil && data != nil)
            {
                func display_image()
                {
                    self.userImage.image = UIImage(data: data!)
                }
                
                dispatch_async(dispatch_get_main_queue(), display_image)
            }
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        FIRAuth.auth()?.addAuthStateDidChangeListener { auth, user in
            if let user = user {
                // User is signed in
                for profile in user.providerData {
                    
                    print("yes")
                    let name = profile.displayName
                    self.userName.text = name
                    // let url = (profile.photoURL)?.absoluteString
                    // self.load_image(url!)
                }
            } else {
                // No user is signed in.
                print("nope")
            }
        }
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
