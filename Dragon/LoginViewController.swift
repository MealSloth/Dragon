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
    @IBOutlet weak var fieldEmail: UITextField!
    @IBOutlet weak var fieldPassword: UITextField!
    
    // MARK: Delegates
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.registerObservers()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == "Segue_LoginViewController->TabBarController")
        {
            (segue.destination as? UITabBarController)?.selectedIndex = 0
        }
    }
    
    // MARK: Observers
    func keyboardDidShow(_ notification: Notification)
    {
        if let keyboardSize = ((notification as NSNotification).userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        {
            if (self.scrollView.contentOffset.y == 0)
            {
                UIView.animate(withDuration: 0.25, animations: { () -> Void in
                    let insets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
                    self.scrollView.contentInset = insets
                    self.scrollView.scrollIndicatorInsets = insets
                    self.scrollView.contentOffset = CGPoint(x: self.scrollView.contentOffset.x, y: self.scrollView.contentOffset.y + keyboardSize.height)
                })
            }
        }
    }
    
    func keyboardWillHide(_ notification: Notification)
    {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        {
            UIView.animate(withDuration: 0.25, animations: { () -> Void in
                let insets: UIEdgeInsets = UIEdgeInsetsMake(self.scrollView.contentInset.top, 0, keyboardSize.height, 0)
                self.scrollView.contentInset = insets
                self.scrollView.scrollIndicatorInsets = insets
            })
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
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
        if let email: String = self.fieldEmail.text,
           let password: String = self.fieldPassword.text,
           let count = self.fieldPassword.text?.characters.count,
           count >= 8
        {
            UserRequest(withEmail: email).request(
                onCompletion: { (userResult: UserResult) -> Void in
                    UserLoginRequest(withUserID: userResult.user?.id).request(
                        onCompletion: { (userLoginResult: UserLoginResult) -> Void in
                            if let ulPassword = userLoginResult.password
                            {
                                if let uEmail = userResult.user?.email,
                                       uEmail == email,
                                       ulPassword == password
                                {
                                    self.segue()
                                }
                                else if let ulUsername = userLoginResult.userLogin?.username,
                                            ulUsername == email,
                                            ulPassword == password
                                {
                                    self.segue()
                                }
                                else
                                {
                                    Log.debug("Email or password is incorrect")
                                }
                            }
                            else
                            {
                                Log.debug("Email is nil or password is nil")
                            }
                        },
                        onError: { (error) -> Void in
                            Log.error("\(error)")
                        }
                    )
                },
                onError: { (error) -> Void in
                    Log.error("\(error)")
                }
            )
        }
        else
        {
            Log.debug("Email is nil, password is nil, or password is not >= 8 characters in length")
        }
    }
    
    @IBAction func continueBrowsing()
    {
        self.segue()
    }
    
    // MARK: Misc
    fileprivate func segue()
    {
        self.runOnMainThread({ () -> Void in
            self.performSegue(withIdentifier: "Segue_LoginViewController->TabBarController", sender: self)
        })
    }
    
    fileprivate func registerObservers()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardDidShow(_:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
}
