//
//  KeyboardScrollable.swift
//  Dragon
//
//  Created by Michael Fourre on 2/20/17.
//  Copyright © 2017 MealSloth. All rights reserved.
//

import UIKit

@objc protocol KeyboardScrollable: KeyboardObservable {
    var scrollView: UIScrollView! { get set }
}

// Due to NotificationCenter's use of archaic selectors, these functions must be implemented as an extension of the original UIViewController
// class instead of as an extension of KeyboardScrollable; this allows the functions to remain visible to Objective-C but carries with it the
// negative effect of cluttering the UIViewController API with functions which may not be relevant unless the class adopts KeyboardScrollable
extension UIViewController { // optionally `extension KeyboardScrollable` if keyboard changes ever stop using selectors or NotificationCenter
    func keyboardDidShow(_ notification: Notification) {
        guard let controller = self as? KeyboardScrollable else { return } // can be removed once keyboard changes stop using selectors
        guard let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue else { return }
        if controller.scrollView.contentOffset.y == 0 {
            UIView.animate(withDuration: 0.25, animations: { () -> Void in
                let insets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
                controller.scrollView.contentInset = insets
                controller.scrollView.scrollIndicatorInsets = insets
                controller.scrollView.contentOffset = CGPoint(x: controller.scrollView.contentOffset.x, y: controller.scrollView.contentOffset.y + keyboardSize.height)
            })
        }
    }
    
    func keyboardWillHide(_ notification: Notification) {
        guard let controller = self as? KeyboardScrollable else { return } // can be removed once keyboard changes stop using selectors
        guard let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue else { return }
        UIView.animate(withDuration: 0.25, animations: { () -> Void in
            let insets = UIEdgeInsetsMake(controller.scrollView.contentInset.top, 0, keyboardSize.height, 0)
            controller.scrollView.contentInset = insets
            controller.scrollView.scrollIndicatorInsets = insets
        })
    }
}
