//
//  loginPgViewController.swift
//  NativX_2
//
//  Created by Sean Coleman on 5/19/16.
//  Copyright © 2016 Sean Coleman. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit

class LoginPageViewController: UIViewController {
    @IBOutlet weak var noAccountTapped: UIButton!
    @IBOutlet weak var emailLoginText: UITextField!
    @IBOutlet weak var passwordLoginText: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var register: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

       

        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func LoginTapped(sender: UIButton) {
        
        let email:NSString = emailLoginText.text!
        let password:NSString = passwordLoginText.text!
        
        // left something blank
        if (email.isEqualToString("") || password.isEqualToString("") ) {
            
            let alertController = UIAlertController(title: "Sign In Failed!", message: "Please Enter a Valid Email and Password", preferredStyle: .Alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            
            alertController.addAction(defaultAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
        } else{
            
            FIRAuth.auth()?.signInWithEmail(emailLoginText.text!, password: passwordLoginText.text!, completion: {
                
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
        }/** else {
         
         do {
         let post:NSString = "email=\(email)&password=\(password)"
         
         NSLog("PostData: %@",post);
         
         // this is where we will choose a URL to send the information or retrieve it
         //let url:NSURL = NSURL(string: "Custom URL that we have to choose")!
         
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
         NSLog("Login SUCCESS");
         
         let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
         prefs.setObject(email, forKey: "EMAIL")
         prefs.setInteger(1, forKey: "ISLOGGEDIN")
         prefs.synchronize()
         
         self.dismissViewControllerAnimated(true, completion: nil)
         } else {
         var error_msg:NSString
         
         if jsonData["error_message"] as? NSString != nil {
         error_msg = jsonData["error_message"] as! NSString
         } else {
         error_msg = "Unknown Error"
         }
         let alertView:UIAlertView = UIAlertView()
         alertView.title = "Sign in Failed!"
         alertView.message = error_msg as String
         alertView.delegate = self
         alertView.addButtonWithTitle("OK")
         alertView.show()
         
         }
         
         } else {
         let alertView:UIAlertView = UIAlertView()
         alertView.title = "Sign in Failed!"
         alertView.message = "Connection Failed"
         alertView.delegate = self
         alertView.addButtonWithTitle("OK")
         alertView.show()
         }
         } else {
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
         alertView.title = "Sign in Failed!"
         alertView.message = "Server Error"
         alertView.delegate = self
         alertView.addButtonWithTitle("OK")
         alertView.show()
         }
         }
         } */
    }} // ****** added one } ******





/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */
