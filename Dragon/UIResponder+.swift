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
        if let block = runnable
        {
            OperationQueue.main.addOperation(block)
        }
        else
        {
            Log.warning("UIResponder.runOnMainThread(runnable:) received nil runnable")
        }
    }
    
    func runOnBackgroundThread(_ runnable: (() -> Void)?)
    {
        if let block = runnable
        {
            AppDelegate.backgroundQueue.async(execute: block)
        }
        else
        {
            Log.warning("UIResponder.runOnBackgroundThread(runnable:) received nil runnable")
        }
    }
}
