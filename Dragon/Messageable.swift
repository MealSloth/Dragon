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
    
    static func display(text: String?) {
        guard let message = text else { return }
        MainQueue.sync({ () -> Void in
            _ = self.view // Preload UI
            self.view.label.text = message
            UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut,
                animations: { () -> Void in
                    self.view.container.alpha = 1.0
                },
                completion: { (_) -> Void in
                    UIView.animate(withDuration: 0.3, delay: 5.0, options: .curveEaseOut,
                        animations: { () -> Void in
                            self.view.container.alpha = 0.0
                        }
                    )
                }
            )
        })
    }
}
