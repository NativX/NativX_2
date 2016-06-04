//
//  RegisterViewController.swift
//  NativX_2
//
//  Created by Sean Coleman on 5/19/16.
//  Copyright © 2016 Sean Coleman. All rights reserved.
//
import UIKit
import Firebase

// this view controller needs to have email, facebook, and twitter login functionality
// we need to save it to a database of our choice

class RegisterPageViewController: UIViewController {
    
    
    @IBOutlet weak var textFirstName: UITextField!
    @IBOutlet weak var textLastName: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    @IBOutlet weak var textEmail: UITextField!
    @IBOutlet weak var textConfirmPassword: UITextField!
    
    let ref = FIRDatabase.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // To store signup information
    
    // Error Handling Function
    func alertUser (title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        
        alertController.addAction(defaultAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func signupTapped(sender: UIButton) {
        // Variables for reference + storage
        let email:NSString = textEmail.text!
        let password:NSString = textPassword.text!
        let confirm_password:NSString = textConfirmPassword.text!
        let first:NSString = textFirstName.text!
        let last: NSString = textLastName.text!
        
        
        // Check for empty fields
        if ( email.isEqualToString("") || password.isEqualToString("") || first.isEqualToString("") || last.isEqualToString("")) {
 
            alertUser ("Registration Failed", message: "You must have left something blank")
            
        }
            
            // Case that passwords do not match
        else if ( !password.isEqual(confirm_password) ) {
            
            alertUser("Registration Failed", message: "Passwords Do Not Match")
        }
        else {
            FIRAuth.auth()?.createUserWithEmail(textEmail.text! , password: textPassword.text!, completion: {
                user, error in
                
                if error != nil {
                    
                    self.alertUser("There was a problem", message: "The email you entered is either invalid or already in use. Please try again")
                    
                }
                else {
                    print("User Created")
                    FIRAuth.auth()?.signInWithEmail(self.textEmail.text!, password: self.textPassword.text!, completion: {
                        
                        user, error in
                        
                        if error != nil {

                            self.alertUser("There was a problem", message: "The email or password you entered was incorrect. Please try again")
                        }
                        else {
                            print("user logged in")
                        }
                    })
                }
            })
            }
        }
    }