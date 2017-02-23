//
//  UIView+.swift
//  Dragon
//
//  Created by Michael Fourre on 2/22/17.
//  Copyright © 2017 MealSloth. All rights reserved.
//

import UIKit

extension UIView {
    var visible: Bool {
        get {
            return self.alpha > 0.0
        }
        set {
            self.alpha = newValue ? 1.0 : 0.0
        }
    }
}
