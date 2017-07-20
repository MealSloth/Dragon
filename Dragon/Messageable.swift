//
//  Messageable.swift
//  Dragon
//
//  Created by Michael Fourre on 2/20/17.
//  Copyright © 2017 MealSloth. All rights reserved.
//

import UIKit

protocol Messageable {}

extension Messageable {
    static var view: MessageableView {
        return MessageableView.shared
    }
    
    static var duration: Double {
        return 5.0
    }
    
    static var speed: Double {
        return 0.5
    }
    
    static func display(text: String?, duration: TimeInterval? = nil) {
        guard let message = text else { return }
        self.view.label.text = message
        self.show(text: text, duration: duration)
    }
    
    fileprivate static func show(text: String?, duration: TimeInterval?) {
        UIView.animate(withDuration: self.speed, delay: 0.0, options: .curveEaseOut,
            animations: { () -> Void in
                self.view.show()
            },
            completion: { (_) -> Void in
                UIView.animate(withDuration: self.speed, delay: duration ?? self.duration, options: .curveEaseOut,
                    animations: { () -> Void in
                        self.view.hide()
                    }
                )
            }
        )
    }
}
