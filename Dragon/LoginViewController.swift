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
        self.observeKeyboard()
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
