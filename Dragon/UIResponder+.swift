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
        guard let block = runnable else
        {
            Log.warning("UIResponder.runOnMainThread(runnable:) received nil runnable")
            return
        }
        
        OperationQueue.main.addOperation(block)
    }
    
    func runOnBackgroundThread(_ runnable: (() -> Void)?)
    {
        guard let block = runnable else
        {
            Log.warning("UIResponder.runOnBackgroundThread(runnable:) received nil runnable")
            return
        }
        
        AppDelegate.backgroundQueue.async(execute: block)
    }
}
