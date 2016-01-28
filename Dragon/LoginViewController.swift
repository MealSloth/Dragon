//
//  LoginViewController.swift
//  Dragon
//
//  Created by Hongyi on 16/1/26.
//  Copyright © 2016年 MealSloth. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController, UITextFieldDelegate {

    var signupActive = true
    
    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    
    @IBOutlet var signupButton: UIButton!
    @IBOutlet var loginButton: UIButton!
    
    @IBOutlet var registeredText: UILabel!
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    func displayAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        //create an alert, with a "OK" button. When press the button the alert will dismiss.
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)    //display the alert
        
    }
    
    @IBAction func signUp(sender: AnyObject) {
        if username.text == "" || password.text == "" {
            
            displayAlert("Error in form", message: "Please enter a username and a password")
            
        } else {
            
            //a small marker to indicate that the sign up process is running
            activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()    //during the process nothing else can be done
            
            var errorMessage = "Please try again later"
            
            if signupActive == true {
                
                let user = PFUser()
                user.username = username.text
                user.password = password.text
                
                user.signUpInBackgroundWithBlock({ (success, error) -> Void in
                    self.activityIndicator.stopAnimating()      //stop the marker
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    if error == nil {
                        
                        self.performSegueWithIdentifier("login", sender: self)
                        
                    } else {
                        
                        if let errorString = error?.userInfo["error"] as? String {
                            errorMessage = errorString
                        }
                        self.displayAlert("Failed SignUp", message: errorMessage)
                    }
                })
                
            } else {
                
                PFUser.logInWithUsernameInBackground(username.text!, password: password.text!, block: { (user, error) -> Void in
                    
                    self.activityIndicator.stopAnimating()      //stop the marker
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    if user != nil{
                        
                        self.performSegueWithIdentifier("login", sender: self)
                        
                    } else {
                        if let errorString = error?.userInfo["error"] as? String {
                            errorMessage = errorString
                        }
                        self.displayAlert("Failed Login", message: errorMessage)
                    }
                    
                })
            }
        }
    }
    
    @IBAction func logIn(sender: AnyObject) {
    
        if signupActive == true {
            signupButton.setTitle("Log In", forState: UIControlState.Normal)
            registeredText.text = "Not registered?"
            loginButton.setTitle("Sign Up", forState: UIControlState.Normal)
            
            signupActive = false
        } else {
            signupButton.setTitle("Sign Up", forState: UIControlState.Normal)
            registeredText.text = "Already registered?"
            loginButton.setTitle("Login", forState: UIControlState.Normal)
            
            signupActive = true
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //keyboard control
        self.username.delegate = self
        self.password.delegate = self
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        if PFUser.currentUser() != nil {
            self.performSegueWithIdentifier("login", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //these two functions are for keyboard control
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
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
