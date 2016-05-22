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
    
    @IBAction func signupTapped(sender: UIButton) {
        // Variables for reference + storage
        let email:NSString = textEmail.text!
        let password:NSString = textPassword.text!
        let confirm_password:NSString = textConfirmPassword.text!
        let first:NSString = textFirstName.text!
        let last: NSString = textLastName.text!
        
        
        // Check for empty fields
        if ( email.isEqualToString("") || password.isEqualToString("") || first.isEqualToString("") || last.isEqualToString("")) {
            let alertController = UIAlertController(title: "Sign In Failed!", message: "You must have left something blank!", preferredStyle: .Alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            
            alertController.addAction(defaultAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
            
            // Case that passwords do not match
        else if ( !password.isEqual(confirm_password) ) {
            
            let alertController = UIAlertController(title: "Sign In Failed!", message: "Passwords Do Not Match", preferredStyle: .Alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            
            alertController.addAction(defaultAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        else {
            FIRAuth.auth()?.createUserWithEmail(textEmail.text! , password: textPassword.text!, completion: {
                user, error in
                
                if error != nil {
                    let alertController = UIAlertController(title: "There was a problem", message: "Your email is either invalid or already in use. Please try again", preferredStyle: .Alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    
                    alertController.addAction(defaultAction)
                    
                    self.presentViewController(alertController, animated: true, completion: nil)                }
                else {
                    print("User Created")
                    FIRAuth.auth()?.signInWithEmail(self.textEmail.text!, password: self.textPassword.text!, completion: {
                        
                        user, error in
                        
                        if error != nil {
                            let alertController = UIAlertController(title: "There was a problem", message: "Your email or password was incorrect. Please try again.", preferredStyle: .Alert)
                            
                            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                            
                            alertController.addAction(defaultAction)
                            
                            self.presentViewController(alertController, animated: true, completion: nil)
                        }
                        else {
                            print("user logged in")
                        }
                    })
                }
            })
        }
        }
    
        /* else {
         do {
         
         let post:NSString = "email=\(email)&password=\(password)&c_password=\(confirm_password)"
         
         NSLog("PostData: %@",post);
         // this is where we will point our Signup data to be stored and retrieved
         // insert custom url here to store data let url:NSURL = NSURL(string:"Custom URL is inserted here")!
         
         let postData:NSData = post.dataUsingEncoding(NSASCIIStringEncoding)!
         
         let postLength:NSString = String( postData.length )
         
         let request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
         request.HTTPMethod = "POST"
         request.HTTPBody = postData
         request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
         request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
         request.setValue("application/json", forHTTPHeaderField: "Accept")
         
         
         var reponseError: NSError?
         var response: NSURLResponse?
         
         var urlData: NSData?
         do {
         urlData = try NSURLConnection.sendSynchronousRequest(request, returningResponse:&response)
         } catch let error as NSError {
         reponseError = error
         urlData = nil
         }
         
         if ( urlData != nil ) {
         let res = response as! NSHTTPURLResponse!;
         
         NSLog("Response code: %ld", res.statusCode);
         
         if (res.statusCode >= 200 && res.statusCode < 300)
         {
         let responseData:NSString  = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!
         
         NSLog("Response ==> %@", responseData);
         
         //var error: NSError?
         
         let jsonData:NSDictionary = try NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers ) as! NSDictionary
         
         
         let success:NSInteger = jsonData.valueForKey("success") as! NSInteger
         
         //[jsonData[@"success"] integerValue];
         
         NSLog("Success: %ld", success);
         
         if(success == 1)
         {
         NSLog("Sign Up SUCCESS");
         self.performSegueWithIdentifier("link_social", sender: self)
         } else {
         var error_msg:NSString
         
         if jsonData["error_message"] as? NSString != nil {
         error_msg = jsonData["error_message"] as! NSString
         } else {
         error_msg = "Unknown Error"
         }
         let alertView:UIAlertView = UIAlertView()
         alertView.title = "Sign Up Failed!"
         alertView.message = error_msg as String
         alertView.delegate = self
         alertView.addButtonWithTitle("OK")
         alertView.show()
         
         }
         
         } else {
         let alertView:UIAlertView = UIAlertView()
         alertView.title = "Sign Up Failed!"
         alertView.message = "Connection Failed"
         alertView.delegate = self
         alertView.addButtonWithTitle("OK")
         alertView.show()
         }
         }  else {
         let alertView:UIAlertView = UIAlertView()
         alertView.title = "Sign in Failed!"
         alertView.message = "Connection Failure"
         if let error = reponseError {
         alertView.message = (error.localizedDescription)
         }
         alertView.delegate = self
         alertView.addButtonWithTitle("OK")
         alertView.show()
         }
         } catch {
         let alertView:UIAlertView = UIAlertView()
         alertView.title = "Sign Up Failed!"
         alertView.message = "Server Error!"
         alertView.delegate = self
         alertView.addButtonWithTitle("OK")
         alertView.show()
         }
         }
         }
         
         @IBAction func gotoLogin(sender: AnyObject) {
         self.dismissViewControllerAnimated(true, completion: nil)
         }
         
         
         
         /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
         // Get the new view controller using segue.destinationViewController.
         // Pass the selected object to the new view controller.
         }
         */
         
         }
         */}