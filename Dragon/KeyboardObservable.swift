//
//  KeyboardObservable.swift
//  Dragon
//
//  Created by Michael Fourre on 2/20/17.
//  Copyright © 2017 MealSloth. All rights reserved.
//

import NotificationCenter
import UIKit

// KeyboardObservable provides an interface for observing keyboard actions with the only requirements being that the adopting controller
// implement the `startObservingKeyboard()` and `stopObservingKeyboard()` functions where appropriate. For a UIViewController class which
// adopts KeyboardObservable, it is standard to start and stop observing in the `viewDidAppear(_:)` and `viewDidDisappear(_:)` functions
@objc protocol KeyboardObservable {
    @objc func keyboardDidShow(_ notification: Notification)
    @objc func keyboardWillHide(_ notification: Notification)
}

extension KeyboardObservable {
    func startObservingKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDidShow(_:)), name: .UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func stopObservingKeyboard() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardDidShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
}
