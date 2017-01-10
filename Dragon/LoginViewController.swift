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
        if segue.identifier == "Segue_LoginViewController->TabBarController"
        {
            (segue.destination as? UITabBarController)?.selectedIndex = 0
        }
    }
    
    // MARK: Observers
    func keyboardDidShow(_ notification: Notification)
    {
        guard let keyboardFrame = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue else { return }
        let keyboardSize = keyboardFrame.cgRectValue
        if self.scrollView.contentOffset.y == 0
        {
            UIView.animate(withDuration: 0.25, animations: { () -> Void in
                let insets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
                self.scrollView.contentInset = insets
                self.scrollView.scrollIndicatorInsets = insets
                self.scrollView.contentOffset = CGPoint(x: self.scrollView.contentOffset.x, y: self.scrollView.contentOffset.y + keyboardSize.height)
            })
        }
    }
    
    func keyboardWillHide(_ notification: Notification)
    {
        guard let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        UIView.animate(withDuration: 0.25, animations: { () -> Void in
            let insets = UIEdgeInsetsMake(self.scrollView.contentInset.top, 0, keyboardSize.height, 0)
            self.scrollView.contentInset = insets
            self.scrollView.scrollIndicatorInsets = insets
        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        _ = self.fieldEmail == textField ? self.fieldPassword.becomeFirstResponder() : textField.resignFirstResponder()
        return false
    }
    
    // MARK: Buttons
    @IBAction func login()
    {
        guard let email = self.fieldEmail.text,
            let password = self.fieldPassword.text,
            let count = self.fieldPassword.text?.characters.count,
            count >= 8 else
        {
            Log.debug("Email is nil, password is nil, or password is not >= 8 characters in length")
            return
        }
        
        UserRequest(withEmail: email).request(
            onCompletion: { (userResult: UserResult) -> Void in
                UserLoginRequest(withUserID: userResult.user?.id).request(
                    onCompletion: { (userLoginResult: UserLoginResult) -> Void in
                        guard userLoginResult.password == password else
                        {
                            Log.debug("Password is incorrect")
                            return
                        }
                        guard userResult.user?.email == email || userLoginResult.userLogin?.username == email else
                        {
                            Log.debug("Email is incorrect")
                            return
                        }
                        self.segue()
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
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(_:)), name: .UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
}
