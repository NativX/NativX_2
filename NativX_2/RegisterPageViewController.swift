//
//  RegisterViewController.swift
//  NativX_2
//
//  Created by Sean Coleman on 5/19/16.
//  Copyright © 2016 Sean Coleman. All rights reserved.
//
import UIKit
import Firebase

class RegisterPageViewController: UIViewController {
    
    @IBOutlet weak var textFirstName: UITextField!
    @IBOutlet weak var textLastName: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    @IBOutlet weak var textEmail: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addBackground ("background1")
        
        // background view
        registerView.layer.cornerRadius = 8.0
        
        // register
        signUpButton.layer.cornerRadius = 5
        signUpButton.layer.borderWidth = 1
    }
    
    @IBAction func signUp (sender: AnyObject) {
            
        // Variables for reference + storage
        let email:NSString = textEmail.text!
        let password:NSString = textPassword.text!
        let first:NSString = textFirstName.text!
        let last: NSString = textLastName.text!
        
        // empty fields
        if ( email.isEqualToString("") || password.isEqualToString("") || first.isEqualToString("") || last.isEqualToString("")) {
            alertUser ("Registration Failed", message: "You must have left something blank")
        }
        else {
            FIRAuth.auth()?.createUserWithEmail(textEmail.text!, password: textPassword.text!, completion: {
                    user, error in
                    
                if error != nil {
                    self.alertUser("There was a problem", message: "The email you entered is either invalid or already in use. Please try again")
                }
                else {
                    FIRAuth.auth()?.signInWithEmail(self.textEmail.text!, password: self.textPassword.text!, completion: {
                            
                        user, error in
                        
                        if error != nil {
                            self.alertUser("There was a problem", message: "The email or password you entered was incorrect. Please try again")
                        }
                        else {
                            guard let uid = user?.uid else {
                                return
                            }
                            // Add Basic Info to Database
                            let usersRef = ref.child("users").child(uid)
                            let basic = ["first": first,
                                         "email": email]
                            
                            usersRef.updateChildValues(basic, withCompletionBlock: {
                                    (err, ref) in
                                
                                if err != nil {
                                    print (err)
                                    return
                                }
                            })
                            self.performSegueWithIdentifier("toLinkSocial", sender:self)
                        }
                    })
                }
            })
        }
    }
}







