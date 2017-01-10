//
//  UIResponder+.swift
//  Dragon
//
//  Created by Michael Fourre on 10/15/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation
import UIKit

extension UIResponder
{
    func runOnMainThread(_ runnable: (() -> Void)?)
    {
        OperationQueue.main.addOperation(runnable ?? {})
    }
    
    func runOnBackgroundThread(_ runnable: (() -> Void)?)
    {
        AppDelegate.backgroundQueue.async(execute: runnable ?? {})
    }
}
