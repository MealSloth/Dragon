//
//  LoginViewController.swift
//  Dragon
//
//  Created by Michael Fourre on 4/29/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, KeyboardScrollable {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var fieldEmail: UITextField!
    @IBOutlet weak var fieldPassword: UITextField!
    
    // MARK: Delegates
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.startObservingKeyboard()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.stopObservingKeyboard()
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
    
    // MARK: UITextField Delegates
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        _ = self.fieldEmail == textField ? self.fieldPassword.becomeFirstResponder() : textField.resignFirstResponder()
        return false
    }
    
    // MARK: Buttons
    @IBAction func login() {
        guard let email = self.fieldEmail.text, let password = self.fieldPassword.text, password.characters.count >= 8 else {
            Message(.errorIncorrectUsernameOrPassword).display()
            return
        }
        UserLoginRequest(withUsername: email).request(
            onCompletion: { (userLoginResult) -> Void in
                guard userLoginResult.valid(username: email, password: password) else {
                    Message(.errorIncorrectUsernameOrPassword).display()
                    return
                }
                self.segue()
            },
            onError: { (_) -> Void in
                Message(.errorTryAgainLater).display()
            }
        )
    }
    
    // MARK: Misc
    fileprivate func segue() {
        self.segue(withIdentifier: "Segue_LoginViewController->TabBarController", sender: self)
    }
}
