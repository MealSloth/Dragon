//
//  KeyboardObservable.swift
//  Dragon
//
//  Created by Michael Fourre on 2/20/17.
//  Copyright © 2017 MealSloth. All rights reserved.
//

import NotificationCenter
import UIKit

@objc protocol KeyboardObservable {
    @objc func keyboardDidShow(_ notification: Notification)
    @objc func keyboardWillHide(_ notification: Notification)
}

extension KeyboardObservable {
    func observeKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDidShow(_:)), name: .UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
}
