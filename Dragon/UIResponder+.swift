//
//  UIResponder+.swift
//  Dragon
//
//  Created by Michael Fourre on 10/15/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import UIKit

extension UIResponder {
    func runOnMainThread(_ runnable: (() -> Void)?) {
        MainQueue.sync(runnable)
    }
    
    func runOnBackgroundThread(_ runnable: (() -> Void)?) {
        BackgroundQueue.async(runnable)
    }
}
