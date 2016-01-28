//
//  ProfileViewController.swift
//  Dragon
//
//  Created by Michael Fourre on 10/3/15.
//  Copyright © 2015 MealSloth. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {
    
    var signupActive = true
    
    @IBOutlet var mainView: UIView!
    @IBOutlet var scrollView: UIScrollView!
    
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

    var screenHeight: CGFloat {
        get {
            return UIScreen.mainScreen().bounds.size.height
        }
    }
    var screenWidth: CGFloat {
        get {
            return UIScreen.mainScreen().bounds.size.width
        }
    }
    
    let sideMargin: CGFloat = 60.0
    
    var verticalViews = [Int:Any]()
    
    var profileChefName: String = "Yoshikazu Ono"
    var profileChefLocation: String = "Raleigh, NC"
    var profileChefDescription: String = "Trained sushi chef from Japan, now living in Raleigh, NC"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //createViews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func createViews()
    {
        /*Profile Image*/
        let profileImageView = UIImageView()
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.image = UIImage(named: "YoshikazuProfile")
        scrollView.addSubview(profileImageView)
        
        NSLayoutConstraint.activateConstraints([profileImageView.topAnchor.constraintEqualToAnchor(scrollView.topAnchor, constant: 30.0),
            profileImageView.centerXAnchor.constraintEqualToAnchor(scrollView.centerXAnchor)])
        
        verticalViews[0] = profileImageView
        
        /*Chef Name Label*/
        let labelChefName = UILabel()
        labelChefName.translatesAutoresizingMaskIntoConstraints = false
        labelChefName.text = profileChefName
        scrollView.addSubview(labelChefName)
        
        NSLayoutConstraint.activateConstraints([labelChefName.topAnchor.constraintEqualToAnchor(profileImageView.bottomAnchor, constant: 5.0),
            labelChefName.centerXAnchor.constraintEqualToAnchor(scrollView.centerXAnchor)])
        
        verticalViews[1] = labelChefName
        
        /*Chef Location Label*/
        let labelChefLocation = UILabel()
        labelChefLocation.translatesAutoresizingMaskIntoConstraints = false
        labelChefLocation.text = profileChefLocation
        scrollView.addSubview(labelChefLocation)
        
        NSLayoutConstraint.activateConstraints([labelChefLocation.topAnchor.constraintEqualToAnchor(labelChefName.bottomAnchor, constant: 5.0),
            labelChefLocation.centerXAnchor.constraintEqualToAnchor(scrollView.centerXAnchor)])
        
        verticalViews[2] = labelChefLocation
        
        /*Chef Description Label*/
        let labelChefDescription = UILabel()
        labelChefDescription.translatesAutoresizingMaskIntoConstraints = false
        labelChefDescription.text = profileChefDescription
        labelChefDescription.textAlignment = NSTextAlignment.Center
        labelChefDescription.lineBreakMode = NSLineBreakMode.ByWordWrapping
        labelChefDescription.numberOfLines = 0
        scrollView.addSubview(labelChefDescription)
        
        NSLayoutConstraint.activateConstraints([labelChefDescription.topAnchor.constraintEqualToAnchor(labelChefLocation.bottomAnchor, constant: 8.0),
            labelChefDescription.centerXAnchor.constraintEqualToAnchor(scrollView.centerXAnchor),
            labelChefDescription.widthAnchor.constraintEqualToConstant(screenWidth - sideMargin)])
        
        verticalViews[3] = labelChefDescription
    }
    
}