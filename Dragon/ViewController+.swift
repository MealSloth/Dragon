//
//  ViewController+.swift
//  Dragon
//
//  Created by Michael Fourre on 7/27/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController
{
    func runOnMainThread(runnable: (() -> Void)?)
    {
        if let block = runnable
        {
            NSOperationQueue.mainQueue().addOperationWithBlock(block)
        }
        else
        {
            Log.string("UIViewController.runOnMainThread(runnable:) received nil runnable", type: .warning)
        }
    }
    
    func presentViewControllerOnMainThread(viewControllerToPresent: UIViewController, animated: Bool, completion: (() -> Void)?)
    {
        self.runOnMainThread({ () -> Void in
            self.presentViewController(viewControllerToPresent, animated: animated, completion: completion)
        })
    }
}