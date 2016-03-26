//
//  LoginViewController.swift
//  Dragon
//
//  Created by Hongyi on 16/1/26.
//  Copyright © 2016年 MealSloth. All rights reserved.
//

import UIKit
import CoreData
import Parse

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

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
    
    func isLogin(email:String, inputPassword:String) -> Bool {
        
        let json1 = ["email":email]
        let result:NSDictionary = APIOperations.postRequest(json1, url: "http://api.mealsloth.com/user/")
        
        let user_login_id = result["user"]!["user_login_id"] as! String
        
        let json2 = ["user_login_id" : user_login_id]
        let password = APIOperations.postRequest(json2, url: "http://api.mealsloth.com/user-login/")

        return inputPassword == (password["user_login"]!["password"] as! String)
    }
    
    func createUserModel(result : NSDictionary) {
        
        let newUser = NSEntityDescription.insertNewObjectForEntityForName("User",inManagedObjectContext:self.context) as NSManagedObject
        
        newUser.setValue(result["user"]!["first_name"] as! String, forKey: "first_name")
        newUser.setValue(result["user"]!["last_name"] as! String, forKey: "last_name")
        newUser.setValue(result["user"]!["gender"] as! Int, forKey: "gender")
        newUser.setValue(result["user"]!["phone_number"] as! String, forKey: "phone_number")
        newUser.setValue(result["user"]!["id"] as! String, forKey: "id")
        newUser.setValue(result["user"]!["email"] as! String, forKey: "email")
        newUser.setValue(result["user"]!["date_of_birth"] as! String, forKey: "date_of_birth")
        
        do{
            try self.context.save()
        }catch{
            print("there is a problem!")
        }
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
            
            if signupActive == true {    //sign up
                
                let createJson = ["email":self.username.text!, "password":self.password.text!]
                let createResult:NSDictionary = APIOperations.postRequest(createJson, url: "http://api.mealsloth.com/user/create/")
                
                self.activityIndicator.stopAnimating()    //stop marker
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
                
                if(createResult["message"] as! String == "Success"){
                    createUserModel(createResult)
                    self.performSegueWithIdentifier("login", sender: self)
                }else{
                    self.displayAlert("Failed", message: "Please try later")
                }
                
            } else {      //login here
                
                let loginFlag = isLogin(username.text!, inputPassword: password.text!)
                
                self.activityIndicator.stopAnimating()
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
                
                if(loginFlag){
                    
                    let json = ["email":self.username.text!]
                    let result:NSDictionary = APIOperations.postRequest(json, url: "http://api.mealsloth.com/user/")
                    createUserModel(result)
                    
                    self.performSegueWithIdentifier("login", sender: self)
                }else{
                    self.displayAlert("Failed Login", message: "invalid username or password")
                }
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
    
/*
    {
    message = Success;
    result = 1000;
    user =     {
    "billing_id" = "f681ff55-7624-4480-9b27-b27d2dd711c4";
    "chef_id" = "ec22e17b-244f-43fb-a6e3-1a228bdde921";
    "consumer_id" = "eaae5126-3717-49d7-a523-b4123efa7f1a";
    "date_of_birth" = "1900-01-01T00:00:00.000000";
    email = "hongyi@abc.com";
    "first_name" = Hongyi;
    gender = 0;
    id = "076f4ce8-86d8-4c3f-b581-60f5a5c014b3";
    "join_date" = "2016-02-13T00:10:17.068650";
    "last_name" = Test;
    "location_id" = "54188796-54a6-4df7-ac75-00e047e9d60e";
    "phone_number" = 1234567890;
    "profile_photo_id" = "c7f5c6ff-df64-4c48-896c-5cf94293ff4d";
    "user_login_id" = "01212204-2c12-46bb-a94f-7fa6fa70f0ff";
    };
    }
*/
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //keyboard control
        self.username.delegate = self
        self.password.delegate = self

    }
    
    override func viewDidAppear(animated: Bool) {
        
        if DatabaseOperations.userAlreadyLogin() {
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
