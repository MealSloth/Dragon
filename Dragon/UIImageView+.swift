//
//  UIImageView+.swift
//  Dragon
//
//  Created by Michael Fourre on 7/28/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView
{
    func makeCircular()
    {
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
    }
}