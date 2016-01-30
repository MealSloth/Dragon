//
//  SettingsViewController.swift
//  Dragon
//
//  Created by Michael Fourre on 10/3/15.
//  Copyright © 2015 MealSloth. All rights reserved.
//

import UIKit
import Parse

class SettingsViewController: UIViewController {
    
    @IBOutlet var mainView: UIView!
    @IBOutlet var contentView: UIView!
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    func displayAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        //create an alert, with a "OK" button. When press the button the alert will dismiss.
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)    //display the alert
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func logOut(sender: AnyObject) {
        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()    //during the process nothing else can be done
        
        PFUser.logOutInBackgroundWithBlock { (error) -> Void in
            self.activityIndicator.stopAnimating()      //stop the marker
            UIApplication.sharedApplication().endIgnoringInteractionEvents()
            
            var errorMessage = "Please try again later"
            
            if error == nil {
                
                //remember set the segue from the view controller, not the button, unless the segue will be executed twice.
                self.performSegueWithIdentifier("logout", sender: self)
                
            } else {
                
                if let errorString = error?.userInfo["error"] as? String {
                    errorMessage = errorString
                }
                self.displayAlert("Failed SignUp", message: errorMessage)
            }
        }
    }
    
    
    
}