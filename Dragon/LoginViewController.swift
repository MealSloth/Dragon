//
//  LoginViewController.swift
//  Dragon
//
//  Created by Michael Fourre on 4/29/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var fieldEmail: UITextField!
    @IBOutlet weak var fieldPassword: UITextField!
    
    // MARK: Delegates
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(_:)), name: .UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        switch identifier {
            case "Segue_LoginViewController->TabBarController":
                (segue.destination as? UITabBarController)?.selectedIndex = 0
                break
            default:
                break
        }
    }
    
    // MARK: Observers
    func keyboardDidShow(_ notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue else { return }
        if self.scrollView.contentOffset.y == 0 {
            UIView.animate(withDuration: 0.25, animations: { () -> Void in
                let insets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
                self.scrollView.contentInset = insets
                self.scrollView.scrollIndicatorInsets = insets
                self.scrollView.contentOffset = CGPoint(x: self.scrollView.contentOffset.x, y: self.scrollView.contentOffset.y + keyboardSize.height)
            })
        }
    }
    
    func keyboardWillHide(_ notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue else { return }
        UIView.animate(withDuration: 0.25, animations: { () -> Void in
            let insets = UIEdgeInsetsMake(self.scrollView.contentInset.top, 0, keyboardSize.height, 0)
            self.scrollView.contentInset = insets
            self.scrollView.scrollIndicatorInsets = insets
        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        _ = self.fieldEmail == textField ? self.fieldPassword.becomeFirstResponder() : textField.resignFirstResponder()
        return false
    }
    
    // MARK: Buttons
    @IBAction func login() {
        guard let email = self.fieldEmail.text, let password = self.fieldPassword.text else { return }
        guard let count = self.fieldPassword.text?.characters.count, count >= 8 else { return }
        UserRequest(withEmail: email).request(
            onCompletion: { (userResult: UserResult) -> Void in
                UserLoginRequest(withUserID: userResult.user?.id).request(
                    onCompletion: { (userLoginResult: UserLoginResult) -> Void in
                        guard userLoginResult.password == password else { return }
                        guard userResult.user?.email == email || userLoginResult.userLogin?.username == email else { return }
                        self.segue()
                    }
                )
            }
        )
    }
    
    // MARK: Misc
    fileprivate func segue() {
        self.segue(withIdentifier: "Segue_LoginViewController->TabBarController", sender: self)
    }
}
