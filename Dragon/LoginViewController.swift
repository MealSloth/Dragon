//
//  LoginViewController.swift
//  Dragon
//
//  Created by Michael Fourre on 4/29/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController
{
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var buttonSignUp: UIButton!
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var buttonContinueBrowsing: UIButton!
    @IBOutlet weak var fieldEmail: UITextField!
    @IBOutlet weak var fieldPassword: UITextField!
    
    var signUpMode: Bool = false
    
    // MARK: Delegates
    override func viewDidLoad()
    {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginViewController.keyboardDidShow(_:)), name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if (segue.identifier == "Segue_LoginViewController->TabBarController")
        {
            (segue.destinationViewController as? UITabBarController)?.selectedIndex = 1
        }
    }
    
    // MARK: Observers
    func keyboardDidShow(notification: NSNotification)
    {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue()
        {
            if (self.scrollView.contentOffset.y == 0)
            {
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    let insets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
                    self.scrollView.contentInset = insets
                    self.scrollView.scrollIndicatorInsets = insets
                    self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x, self.scrollView.contentOffset.y + keyboardSize.height)
                })
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification)
    {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue()
        {
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                let insets: UIEdgeInsets = UIEdgeInsetsMake(self.scrollView.contentInset.top, 0, keyboardSize.height, 0)
                self.scrollView.contentInset = insets
                self.scrollView.scrollIndicatorInsets = insets
            })
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        if (textField == self.fieldEmail)
        {
            self.fieldPassword.becomeFirstResponder()
        }
        else
        {
            textField.resignFirstResponder()
        }
        return false
    }
    
    // MARK: Buttons
    @IBAction func login()
    {
        if let email: String = self.fieldEmail.text, password: String = self.fieldPassword.text where self.fieldPassword.text?.characters.count >= 8
        {
            if self.signUpMode
            {
                UserCreateRequest(withEmail: email, andPassword: password).request(
                    onCompletion: { (result) -> Void in
                        self.segue()
                    },
                    onError: { (error) -> Void in
                        Log.error(error)
                })
            }
            else
            {
                UserRequest(withEmail: email).request(
                    onCompletion: { (userResult) -> Void in
                        UserLoginRequest(withUserID: userResult.user.id).request(
                            onCompletion: { (userLoginResult) -> Void in
                                if let uEmail = userResult.user.email, ulPassword = userLoginResult.userLogin.password
                                {
                                    if uEmail == email && ulPassword == password
                                    {
                                        self.segue()
                                    }
                                    else
                                    {
                                        Log.string("Email or password is incorrect", type: .debug)
                                    }
                                }
                                else
                                {
                                    Log.string("Email is nil or password is nil", type: .debug)
                                }
                            },
                            onError: { (error) -> Void in
                                Log.error(error)
                            }
                        )
                    },
                    onError: { (error) -> Void in
                        Log.error(error)
                    }
                )
            }
        }
        else
        {
            Log.string("Email is nil, password is nil, or password is not >= 8 characters in length", type: .debug)
        }
    }
    
    @IBAction func signUp()
    {
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            self.signUpMode = !self.signUpMode
            self.buttonContinueBrowsing.alpha = (self.signUpMode) ? 0.0 : 1.0
            self.buttonContinueBrowsing.hidden = self.signUpMode
            self.buttonLogin.setTitle((self.signUpMode) ? "SIGN UP" : "LOGIN", forState: UIControlState.Normal)
            self.buttonSignUp.setTitle((self.signUpMode) ? "< BACK" : "SIGN UP", forState: UIControlState.Normal)
        })
    }
    
    @IBAction func continueBrowsing()
    {
        self.segue()
    }
    
    // MARK: Misc
    func segue()
    {
        self.performSegueWithIdentifier("Segue_LoginViewController->TabBarController", sender: self)
    }
}