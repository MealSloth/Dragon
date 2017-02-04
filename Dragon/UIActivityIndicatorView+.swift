//
//  UIActivityIndicatorView+.swift
//  Dragon
//
//  Created by Michael Fourre on 10/15/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import UIKit

extension UIActivityIndicatorView {
    func disable() {
        self.isHidden = true
        self.stopAnimating()
    }
    
    func enable() {
        self.isHidden = false
        self.startAnimating()
    }
}
